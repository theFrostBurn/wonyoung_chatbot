import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/chat_viewmodel.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    context.read<ChatViewModel>().sendMessage(_controller.text);
    setState(() {
      _isComposing = false;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ChatViewModel, bool>((vm) => vm.isLoading);

    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter &&
            !HardwareKeyboard.instance.isShiftPressed) {
          if (_isComposing && !isLoading) {
            _sendMessage();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground.resolveFrom(context),
          border: Border(
            top: BorderSide(
              color: CupertinoColors.separator.resolveFrom(context),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6.resolveFrom(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    onChanged: (text) {
                      setState(() {
                        _isComposing = text.isNotEmpty;
                      });
                    },
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: null,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요',
                      hintStyle: TextStyle(
                        color: CupertinoColors.systemGrey.resolveFrom(context),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: null,
                    onEditingComplete: () {},
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedOpacity(
                opacity: _isComposing ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 200),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: (_isComposing && !isLoading) ? _sendMessage : null,
                  child: isLoading
                      ? const CupertinoActivityIndicator()
                      : Icon(
                          CupertinoIcons.arrow_up_circle_fill,
                          size: 32,
                          color: _isComposing
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.systemGrey3,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
