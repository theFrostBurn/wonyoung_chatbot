import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final Set<String> _animatedMessageIds = {};

  List<ChatMessage> get messages => _messages;

  bool shouldAnimateMessage(String messageId) {
    if (_animatedMessageIds.contains(messageId)) {
      return false;
    }
    _animatedMessageIds.add(messageId);
    return true;
  }

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

    // 봇 응답 시뮬레이션
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