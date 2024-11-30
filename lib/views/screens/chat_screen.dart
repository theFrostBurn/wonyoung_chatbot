import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../viewmodels/chat_viewmodel.dart';
import '../widgets/chat_input.dart';
import '../widgets/message_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            '원영적💖사고 채팅',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 17, // iOS 스타일 폰트 크기
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0.5,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: MessageList(),
                ),
                ChatInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
