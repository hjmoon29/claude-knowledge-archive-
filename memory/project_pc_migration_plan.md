---
name: PC 교체 대비 스케줄 작업 이관 계획
description: 원격 routines + 로컬 Windows Task Scheduler 통합 현황. 2026-09-21 Figma/Wiki 주간 학습을 원격→로컬로 이관 완료.
type: project
originSessionId: 96f7c65a-edf4-42d6-a5ea-a6d49bef2a32
---
## 배경
사용자가 PC 교체 예정. 스케줄 작업을 파악하여 PC 교체 시 재설정 부담을 최소화.

**Why:** PC 종속성이 있는 로컬 태스크는 새 PC에서 재등록해야 하므로, 원격으로 옮길 수 있는 건 미리 옮겨두면 이전 작업이 줄어듦.

**How to apply:** PC 교체 D-day에 이 문서의 "재등록 체크리스트" 실행.

## 2026-09-21 발견: 원격 sandbox 프록시 제약
Anthropic 클라우드 routine sandbox는 **Google API만 outbound 허용**. Figma API(`api.figma.com`) 및 사내 Wiki(`wiki.coway.com`) 모두 `Tunnel connection failed: 403 Forbidden`으로 차단됨.
→ **외부 API 호출이 필요한 작업은 로컬 실행 불가피.** 원격 routines는 클라우드 서비스 간 orchestration만 가능한 것으로 보임.

## 현재 등록된 스케줄 작업 (2026-09-21 기준)

### 🌐 원격 Claude Routines (모두 비활성)
| ID | 이름 | 스케줄 | 상태 | 비고 |
|---|---|---|---|---|
| trig_019ByEBdAc3ueJqf77MNA916 | CWIOTSVC Wiki 주간 학습 | 월 09:00 | ⛔ Disabled (2026-09-21) | 로컬 이관 완료, 삭제는 web UI 필요 |
| trig_01A3xR5mTakp4Xb1tsddfLwH | Figma 화면기획서 주간 학습 | 월 09:00 | ⛔ Disabled (2026-09-21) | 로컬 이관 완료, 삭제는 web UI 필요 |
| trig_013QbTcoPH3K89Vpj9CpcYPm | 모션베드 26.8.1 Jira 답변 | 매일 08:10 | ⛔ Disabled | 8월 이후 미사용, 삭제 대기 |

### 💻 로컬 Windows Task Scheduler (Coway/Claude 관련)
| TaskName | 스케줄 | 상태 | 실행 파일 |
|---|---|---|---|
| **ClaudeWeeklyFigma** | 매주 월 09:00 | ✅ Ready | `C:\Users\20020911\scripts\weekly_figma.ps1` → `weekly_figma.py` |
| **ClaudeWeeklyWiki** | 매주 월 09:00 | ✅ Ready | `C:\Users\20020911\scripts\weekly_wiki.ps1` → `weekly_wiki.py` |
| ClaudeKnowledgeArchive | 매일 09:30 | ✅ Ready | `G:\내 드라이브\claude-archive\scripts\archive-knowledge.ps1` |
| ClaudeMCPTokenCheck | 매일 08:15 | ✅ Ready | `C:\Users\20020911\.claude\check-mcp-tokens.ps1` |

**2026-09-22 삭제:** `수면센서 26.9 JIRA 답변 메일`, `JiraToSheets-HourlyUpdate` (관련 스크립트 파일은 유지)

## 2026-09-21 이관 완료 상세

### 로컬 스크립트
- `C:\Users\20020911\scripts\weekly_figma.py` — Figma 63파일 개별 `/files/{key}` 조회, 최근 7일 변경 감지, fail-loud fallback, HTML 이메일
- `C:\Users\20020911\scripts\weekly_wiki.py` — Confluence PAT + CQL 조회, 인증/CQL 실패 시 별도 이메일
- `weekly_figma.ps1`, `weekly_wiki.ps1` — Python 호출 + 로그 파일(`scripts\logs\weekly_*_YYYYMMDD_HHmm.log`)
- Python: `C:\Users\20020911\AppData\Local\Programs\Python\Python312\python.exe`
- 하드코딩된 토큰: Figma `figd_8ONi...` (2026-11-29 만료), Confluence PAT `NzgzNDQ1...` (무기한, name=260908, id=233), Gmail refresh token

### 검증 (2026-09-21 dry-run 결과)
- Figma: 9개 파일 변경 감지 → 이메일 정상 발송 (3.5분 소요)
- Wiki: 17개 페이지 변경 감지 → 이메일 정상 발송 (10초)

## 이관 방침 요약
| # | 태스크 | 조치 | 이유 |
|---|---|---|---|
| 1 | Figma/Wiki 주간 학습 (원격) | ⛔ 비활성 → 삭제(수동) | 원격 sandbox에서 외부 API 접근 불가 |
| 1' | ClaudeWeeklyFigma/Wiki (로컬) | 💻 로컬 신설·유지 | ⬆ 대체 |
| 2 | 수면센서 26.9 JIRA 답변 메일 | 🗑️ 삭제 완료 (2026-09-22) | 미사용 |
| 3 | ClaudeKnowledgeArchive | 💻 로컬 유지 | `G:\내 드라이브` 로컬 마운트 필요 |
| 4 | ClaudeMCPTokenCheck | 💻 로컬 유지 | 로컬 `~/.claude/mcp.json` 조작 |
| 5 | 모션베드 원격 routine | 🗑️ 삭제(수동) | 미사용 |
| 6 | JiraToSheets 로컬 | 🗑️ 삭제 완료 (2026-09-22) | 미사용 |

## PC 교체 D-day 재등록 체크리스트
새 PC에서 재설치/재등록:
- [ ] Claude Code CLI 설치 + `~/.claude/mcp.json` 복원 (백업 필요)
- [ ] Python 3.12 설치 (openpyxl/pandas/requests/Pillow/xlsxwriter)
- [ ] `C:\Users\20020911\scripts\` 폴더 통째 복사
- [ ] `ClaudeWeeklyFigma` Task 재등록 (매주 월 09:00, `weekly_figma.ps1`)
- [ ] `ClaudeWeeklyWiki` Task 재등록 (매주 월 09:00, `weekly_wiki.ps1`)
- [ ] `ClaudeMCPTokenCheck` Task 재등록 (매일 08:15, `check-mcp-tokens.ps1`)
- [ ] Google Drive 설치 + `G:\내 드라이브\claude-archive\` 동기화 대기 + `ClaudeKnowledgeArchive` Task 재등록 (매일 09:30)

## 원격 정리 (사용자 수동 작업)
https://claude.ai/code/routines 에서 아래 3개 routine 완전 삭제:
- CWIOTSVC Wiki 주간 학습 (trig_019By...)
- Figma 화면기획서 주간 학습 (trig_01A3xR...)
- 모션베드 26.8.1 Jira 답변 (trig_013Qb...)

## 관련 파일
- 로컬 스크립트: `C:\Users\20020911\scripts\`
- 로컬 로그: `C:\Users\20020911\scripts\logs\weekly_*_YYYYMMDD_HHmm.log`
- 로컬 MCP 설정: `C:\Users\20020911\.claude\mcp.json`
- 원격 관리 웹: https://claude.ai/code/routines
