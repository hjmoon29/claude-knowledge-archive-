---
name: feedback-sheet-strikethrough-removed
description: 모델별 기본정보 등 기획 시트에서 취소선+회색 글자 행은 취소·목록 제외된 모델 — 값만 읽지 말고 서식 확인
metadata:
  type: feedback
---
모델별 기본 정보 및 기능정의 등 사내 기획 시트에서 **행 텍스트에 취소선이 있고 글자색이 회색이면 그 모델은 취소됐거나 목록에서 제외된 것**이다 (2026-11-25 사용자 지적: 1.0 탭 8~9행 아이콘 스탠드 싱가포르향 02FTY/02FTZ를 내가 '1.0 시트에만 있음 → 확인 필요'로 잘못 분류).

**Why:** values API로 값만 읽으면 취소선·색상이 안 보여서 제외 모델을 유효 모델로 오인함.
**How to apply:** 시트에서 모델 목록을 뽑거나 대조할 때 `fields=sheets(data(rowData(values(formattedValue,effectiveFormat/textFormat(strikethrough,foregroundColor),textFormatRuns))))`로 서식도 함께 조회해 취소선 행은 '제외'로 처리. 관련: [[feedback-sheet-merged-cells]], [[project_iocare1_wp_migration]]
