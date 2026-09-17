---
name: PC 교체 대비 스케줄 작업 이관 계획
description: 원격 routines + 로컬 Windows 작업 스케줄러 통합/이관 계획. 새 PC 이전 시 재설정 최소화 목적 (2026-09-16 수립, 실행 보류)
type: project
originSessionId: 96f7c65a-edf4-42d6-a5ea-a6d49bef2a32
---
## 배경
사용자가 곧 PC 교체 예정. 현재 스케줄 작업이 원격(claude.ai routines)과 로컬(Windows Task Scheduler)에 분산되어 있어, PC 교체 시 재설정 부담 최소화가 목표.

**Why:** PC 종속성이 있는 로컬 태스크는 새 PC에서 재등록해야 하므로, 원격으로 옮길 수 있는 건 미리 옮겨두면 이전 작업 자체가 사라짐.

**How to apply:** 사용자가 "PC 교체 관련 스케줄 이관" 재개 시 이 문서를 기준으로 진행. Phase 1(원격 이관)부터 순차 실행.

## 현재 등록된 스케줄 작업 (2026-09-16 기준)

### 🌐 원격 Claude Routines (3개)
| ID | 이름 | 스케줄 (KST) | 상태 |
|---|---|---|---|
| trig_019ByEBdAc3ueJqf77MNA916 | CWIOTSVC Wiki 주간 학습 | 월 09:00 | ✅ Active |
| trig_01A3xR5mTakp4Xb1tsddfLwH | Figma 화면기획서 주간 학습 | 월 09:00 | ✅ Active |
| trig_013QbTcoPH3K89Vpj9CpcYPm | 모션베드 26.8.1 Jira 답변 | 매일 08:10 | ⛔ Disabled (정리 대상) |

### 💻 로컬 Windows Task Scheduler (4개, Coway/Claude 관련)
| TaskName | 스케줄 | 상태 | 실행 파일 |
|---|---|---|---|
| 수면센서 26.9 JIRA 답변 메일 | 매일 08:10 KST | ✅ Ready | `C:\Users\20020911\scripts\run_motionbed.ps1` |
| ClaudeKnowledgeArchive | 매일 09:30 KST | ✅ Ready | `G:\내 드라이브\claude-archive\scripts\archive-knowledge.ps1` |
| ClaudeMCPTokenCheck | 매일 08:15 KST | ✅ Ready | `C:\Users\20020911\.claude\check-mcp-tokens.ps1` |
| JiraToSheets-HourlyUpdate | 매시간 | ⛔ Disabled | `C:\Users\20020911\scripts\jira-to-sheets\run.bat` (정리 대상) |

## 이관 방침
| # | 태스크 | 조치 | 이유 |
|---|---|---|---|
| 1 | 수면센서 26.9 JIRA 답변 메일 | 🌐 **원격 이관** | Jira·Figma·Gmail 전부 클라우드 API. 로컬 의존 없음. |
| 2 | CWIOTSVC Wiki / Figma 주간 학습 | 그대로 유지 | 이미 원격 |
| 3 | ClaudeKnowledgeArchive | 💻 로컬 유지 | `G:\내 드라이브` 로컬 마운트 필요. 새 PC에 Drive 재설치 후 재등록. |
| 4 | ClaudeMCPTokenCheck | 💻 로컬 유지 | 로컬 `~/.claude/mcp.json` 조작. 새 PC 재등록. |
| 5 | 모션베드 26.8.1 (원격) | 🗑️ 삭제 | 8월 이후 미사용. claude.ai/code/routines 웹에서 삭제 필요 (API 삭제 불가). |
| 6 | JiraToSheets-HourlyUpdate (로컬) | 🗑️ 삭제 | 미사용 |

## 실행 순서 (재개 시)

### Phase 1: 수면센서 원격 이관 (지금 실행 가능)
1. `C:\Users\20020911\.claude\mcp.json`에서 Jira PAT, Figma API Key 추출
2. 기존 원격 "모션베드 26.8.1" routine 구조를 템플릿으로 사용 (프롬프트 인라인 토큰 방식)
3. 새 routine "수면센서 26.9 Jira 답변 메일" 생성
   - cron: `10 23 * * *` (매일 KST 08:10)
   - **초기 상태: `enabled: false`** (중복 발송 방지)
   - 프롬프트: `C:\Users\20020911\scripts\motionbed_prompt.md` 내용을 토큰 치환하여 인라인
   - MCP: Atlassian_Rovo + Claude_Code_Remote
4. `RemoteTrigger action=run` 으로 수동 테스트 → 이메일 수신 확인
5. 성공 시:
   - 원격 routine `enabled: true` 로 업데이트
   - 로컬 Windows 태스크 "수면센서 26.9 JIRA 답변 메일" **Disable** (삭제는 검증 후)

### Phase 2: 원격 프롬프트 개선
- 현재 원격이 생성하는 이메일 제목이 매번 바뀜 (예: "레인보우", "코웨이자체" 등 임의 브랜딩)
- 원인: 프롬프트 지시("[수면센서 26.9] Jira 이슈 기획팀 답변내역")를 무시하고 창작
- 조치: 프롬프트에 **"반드시 이 문자열 그대로 사용, 창작 금지"** 문구 명시적 추가

### Phase 3: 정리
- 원격 "모션베드 26.8.1" routine → 사용자가 https://claude.ai/code/routines 에서 수동 삭제 (API 미지원)
- 로컬 "JiraToSheets-HourlyUpdate" → `Unregister-ScheduledTask` 로 삭제
- 로컬 "수면센서 26.9 JIRA 답변 메일" → Phase 1 검증 완료 시 삭제

### Phase 4: PC 교체 D-day 이관 체크리스트
새 PC에서 재설치/재등록 필요한 것들:
- Claude Code CLI 설치 + `~/.claude/mcp.json` 복원 (기존 파일 백업 필요)
- `check-mcp-tokens.ps1` 복원 + `ClaudeMCPTokenCheck` Task 재등록 (08:15)
- Google Drive 설치 + `G:\내 드라이브\claude-archive\` 동기화 대기 + `ClaudeKnowledgeArchive` Task 재등록 (09:30)
- `C:\Users\20020911\scripts\` 폴더는 Phase 1 이관 완료 시 불필요

## 결정 대기 사항
- **Jira PAT · Figma API Key를 원격 routine 프롬프트에 인라인 저장할지 최종 승인 필요**
- 이미 "모션베드 26.8.1" routine에 동일 방식으로 저장된 전례 있음 (Gmail refresh token 포함)
- 원격 저장이 꺼려질 경우 대안: 로컬 유지 + PC 교체 시 재등록으로 취급

## 관련 파일
- 로컬 스크립트: `C:\Users\20020911\scripts\run_motionbed.ps1`, `motionbed_prompt.md`
- 로컬 MCP 설정: `C:\Users\20020911\.claude\mcp.json`
- 원격 관리 웹: https://claude.ai/code/routines
- 최근 발송 로그: `C:\Users\20020911\scripts\logs\motionbed_YYYYMMDD_HHMM.log`
