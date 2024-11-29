# 프로젝트 구조 

lib/
├── main.dart
├── models/
│   ├── chat_message.dart
│   └── user.dart
├── viewmodels/
│   └── chat_viewmodel.dart
├── views/
│   ├── screens/
│   │   └── chat_screen.dart
│   └── widgets/
│       ├── chat_bubble.dart
│       ├── chat_input.dart
│       └── message_list.dart
└── services/
    └── api_service.dart


## 각 디렉토리 설명

### models/
- 앱에서 사용되는 데이터 구조를 정의
- 데이터 변환 및 유효성 검사 로직 포함

### viewmodels/
- MVVM 패턴의 ViewModel 레이어
- 비즈니스 로직 처리
- 상태 관리 및 데이터 가공

### views/
- UI 관련 코드
- screens/: 전체 화면 단위의 위젯
- widgets/: 재사용 가능한 작은 단위의 위젯

### services/
- 외부 API 통신 로직
- 데이터 영속성 관련 코드

## 주요 파일 설명

### main.dart
- 앱의 시작점
- 전역 설정 및 테마 정의
- 의존성 주입 설정

### chat_message.dart
- 채팅 메시지의 데이터 구조 정의
- 메시지 ID, 내용, 발신자 구분, 타임스탬프 등 포함

### chat_viewmodel.dart
- 채팅 관련 비즈니스 로직 처리
- 메시지 목록 관리
- API 통신 상태 관리

### chat_screen.dart
- 메인 채팅 화면 UI
- 메시지 목록과 입력 필드 구성

### api_service.dart
- Google Gemini API 통신 처리
- API 요청/응답 처리
- 에러 핸들링