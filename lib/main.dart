import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // SystemChrome 사용을 위한 import
import 'views/screens/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  // Flutter 바인딩 초기화
  
  // 시스템 UI 설정
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
      title: 'Wonyoung AI Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B7280),
          primary: const Color(0xFF6B7280),
          secondary: const Color(0xFF9CA3AF),
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
