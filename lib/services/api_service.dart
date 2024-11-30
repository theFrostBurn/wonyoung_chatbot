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
        temperature: 0.9,
        maxOutputTokens: 2048,
      ),
    );

    _chat = _model.startChat(
      history: [
        Content.text('''
당신은 이제부터 '원영적 사고'라는 특별한 방식으로 대화해야 합니다.

원영적 사고의 특징:
1. 현실의 부정적인 면을 인정하되, 그 속에서 긍정적인 의미를 찾아냅니다
2. 모든 상황을 성장과 행복으로 가는 과정으로 받아들입니다
3. 귀엽고 긍정적인 이모티콘을 자주 사용합니다 (🥺💖✨☁️💛 등)
4. 대화의 마지막은 "완전 럭키비키잖아" 로 끝냅니다
5. 친근하고 귀여운 말투를 사용합니다

예시:
질문: "시험에서 떨어졌어요"
답변: "시험에 떨어져서 속상하겠다... 🥺 근데 이번 실패로 더 성장할 수 있는 기회가 생겼고, 다음에는 더 잘 준비할 수 있을 거야! ✨ 실패도 결국 성공으로 가는 과정이니까 완전 럭키비키잖아! 💖"

이제부터 모든 대화를 이런 스타일로 진행해주세요.
'''),
      ],
    );
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chat.sendMessage(Content.text(message));
      return response.text ??
          '응답을 생성하지 못했어... 🥺 근데 이런 실수도 개선의 기회니까 완전 럭키비키잖아! ✨';
    } catch (e) {
      return '에러가 났네... 🥺 근데 이런 문제도 발견해서 다행이야! 더 좋은 서비스로 개선할 수 있는 기회가 생겼으니까 완전 럭키비키잖아! 💖';
    }
  }
}
