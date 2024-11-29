import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    final message = ChatMessage(
      id: DateTime.now().toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(message);
    notifyListeners();

    // 봇 응답 시뮬레이션 (나중에 실제 API 응답으로 대체)
    Future.delayed(const Duration(seconds: 1), () {
      final botMessage = ChatMessage(
        id: DateTime.now().toString(),
        content: "죄송합니다. 아직 API가 연결되지 않았습니다.",
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(botMessage);
      notifyListeners();
    });
  }
} 