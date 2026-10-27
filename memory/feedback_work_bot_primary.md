---
name: feedback-work-bot-primary
description: "사용자는 반복 업무를 Claude 대화창보다 업무 봇(bot-hub, 127.0.0.1:8765) 화면에서 주로 처리하려 함 (2026-10-26)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: df41bfaf-d1e5-49bd-91d2-933e86e11851
  modified: 2026-10-26T06:48:21.226Z
---

업무 봇 화면을 주 작업 공간으로 쓰고, Claude 대화창은 봇에 없는 일·봇 수정·문제 해결에 쓰는 방식을 선호한다 (2026-10-26 사용자 발언: "이 클로드 창을 통해 쓰기보다는 업무 봇 화면에서 주로 작업을 하는식으로 하고자해").

**Why:** 반복 기획 업무(하위문서·사양 정리·QA·IMS 조회 등)를 버튼으로 돌리고, 결과를 미리보기/엑셀로 검토 후 반영하는 흐름을 원함.
**How to apply:** 대화에서 같은 유형의 반복 작업 요청이 오면 업무 봇에 해당 기능이 있는지 먼저 안내하고, 없으면 봇에 기능 추가를 제안. 봇 실행/종료·오류 대응을 빠르게 지원. 관련: [[project-work-bot]]
