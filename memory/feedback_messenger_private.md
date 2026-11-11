---
name: feedback-messenger-private
description: 메신저 대화를 요약·표시할 때 사적인 대화는 절대 포함하지 않는다 (업무 내용만)
metadata:
  node_type: memory
  type: feedback
  originSessionId: c0755bc3-e333-4c4c-a9e5-95c08a271a38
  modified: 2026-11-11T01:47:06.081Z
---

메신저(네이버웍스) 내용을 월페이퍼·리포트·요약 등에 쓸 때는 업무 내용만 쓰고, 사적인 대화(식사·안부·잡담, 개인 일정·가족·건강, 사람 평가, 인사·연봉 등)는 절대 넣지 않는다. 애매하면 뺀다. 다른 사람 휴가는 사유 없이 '부재'로만.

**Why:** 2026-11-11 사용자 지시 — "메신저 상에서 사적인 대화를 나눈 부분은 당연히 해당 월페이퍼에 들어가면 안됨". 바탕화면은 남에게 보일 수 있음.
**How to apply:** 메신저를 읽는 모든 자동화(캘린더 월페이퍼 morning_routine.py 프롬프트에 규칙 반영됨, 업무봇 내 할 일 등) 프롬프트에 이 규칙을 넣는다. 관련 [[project-calendar-wallpaper]]
