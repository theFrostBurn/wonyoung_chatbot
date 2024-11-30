# 튜토리얼: Gemini API 시작하기 for Dart (Flutter)



주의: Dart용 Google AI SDK (Flutter)를 사용하여 Google AI 앱에서 직접 Gemini API를 사용하는 것은 프로토타입 제작에만 권장됩니다. 대상 프로토타입을 제작하지 않는 경우 SDK를 사용하여 Google AI Gemini API를 서버 측에서만 생성하여 API 키를 안전하게 보호합니다. 만약 API 키를 모바일 또는 웹 앱에 직접 삽입하거나 다음 위치에서 원격으로 가져올 수 있습니다. API 키가 악의적인 행위자에게 노출될 위험이 있습니다.
이 튜토리얼에서는 Dart용 Gemini API에 액세스하는 방법을 Flutter 애플리케이션입니다. 다음과 같은 경우에 이 SDK를 사용할 수 있습니다. Google Cloud의 Gemini 모델에 액세스하기 위해 REST API를 있습니다.

이 튜토리얼에서는 다음 작업을 수행하는 방법을 알아봅니다.

API 키를 포함한 프로젝트 설정
텍스트 전용 입력에서 텍스트 생성
텍스트 및 이미지 입력에서 텍스트 생성 (멀티모달)
멀티턴 대화 빌드 (채팅)
스트리밍을 사용하여 상호작용 속도 향상
또한 이 튜토리얼에는 고급 사용 사례 (예: 임베딩 및 토큰 계산) 및 콘텐츠 생성을 제어하는 방법을 알아봅니다.

팁: 샘플 앱 이 SDK를 빠르게 사용해 보거나 다양한 사용 사례를 지원합니다 샘플 앱을 실행하려면 기본 요건과 설명된 대로 API 키가 필요합니다. 참조하세요.
기본 요건
이 튜토리얼에서는 개발자가 Dart를 사용해 애플리케이션을 빌드하는 데 익숙하다고 가정합니다.

이 튜토리얼을 완료하려면 개발 환경이 다음 요구사항을 충족해야 합니다

Dart 3.2.0 이상
프로젝트 설정
Gemini API를 호출하기 전에 다음을 포함한 프로젝트를 설정해야 합니다. API 키 설정, pub 종속 항목에 SDK 추가, 모델을 초기화합니다.

API 키 설정
Gemini API를 사용하려면 API 키가 필요합니다. 아직 계정이 없는 경우 Google AI Studio에서 키를 만듭니다

API 키 가져오기

API 키 보호
API 키를 안전하게 보호하세요. Google에서는 태그에 포함되지 않는 것이 좋습니다. API 키를 코드에 직접 삽입하거나 키가 포함된 파일을 버전으로 확인 제어할 수 있습니다 대신 API 키에 보안 비밀 저장소를 사용해야 합니다.

이 튜토리얼의 모든 스니펫은 사용자가 자신의 API 키를 프로세스 환경 변수입니다 Flutter 앱을 개발하는 경우 String.fromEnvironment 및 --dart-define=API_KEY=$API_KEY를 flutter build 또는 flutter run: 프로세스 이후 API 키로 컴파일함 환경도 다릅니다

SDK 패키지 설치
내 애플리케이션에서 Gemini API를 사용하려면 다음을 add해야 합니다. google_generative_ai 패키지를 Dart 또는 Flutter 앱에 추가합니다.

Dart
Flutter

dart pub add google_generative_ai
생성 모델 초기화
API를 호출하려면 먼저 생성 모델입니다.


import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {

  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }

  // The Gemini 1.5 models are versatile and work with most use cases
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
}
모델을 지정할 때는 다음 사항에 유의하세요.

사용 사례에 맞는 모델을 사용하세요 (예: gemini-1.5-flash). 멀티모달 입력용). 본 가이드에 나와 있는 각 각 사용 사례의 추천 모델을 나열합니다.

참고: 사용 가능한 모델에 대한 자세한 내용은 기능 및 비율 제한에 관해서는 Gemini 모델을 참고하세요. 제공 서비스 비율 제한 상향 요청의 옵션이 있는 경우 기본값만으로는 충분하지 않습니다.
일반적인 사용 사례 구현
이제 프로젝트가 설정되었으므로 Gemini API를 사용하여 다양한 사용 사례 구현:

