import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/screens/chat_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("환경 변수 파일을 찾을 수 없습니다: $e");
    // 개발 환경을 위한 기본값 설정
    dotenv.env['GEMINI_API_KEY'] = 'your_default_key_here';
  }

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '원영적💖사고 채팅',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B7280),
          primary: const Color(0xFF6B7280),
          secondary: const Color(0xFF9CA3AF),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
