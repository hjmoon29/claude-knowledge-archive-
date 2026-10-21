---
name: feedback-sheet-merged-cells
description: "소모품 정의서 등 구글시트 읽을 때 병합 셀 확인 필수 — 빈칸이 '없음'이 아니라 옆 셀 값이 병합된 것일 수 있음"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d85b8d1b-3b66-4540-a095-66c77321fab0
  modified: 2026-10-21T02:16:53.821Z
---

구글시트(특히 CW_IoCare_소모품_정의서)를 읽을 때 빈 셀을 "없음/미지원"으로 해석하지 말고, 병합 셀(merges)인지 확인할 것. 예: 개인형 비데 탭 11행(교체 가이드 영상) 슬리믹 U11:V11 병합 → 두 소모품 모두 영상 있음. 10행(구매 URL) 더블케어 P10:S10, 슬리믹 U10:V10 병합.

**Why:** 2026-10-21 값만 읽고 "프리 마이크로 필터만 영상"으로 위키에 잘못 적어 사용자가 정정함.

**How to apply:** get_sheet_data는 병합 정보를 안 주므로, 빈칸이 있는 행은 include_grid_data=true로 해당 셀만 좁게 조회해 `merges`를 확인. "-"는 명시적 미지원, 공란은 병합 여부 확인 대상. 관련: [[reference-consumable-source-docs]]
