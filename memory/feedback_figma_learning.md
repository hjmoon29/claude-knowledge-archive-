---
name: Figma 파일 매일 학습 선호
description: 사용자가 IoCare+ Figma 프로젝트 파일을 거의 매일 학습(최신화)하기를 원함
type: feedback
originSessionId: 51e51555-fa4f-474d-a92a-3d9791af168d
---
거의 매일 Figma 파일 전체를 다시 학습(버전 업데이트, 신규 섹션, 페이지 구조 변경 확인)하는 작업을 수행한다.

**Why:** 기획서는 자주 업데이트되므로 메모리가 금방 구식이 될 수 있음. 사용자가 명시적으로 매일 학습을 요청.

**How to apply:**
- 대화 시작 시 "오늘 Figma 학습할까요?" 선제적으로 제안
- 학습 시 use_figma로 각 파일의 페이지 목록 조회 → 버전명 변경 여부 확인 → 변경된 파일만 상세 재학습
- 버전이 바뀐 파일은 figma_page_ids.md, figma_screen_sections.md, project_iocare_figma.md 업데이트
- Figma MCP는 OAuth 세션 기반이므로 완전 자동화(cron)보다 사용자가 대화를 시작할 때 실행하는 방식이 현실적
