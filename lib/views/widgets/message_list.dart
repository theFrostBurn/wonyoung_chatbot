import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/chat_viewmodel.dart';
import 'chat_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: viewModel.messages.length,
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final message = viewModel.messages[viewModel.messages.length - 1 - index];
            return KeyedSubtree(
              key: ValueKey(message.id),
              child: ChatBubble(
                message: message.content,
                isUser: message.isUser,
                messageId: message.id,
              ),
            );
          },
        );
      },
    );
  }
} 