텍스트 전용 입력에서 텍스트 생성
텍스트 및 이미지 입력에서 텍스트 생성 (멀티모달)
멀티턴 대화 빌드 (채팅)
스트리밍을 사용하여 상호작용 속도 향상
고급 사용 사례 섹션에서 Gemini API에 관한 정보를 찾을 수 있습니다. 및 임베딩입니다.

텍스트 전용 입력에서 텍스트 생성
프롬프트 입력에 텍스트만 포함된 경우에는 Gemini 1.5 모델을 사용하거나 generateContent를 사용하여 텍스트 출력을 생성하는 Gemini 1.0 Pro 모델:


import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
  // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [Content.text('Write a story about a magic backpack.')];
  final response = await model.generateContent(content);
  print(response.text);
}
참고: Gemini API는 스트리밍도 지원합니다. 자세한 내용은 더 빠른 상호작용을 위해 스트리밍을 사용합니다 (이 가이드).
텍스트 및 이미지 입력에서 텍스트 생성 (멀티모달)
Gemini는 멀티모달 입력을 처리할 수 있는 다양한 모델을 제공합니다. (Gemini 1.5 모델)을 사용하여 두 텍스트를 모두 입력할 수 있습니다. 살펴보겠습니다 이 프롬프트의 이미지 요구사항을 참고하세요.

프롬프트 입력에 텍스트와 이미지가 모두 포함된 경우 Gemini 1.5 모델을 사용합니다. generateContent 메서드를 사용하여 텍스트 출력을 생성합니다.


import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
  // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final (firstImage, secondImage) = await (
    File('image0.jpg').readAsBytes(),
    File('image1.jpg').readAsBytes()
  ).wait;
  final prompt = TextPart("What's different between these pictures?");
  final imageParts = [
    DataPart('image/jpeg', firstImage),
    DataPart('image/jpeg', secondImage),
  ];
  final response = await model.generateContent([
    Content.multi([prompt, ...imageParts])
  ]);
  print(response.text);
}
참고: Gemini API는 스트리밍도 지원합니다. 자세한 내용은 더 빠른 상호작용을 위해 스트리밍을 사용합니다 (이 가이드).
멀티턴 대화 빌드 (채팅)
Gemini를 사용하면 여러 차례에 걸쳐 자유 형식의 대화를 구축할 수 있습니다. 이 SDK는 대화 상태를 관리하여 프로세스를 간소화하므로 generateContent를 사용하면 대화 기록을 저장할 필요가 없습니다. 확인할 수 있습니다

채팅과 같은 멀티턴 대화를 빌드하려면 Gemini 1.5 모델 또는 Gemini 1.0 Pro 모델을 빌드하고 startChat()를 호출하여 채팅을 초기화합니다. 그런 다음 sendMessage()를 사용하여 새 사용자 메시지를 전송합니다. 이 메시지에는 채팅 기록에 대한 응답을 반환합니다.

role 대화:

user: 프롬프트를 제공하는 역할입니다. 이 값은 sendMessage를 호출하고 다른 역할이 전달됩니다.

model: 응답을 제공하는 역할입니다. 이 역할은 다음과 같은 경우에 사용할 수 있습니다. 기존 history로 startChat()를 호출합니다.


import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
  // The Gemini 1.5 models are versatile and work with multi-turn conversations (like chat)
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 100));
  // Initialize the chat
  final chat = model.startChat(history: [
    Content.text('Hello, I have 2 dogs in my house.'),
    Content.model([TextPart('Great to meet you. What would you like to know?')])
  ]);
  var content = Content.text('How many paws are in my house?');
  var response = await chat.sendMessage(content);
  print(response.text);
}
참고: Gemini API는 스트리밍도 지원합니다. 자세한 내용은 더 빠른 상호작용을 위해 스트리밍을 사용 (이 가이드 내)
스트리밍을 사용하여 상호작용 속도 향상
기본적으로 모델은 전체 생성이 완료된 후 응답을 반환합니다. 프로세스입니다 전체 응답을 기다리지 않아도 더 빠르게 상호작용을 할 수 있습니다. 대신 스트리밍을 사용하여 부분 결과를 처리합니다.

다음 예는 텍스트 및 이미지 입력에서 텍스트를 생성하는 generateContentStream 메서드 메시지가 표시됩니다.


// ...

final response = model.generateContentStream([
  Content.multi([prompt, ...imageParts])
]);
await for (final chunk in response) {
  print(chunk.text);
}

// ...
텍스트 전용 입력 및 채팅 사용 사례에도 유사한 접근 방식을 사용할 수 있습니다.


// Use streaming with text-only input
final response = model.generateContentStream(content);

