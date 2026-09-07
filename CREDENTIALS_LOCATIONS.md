# 크리덴셜 위치 참조 (실제 값 없음)

이 저장소의 sanitize된 메모리 파일에는 토큰이 `***REDACTED***`로 마스킹되어 있습니다.
실제 값은 아래 로컬 파일에서 조회하세요 (Google Drive 동기화 대상 아님):

## Figma / Atlassian / Confluence 토큰
- **원본 메모리**: `~/.claude/projects/C--Users-20020911/memory/project_mcp_token_automation.md`
- **원본 메모리**: `~/.claude/projects/C--Users-20020911/memory/project_iocare_figma.md` (Figma 토큰)
- **만료일 기록**: `~/.claude/token-expiry.json`

## 갱신 방법
- Figma: figma.com/settings > Personal access tokens
- Confluence Data Center: wiki.coway.com > Profile > Personal Access Tokens
- Atlassian Cloud: id.atlassian.com > Security > API tokens

## 관련 스크립트 (로컬)
- `~/.claude/check-mcp-tokens.ps1` — 만료 7일 전 자동 경고 (Task Scheduler: ClaudeMCPTokenCheck)
- `~/.claude/update-mcp-token.ps1` — 갱신 도우미

## 원칙
**Google Drive/GitHub에 절대 토큰 평문 저장 금지.** 로컬 memory 폴더는 Drive 동기화 대상 밖.
