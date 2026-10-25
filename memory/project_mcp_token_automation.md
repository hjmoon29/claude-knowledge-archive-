---
name: MCP 토큰 자동화 및 위키 연결 작업
description: Figma/Atlassian 토큰 만료 자동 감지+갱신 스크립트 구축, wiki.coway.com Data Center 연결 완료
type: project
originSessionId: 3f0c6952-6e6e-441a-af0b-3b29391b8e07
---
## 완료된 작업

### 토큰 자동화 스크립트
- `~/.claude/check-mcp-tokens.ps1` — 매일 **08:15** 자동 실행 (2026-09-08 변경), 만료 7일 전 사전 경고 + 4개 서비스 실제 API ping
  - 체크 대상: Figma, Atlassian(jira.coway.com Data Center), Wiki(wiki.coway.com), **Google Sheets** (2026-09-08 추가)
  - Google Sheets: `.gdrive-server-credentials.json`의 refresh_token → access_token 재발급 → 스프레드시트 `1p8COpGH5aCzjwQ582BvcxYdWs6qTmol7btSHvoJYld8` ping
  - **주의:** Rovo Cloud (atlassian.net)는 OAuth 세션 기반이라 스크립트 검증 불가 — Claude Code 실행 중일 때만 접근 가능
- `~/.claude/update-mcp-token.ps1` — 토큰 만료 시 브라우저 자동 오픈 + 붙여넣기로 mcp.json 업데이트 (Sheets 미지원, get-sheets-token.ps1 별도 실행)
- `~/.claude/get-sheets-token.ps1` — Google Sheets OAuth 재인증 (refresh_token 재발급)
- `~/.claude/token-expiry.json` — 만료일 기록 (Figma/Atlassian 둘 다 2026-11-29)
- `~/.claude/token-check.log` — 실행 로그 (매일 append)
- Task Scheduler: `ClaudeMCPTokenCheck` 등록 완료 (매일 **11:30** 변경됨, 로그 기준)

### MCP 서버 프로세스 생존 체크 (2026-10-06 추가)
토큰 유효성 체크(check-mcp-tokens.ps1)와 **별개 레이어**로, 각 MCP 서버 프로세스 자체의 기동 가능성을 검증.

- `~/.claude/mcp-health-check.ps1` — 각 MCP 서버 (node: 스크립트 존재+syntax check / npx: 캐시 존재 또는 20s spawn test). `mcp-health.json`에 결과 저장.
- `~/.claude/mcp-health-hook.ps1` — SessionStart hook. json 읽어 `additionalContext`로 Claude에 주입.
- `~/.claude/mcp-health.json`, `~/.claude/mcp-health.log` — 최신 상태 + 누적 로그
- **settings.json의 SessionStart hook에 등록 완료** — 세션 시작마다 MCP 상태를 컨텍스트에 삽입
- **check-mcp-tokens.ps1 말미에서 자동 호출** — 매일 11:30 cron에 통합. 비정상 서버 발견 시 Toast 알림

**Why:** 토큰은 멀쩡해도 npx 기반 MCP 서버 프로세스가 세션 중 크래시하면 토큰 체크로는 감지 불가. 이번 2026-10-06 세션에서 gmail/googleSheets MCP 중단 사건을 계기로 추가.

**How to apply:** 세션 시작 때 ❌/⏱️ 아이콘 보이면 즉시 세션 재시작 또는 수동 복구. 비정상 서버는 `mcp-health.log` 최신 항목 확인. 모든 체크 OK인데 세션 내에서 끊긴 경우 → 재시작으로 해결됨 (프로세스 레벨 이슈)

### 점심시간 통합 상태 메일 (2026-10-06 추가)
토큰 체크 + MCP 서버 health + 지식/메모리 아카이브 **세 작업 결과를 하나의 메일**로 묶어서 매일 발송.

