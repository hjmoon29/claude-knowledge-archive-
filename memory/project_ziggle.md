---
name: project-ziggle
description: "Ziggle 마우스 지글러(트레이 On/Off, 화면보호기 방지) — PowerShell WinForms, exe는 회사 보안이 삭제 (2026-11-05)"
metadata:
  node_type: memory
  type: project
  originSessionId: 8b8e1358-47f9-4634-8dec-6a405919a4aa
  modified: 2026-11-05T06:47:08.096Z
---

Ziggle = 화면보호기 방지용 마우스 지글러 (2026-11-05 완성, 사용자 "잘 보인다" 확인).
- 파일: `C:\Users\20020911\scripts\mouse_jiggle\MouseJiggleApp.ps1`(UTF-8 BOM 저장) + `start_mouse_jiggle.vbs`(창없이 실행) + `app\icon.ico`/`icon_off.ico`
- 바탕화면 `ziggle.lnk` → wscript vbs
- 시작프로그램 폴더에 `ziggle.lnk` 등록 (부팅 시 자동 실행, 해제는 lnk 삭제)
- 동작: 트레이 전용, 실행 시 **Off**(사용자 요청), 50초마다 5px 대각 이동 후 복귀 + SetThreadExecutionState. 좌클릭 토글, 우클릭 On/Off/Exit, Off는 회색 아이콘. 영어 UI. 고정값(설정 UI 없음)

**Why:** 사용자가 창·설정 없이 트레이에서 On/Off만 원함 (창 앱→간소화→트레이 순으로 변경됨).
**How to apply:** 회사 PC에서 csc로 만든 서명 없는 exe는 보안 프로그램이 즉시 삭제함 → 앱은 PowerShell+vbs 방식으로. 테스트로 프로세스 강제 종료 시 트레이에 옛 아이콘 잔상이 남아 혼동 주의.
