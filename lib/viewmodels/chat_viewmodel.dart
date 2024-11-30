import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/api_service.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final Set<String> _animatedMessageIds = {};
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  ChatViewModel() {
    _apiService.initialize();
  }

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  bool shouldAnimateMessage(String messageId) {
    if (_animatedMessageIds.contains(messageId)) {
      return false;
    }
    _animatedMessageIds.add(messageId);
    return true;
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.sendMessage(content);

      final botMessage = ChatMessage(
        id: DateTime.now().toString(),
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(botMessage);
    } catch (e) {
      final errorMessage = ChatMessage(
        id: DateTime.now().toString(),
        content: '메시지 전송 중 오류가 발생했습니다.',
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