- `C:\Users\20020911\scripts\lunch_status_mail.py` + `.ps1` — Gmail OAuth로 hjmoon@coway.com 발송
- Scheduled Task: **`ClaudeLunchStatusMail`** 매일 **11:45 KST** (11:30 토큰체크·11:33 아카이브 완료 후 실행)
- 메일 제목: `[Claude 점심상태] YYYY-MM-DD - ✅ 전체정상` 또는 `⚠️ 토큰⚠️,MCP N개 비정상,백업실패` 등 이슈 요약
- 읽는 입력: `token-check.log` 당일 라인, `mcp-health.json`, `claude-archive\logs\sync-YYYY-MM.log` 당일 블록
- **주의:** mcp-health.json이 UTF-8 BOM으로 쓰여서 Python에서 읽을 땐 `encoding="utf-8-sig"` 필수

**중요:** PowerShell 5.1은 BOM 없는 UTF-8 파일에서 한글 때문에 parse error 발생. 신규 ps1 생성 시 **UTF-8 BOM 포함 저장 필수** (ex. `[System.IO.File]::WriteAllText(path, content, [System.Text.UTF8Encoding]::new($true))`)

### 토큰 현황 (2026-09-08 기준)
| 서비스 | 토큰 | 인증 방식 | 만료일 |
|--------|------|-----------|--------|
| Figma | `figd_***REDACTED***` | `X-Figma-Token` | 2026-11-29 |
| Jira Data Center (jira.coway.com) | `MDU2NzA5MzUyOTM2Ol...` | **Bearer PAT** (2026-09-08 전환) | 2026-12-07 |
| Confluence PAT (wiki.coway.com) | `NzgzNDQ1OTEzODcwOh...` | Bearer PAT | 무기한 (name=260908, id=233) |
| Google Sheets OAuth | `.gdrive-server-credentials.json` refresh_token | OAuth refresh | 자동 갱신 |

**Cloud API token (`ATATT...=AC550710`) 폐기됨** — CAPTCHA_CHALLENGE + Data Center 부적합. 대체된 PAT는 wiki 방식과 동일한 base64 형태.

### wiki.coway.com MCP 연결 완료 (2026-09-01)

**문제 & 해결:**
- `wiki.coway.com` = Atlassian Data Center → PAT + Bearer 인증, **API 경로는 `/rest/api/` (Cloud의 `/wiki/rest/api/` 아님)**
- `@xuandev/atlassian-mcp` 원본 패키지는 Cloud Basic 인증만 지원 → 로컬 복사본 수정

**수정한 파일 (`~/.claude/mcp-servers/atlassian-mcp/dist/`):**
1. `common/auth.js` — `confluenceRequest` 메서드 (Bearer PAT + `/wiki` prefix 자동 제거) + **`request()`에서 `jiraToken` 있으면 Bearer, 없으면 Basic 자동 분기** (2026-09-08 추가)
2. `common/config.js` — `confluenceDomain/Token`, **`jiraToken`** 옵션 필드 추가. Bearer 방식이면 email/apiToken 생략 가능하도록 validation 완화 (2026-09-08)
3. `index.js` — `--confluence-domain/token`, **`--jira-token`** CLI 옵션 추가 (2026-09-08)
4. `confluence/api.js` — 모든 `auth.request()` → `auth.confluenceRequest()` 교체

### wiki.coway.com + jira.coway.com 최종 설정 (2026-09-08)

**mcp.json:**
```json
"atlassian": {
  "command": "node",
  "args": [
    "C:/Users/20020911/.claude/mcp-servers/atlassian-mcp/dist/index.js",
    "--domain", "jira.coway.com",
    "--email", "hjmoon@coway.com",
    "--jira-token", "MDU2NzA5MzUyOTM2Ol...",
    "--confluence-domain", "wiki.coway.com",
    "--confluence-token", "NzY2NTg2NzQ5OTE0Ol..."
  ]
}
```

**Why:** jira.coway.com도 Data Center(wiki와 같음). Cloud API token(`ATATT...`)로 Basic auth 시도하면 CAPTCHA_CHALLENGE 걸리며 계속 인증 실패. Data Center PAT(`MDU2...` base64 형태)를 Bearer로 써야 함.

**How to apply:**
- Claude Code 재시작하면 새 인증으로 MCP 접속.
- PAT 만료 시: jira.coway.com → 프로필 → Personal Access Tokens 재발급 → `--jira-token` 값 교체.
- **주의:** CAPTCHA 걸린 상태면 브라우저 세션과 API 세션이 별개라 API로는 해제 안 됨. Data Center PAT + Bearer 방식이 정공법.

