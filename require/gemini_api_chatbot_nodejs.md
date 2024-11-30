#대화형 채팅 빌드

Gemini API를 사용하여 사용자를 위한 양방향 채팅 환경을 빌드할 수 있습니다. API의 채팅 기능을 사용하면 여러 번의 질문과 응답을 수집할 수 있으므로 사용자가 점진적으로 답변을 찾거나 여러 부분으로 구성된 문제와 관련하여 도움을 받을 수 있습니다. 이 기능은 챗봇, 양방향 교사, 고객 지원 어시스턴트와 같이 지속적인 커뮤니케이션이 필요한 애플리케이션에 적합합니다.

다음 코드 예는 기본 채팅 구현을 보여줍니다.


// Make sure to include these imports:
// import { GoogleGenerativeAI } from "@google/generative-ai";
const genAI = new GoogleGenerativeAI(process.env.API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
const chat = model.startChat({
  history: [
    {
      role: "user",
      parts: [{ text: "Hello" }],
    },
    {
      role: "model",
      parts: [{ text: "Great to meet you. What would you like to know?" }],
    },
  ],
});
let result = await chat.sendMessage("I have 2 dogs in my house.");
console.log(result.response.text());
result = await chat.sendMessage("How many paws are in my house?");
console.log(result.response.text());