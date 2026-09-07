---
name: MCP 토큰 자동화 및 위키 연결 작업
description: Figma/Atlassian 토큰 만료 자동 감지+갱신 스크립트 구축, wiki.coway.com Data Center 연결 완료
type: project
originSessionId: 3f0c6952-6e6e-441a-af0b-3b29391b8e07
---
## 완료된 작업

### 토큰 자동화 스크립트
- `~/.claude/check-mcp-tokens.ps1` — 매일 09시 자동 실행, 만료 7일 전 사전 경고
- `~/.claude/update-mcp-token.ps1` — 토큰 만료 시 브라우저 자동 오픈 + 붙여넣기로 mcp.json 업데이트
- `~/.claude/token-expiry.json` — 만료일 기록 (Figma/Atlassian 둘 다 2026-11-29)
- Task Scheduler: `ClaudeMCPTokenCheck` 등록 완료

### 토큰 현황 (2026-08-31 기준)
| 서비스 | 토큰 | 만료일 |
|--------|------|--------|
| Figma | `figd_***REDACTED***` | 2026-11-29 |
| Atlassian (id.atlassian.com) | `ATATT3xFfGF03VWr...=AC550710` | 2026-11-29 (추정) |
| Confluence PAT (wiki.coway.com) | `PAT_***REDACTED***` | 미정 |

### wiki.coway.com MCP 연결 완료 (2026-09-01)

**문제 & 해결:**
- `wiki.coway.com` = Atlassian Data Center → PAT + Bearer 인증, **API 경로는 `/rest/api/` (Cloud의 `/wiki/rest/api/` 아님)**
- `@xuandev/atlassian-mcp` 원본 패키지는 Cloud Basic 인증만 지원 → 로컬 복사본 수정

**수정한 파일 (`~/.claude/mcp-servers/atlassian-mcp/dist/`):**
1. `common/auth.js` — `confluenceRequest` 메서드 추가 (Bearer PAT + `/wiki` prefix 자동 제거)
2. `common/config.js` — `confluenceDomain`, `confluenceToken` 옵션 필드 추가
3. `index.js` — `--confluence-domain`, `--confluence-token` CLI 옵션 추가
4. `confluence/api.js` — 모든 `auth.request()` → `auth.confluenceRequest()` 교체

**mcp.json 최종 설정:**
```json
"atlassian": {
  "command": "node",
  "args": [
    "C:/Users/20020911/.claude/mcp-servers/atlassian-mcp/dist/index.js",
    "--domain", "jira.coway.com",
    "--email", "hjmoon@coway.com",
    "--token", "ATATT...",
    "--confluence-domain", "wiki.coway.com",
    "--confluence-token", "PAT_***REDACTED***"
  ]
}
```

**Why:** wiki.coway.com은 Data Center라 PAT + Bearer 인증 필요하고, Cloud와 달리 API 경로에 `/wiki` prefix가 없음
**How to apply:** Claude Code 재시작하면 MCP가 로컬 패키지로 동작. PAT 만료 시 wiki.coway.com → Profile → Personal Access Tokens에서 재발급 후 mcp.json 업데이트
