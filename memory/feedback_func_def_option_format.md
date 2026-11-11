---
name: feedback-func-def-option-format
description: "IoT기능정의서 옵션값·옵션명은 값마다 줄바꿈(셀 내 \\n)으로 작성하는 사내 규칙, ' / ' 나열 금지. 신규·미정의 값은 빨간 굵은 '미정'"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 17a12527-f127-419b-8cba-3c2e9e863deb
  modified: 2026-11-11T01:28:05.900Z
---

IoT기능정의서(CW_IoCare_제품_기능정의서)의 '지수/프로토콜 옵션값'·'APP 표출 옵션명' 칸은 **값 하나당 한 줄(셀 내 줄바꿈)** 으로 쓴다. `0 / 1 / 2` 처럼 슬래시로 나열하지 않는다. 범위값(`0 ~ 65535`)은 한 줄 그대로.
기존에 없던 신규 값·정의되지 않은 값은 TBD·(신규) 대신 **'미정'**(빨간 굵은 글씨)으로 표기.

**Why:** 사내 규칙 (2026-11-11 사용자 명시). 개인형 비데 시트 다른 모델 열은 모두 줄바꿈인데 좌욕스파비데 열만 슬래시로 작성해서 지적받음.
**How to apply:** 기능정의서 작성·수정 시 처음부터 줄바꿈으로 입력. 셀 내용을 텍스트로 덤프할 때 줄바꿈을 ' / '로 치환하면 원본이 슬래시인 것처럼 보이니 주의(이번에 오판 원인). 관련: [[reference-iot-func-def]], [[feedback-doc-version-backup]]