### 헬스체크 스크립트 인증 전환 (2026-09-08)
- `check-mcp-tokens.ps1`: Atlassian 체크가 `--jira-token` 있으면 Bearer, 없으면 기존 Basic fallback
- `update-mcp-token.ps1`: `Test-AtlassianToken`을 Bearer로 변경, 갱신 UI는 jira.coway.com 프로필로 열림

### ⚠️ MCP 설정은 `~/.claude.json`이 실제 로드 대상 (2026-09-08 발견)

**중요:** Claude Code는 `~/.claude.json`의 `mcpServers` 섹션을 실제로 spawn하고, `~/.claude/mcp.json`은 (적어도 이 환경에서는) **로드되지 않는다**.

**증상:** mcp.json만 갱신하면 헬스체크는 OK 나오는데 실제 툴 호출은 401 계속.

**Why:** `.claude.json`(홈 최상위)이 우선순위 상위. 초기 세팅 시 넣어둔 `accesstoken_20260420`(placeholder성 옛 토큰)이 5개월간 남아있었고, mcp.json의 새 PAT는 아무도 사용 안 함. 두 파일이 서로 다른 Atlassian MCP 구현체를 가리키기까지 함:
- `.claude.json` → `uvx mcp-atlassian` (sooperset Python)
- `mcp.json` → `node atlassian-mcp` (xuandev 커스텀)

**How to apply:**
- 토큰 교체 시 **반드시 `~/.claude.json`의 `mcpServers.atlassian.args`** 안의 `--jira-personal-token` 값을 바꿔야 실효
- `check-mcp-tokens.ps1`도 `.claude.json`을 파싱하도록 향후 개선 필요 (현재는 mcp.json만 봄 → 거짓 OK 발생)
- 재시작 없으면 기존 uvx 프로세스가 옛 토큰으로 계속 살아있으니 Claude Code 재시작 필수
- 현재 실제 사용 중인 MCP는 **sooperset** (`mcp__atlassian__jira_*` 툴들이 이것). wiki(Confluence)는 이 서버에 안 붙어있고 Rovo(atlassian.net) 쪽으로 접근

## 2026-10-12 정비
- 실제 MCP 설정은 `~/.claude.json`(user 범위) + 홈 폴더 local 범위(figma·google-sheets·google-drive). `~/.claude/mcp.json`은 토큰 보관소로만 쓰임(check/update 스크립트가 읽음).
- atlassian Jira PAT는 args → `env.JIRA_PERSONAL_TOKEN`으로 이동. update-mcp-token.ps1이 `~/.claude.json`도 함께 교체하도록 수정.
- `settings.json` env `MCP_TIMEOUT=60000` (uvx/npx 콜드 스타트 30초 초과 대응).
- mcp-health-check.ps1은 홈 폴더에서 `claude mcp list` 결과를 파싱(상태 ok/auth/fail/timeout). 매일 11:30 ClaudeMCPTokenCheck 작업이 호출. auth는 알림 제외, 훅에서 별도 표시.
- 수정한 스크립트 백업: `*.bak-20261012`.

## 2026-10-23: stdio MCP 서버 로컬 설치 전환
- gmail·google-drive·google-sheets: `npx -y` → `node C:/nvm4w/nodejs/node_modules/<pkg>/dist/index.js` (npm i -g, 버전 동일 1.1.11 / 2025.1.14 / 2.0.1)
- atlassian: `uvx mcp-atlassian` → `C:/Users/20020911/.local/bin/mcp-atlassian.exe` (uv tool install). 이유: 시작 때마다 패키지 확인으로 CONNECT_TIMEOUT(60s)·중간 끊김
- 백업: `~/.claude.json.bak_mcp_<날짜시각>`. 패키지 업데이트는 `npm i -g <pkg>@latest` / `uv tool upgrade mcp-atlassian`
- Claude Code 대화형 모드는 stdio 서버가 중간에 죽으면 자동 재시작 안 함(공식 문서). 복구는 `/mcp reconnect all`(v2.1.284+)