// Use streaming with multi-turn conversations (like chat)
final response = chat.sendMessageStream(content);
고급 사용 사례 구현
이 튜토리얼의 이전 섹션에 설명된 일반적인 사용 사례는 Gemini API 사용에 익숙해지세요 이 섹션에서는 고급 사용 사례를 살펴보겠습니다

함수 호출
함수 호출을 통해 구조화된 데이터 출력을 더 쉽게 가져올 수 있음 살펴보겠습니다 그런 다음 이러한 출력을 사용하여 다른 API를 호출하고 모델에 전달합니다. 즉, 함수 호출은 생성 모델을 외부 시스템에 연결하여 생성된 콘텐츠가 가장 정확한 최신 정보가 포함됩니다. 자세히 알아보기: 함수 호출 튜토리얼을 참조하세요.

임베딩 사용
임베딩은 정보를 표현하는 데 사용되는 기법 배열의 부동 소수점 숫자 목록으로 표시할 수 있습니다. Gemini를 사용하면 텍스트 (단어, 문장 및 텍스트 블록)를 벡터화된 형태로 임베딩을 더 쉽게 비교하고 대조할 수 있습니다 예를 들어 비슷한 주제나 감정에 비슷한 임베딩을 가져야 합니다. 코사인 유사성과 같은 수학적 비교 기법을 통해 식별됩니다.

embedding-001 모델을 embedContent 메서드 (또는 batchEmbedContent 메서드)를 사용하여 임베딩을 생성합니다. 다음 예를 참고하세요. 는 단일 문자열에 대한 임베딩을 생성합니다.


final model = GenerativeModel(model: 'embedding-001', apiKey: apiKey);
final content = Content.text('The quick brown fox jumps over the lazy dog.');
final result = await model.embedContent(content);
print(result.embedding.values);
토큰 수 계산
긴 프롬프트를 사용할 때는 모델에 추가할 수 있습니다. 다음 예는 countTokens() 사용 방법을 보여줍니다. 다음과 같이 다양한 사용 사례에 활용할 수 있습니다.


// For text-only input
final tokenCount = await model.countTokens(Content.text(prompt));
print('Token count: ${tokenCount.totalTokens}');

// For text-and-image input (multimodal)
final tokenCount = await model.countTokens([
  Content.multi([prompt, ...imageParts])
]);
print('Token count: ${tokenCount.totalTokens}');

// For multi-turn conversations (like chat)
final prompt = Content.text(message);
final allContent = [...chat.history, prompt];
final tokenCount = await model.countTokens(allContent);
print('Token count: ${tokenCount.totalTokens}');
콘텐츠 생성을 제어하는 옵션
모델 매개변수를 구성하고 모델 매개변수를 사용하여 콘텐츠 생성을 제어할 수 있습니다. 안전 설정을 변경할 수 있습니다.

모델 요청에 generationConfig 또는 safetySettings를 전달합니다. 메서드 (예: generateContent)는 구성 객체를 완전히 재정의합니다. getGenerativeModel에 전달된 것과 같은 이름이 포함됩니다.

모델 매개변수 구성
모델로 보내는 모든 프롬프트에는 모델이 응답을 생성합니다. 모델은 서로 다른 매개변수 값에 대해 서로 다른 결과를 생성할 수 있습니다. 다음에 대해 자세히 알아보기 모델 매개변수. 구성은 모델 인스턴스의 수명 동안 유지됩니다.


final generationConfig = GenerationConfig(
  stopSequences: ["red"],
  maxOutputTokens: 200,
  temperature: 0.9,
  topP: 0.1,
  topK: 16,
);
final model = GenerativeModel(
  // The Gemini 1.5 models are versatile and work with most use cases
  model: 'gemini-1.5-flash',
  apiKey: apiKey,
  generationConfig: generationConfig,
);
안전 설정 사용
안전 설정을 사용하여 유해할 수 있습니다. 기본적으로 안전 설정은 매체가 포함된 콘텐츠를 차단합니다. 또는 모든 측정기준에서 안전하지 않은 콘텐츠일 가능성이 높음 알아보기 안전 설정에 관해 자세히 알아보세요.

하나의 안전 설정을 지정하는 방법은 다음과 같습니다.


final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high)
];
final model = GenerativeModel(
  // The Gemini 1.5 models are versatile and work with most use cases
  model: 'gemini-1.5-flash',
  apiKey: apiKey,
  safetySettings: safetySettings,
);
둘 이상의 안전 설정을 지정할 수도 있습니다.


final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
];
