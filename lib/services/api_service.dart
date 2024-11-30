import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/env.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final GenerativeModel _model;
  late final ChatSession _chat;

  void initialize() {
    _model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: Env.apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        maxOutputTokens: 2048,
      ),
    );
    _chat = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chat.sendMessage(Content.text(message));
      return response.text ?? '응답을 생성하지 못했습니다.';
    } catch (e) {
      return '오류가 발생했습니다: $e';
    }
  }
}
