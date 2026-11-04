---
name: project-scheduled-tasks-hidden
description: Claude 예약 작업 8개는 scripts\run_hidden.vbs(wscript)로 창 없이 실행 — 아침 터미널 창 다발 원인·조치 (2026-11-04)
metadata:
  node_type: memory
  type: project
  originSessionId: 857b9b24-4336-4825-8428-5a0947629e35
  modified: 2026-11-03T23:59:11.465Z
---

2026-11-04: 아침 08:02 터미널 창 여러 개 = StartWhenAvailable로 밀린 Claude* 예약 작업이 로그인 직후 일괄 실행되며 powershell/python 콘솔이 깜빡인 것 (ClaudeKnowledgeArchive는 -WindowStyle Hidden도 없었음).

조치:
- 새 작업 추가 시에도 `wscript.exe "C:\Users\20020911\scripts\run_hidden.vbs" <powershell 인자>` 형태로 등록할 것 (VBS는 ASCII만, 한글 주석 금지)
- 적용 작업: ClaudeDriveUpload·MCPTokenCheck·KnowledgeArchive·WeeklyWiki·WeeklyFigma·LunchStatusMail·DailySummary·AllPCsSummary
- 원본 XML 백업: scripts\task_backup_20261104\ (Register-ScheduledTask -Xml 로 복구)
- 일회성 ClaudeMonthlyResend_20261020 삭제
- 아침 보충 실행(StartWhenAvailable) 축소는 사용자 미선택 → 그대로 유지
- MCP health check의 atlassian/google-sheets 60초 타임아웃은 이전(11/02)에도 간헐 발생 — 창 숨김과 무관

관련: [[project-cross-pc-usage-doc]]
