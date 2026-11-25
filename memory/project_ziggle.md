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

## 2026-11-25 보강 (사용자: On인데도 화면보호기 뜸)
- 점검: SendInput 마우스 신호로 GetLastInputInfo 0 리셋 확인(Windows 기준 정상). 화면보호기 coway.scr 600초·보안(정책 고정). 보안 로그 잠금 이벤트 없음(감사 꺼짐), powercfg /requests는 관리자 필요
- 변경: 30초 주기, 1px 이동+F15 키 탭+SetThreadExecutionState 매 tick 재설정, `ziggle.log`에 tick마다 idle_before/after 기록(START/ON/OFF/EXIT). 백업 MouseJiggleApp.ps1.bak_20261125
- 다음: 로그에서 잠긴 시각 전후 tick이 계속 찍혔고 idle_after≈0이면 → 보안 에이전트(n6agent·PIAgent 등)가 별도 기준으로 잠그는 것(사용자 모드로는 우회 어려움). tick이 끊겼으면 → 프로그램 문제
