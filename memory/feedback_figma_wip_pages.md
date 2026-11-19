---
name: feedback-figma-wip-pages
description: "Figma '작업안' 페이지 항목은 미확정 작업중 UX — 확정 UX 검색 결과에서 제외"
metadata:
  node_type: memory
  type: feedback
  originSessionId: f58d7dee-93d5-4d1a-b1a6-7d4bf240cb79
  modified: 2026-11-18T23:43:17.506Z
---

Figma 화면기획 파일의 **'작업안' 페이지**에 있는 프레임·섹션은 정식 기획 UX가 아니라 작업중인 내용으로 간주한다. 확정된 UX를 찾거나 정리할 때는 결과에서 제외한다.

또한 **'SPEC 제외'(오픈 SPEC 제외·Spec 제외·스펙 제외 등) 표시로 덮인 영역**도 UX 스펙에서 빠진 부분이므로 확정 UX 검색에서 제외한다. 덮개는 보통 별도 프레임/사각형이라 이름 매칭만으론 부족 — 같은 페이지에서 덮개 bbox와 대상 프레임 bbox가 겹치는지(또는 덮개가 대상 하위에 있는지) 확인해야 한다.

**Why:** 사용자가 2026-11-19 동의 화면 URL 검색 결과에 작업안 항목이 섞이자 직접 정정함. 작업안은 말 그대로 검토·수정 중인 안이다.
**How to apply:** Figma 검색·학습 시 페이지 이름이 '작업안'이면 확정 UX 목록에서 빼고, 필요하면 "작업중(미확정)"으로 따로 표기한다. '작업본'·'99_test' 같은 비슷한 페이지는 확정 여부를 사용자에게 확인한다. 관련: [[figma_screen_sections]] [[figma_page_ids]]
