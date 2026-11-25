---
name: feedback-qa-version-notation
description: 일정표의 QA·운영배포 칸 'YY.M'은 날짜가 아니라 앱 QA 버전 표기 (27.2 = 27년 2월 QA 버전)
metadata:
  type: feedback
---
위키·일정표의 IoT QA(및 운영배포) 칸에 적힌 `27.2(미정)` 같은 값은 날짜가 아니라 **QA 버전 표기 규칙**이다. 27.2 = 27년 2월에 진행되는 QA(앱 v27.2). 출시월 직전 달 버전이 보통이다(3월 출시 → 27.2 QA).

**Why:** 2026-11-25 좌욕스파 비데 위키에서 '28.2'를 날짜 오류로 오해할 뻔함 — 사용자가 규칙 설명 후 27.2로 수정 지시.
**How to apply:** 일정 해석·작성 시 QA 칸은 버전으로 읽고, 출시일과 맞는지(출시 전월 버전인지) 점검. 관련: [[project_spa_bidet_usage_report]]
