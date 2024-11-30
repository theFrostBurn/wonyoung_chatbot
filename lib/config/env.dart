import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKey {
    // dart-define 값이 있으면 우선 사용
    const defineKey = String.fromEnvironment('GEMINI_API_KEY');
    if (defineKey.isNotEmpty) return defineKey;

    // 없으면 .env 파일의 값 사용
    return dotenv.env['GEMINI_API_KEY'] ?? '';
  }
}
