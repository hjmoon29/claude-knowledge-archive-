---
name: Confluence wiki.coway.com 업데이트 워크플로우
description: wiki.coway.com 사내 Confluence 페이지 읽기/수정 방법 (self-hosted, Atlassian Rovo MCP 미지원)
type: project
originSessionId: 5abdf289-fb1c-4004-9191-96be2b1c3f92
---
wiki.coway.com은 사내 자체 호스팅 Confluence Data Center — Atlassian Rovo MCP(atlassian.net 전용)로는 접근 불가.

**워크플로우 (Bash tool로 직접 curl 사용):**

1. **페이지 읽기**
   ```bash
   curl -u 'hjmoon@coway.com:비밀번호' 'https://wiki.coway.com/rest/api/content/{pageId}?expand=body.storage,version' -s
   ```
   - pageId는 URL에서 추출 (e.g. `/pages/363667231/`)

2. **현재 버전 확인** — PUT 업데이트 시 version.number를 현재+1로 설정해야 함

3. **업데이트 JSON 생성** — Python3 미동작(Microsoft Store stub), Node.js는 Windows 경로 혼용 문제
   → **PowerShell 사용**으로 JSON 생성 후 `/c/Users/20020911/AppData/Local/Temp/` 에 저장

4. **페이지 업데이트**
   ```bash
   curl -u 'hjmoon@coway.com:비밀번호' -X PUT 'https://wiki.coway.com/rest/api/content/{pageId}' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d @/c/Users/20020911/AppData/Local/Temp/wiki_update.json -s
   ```

**JSON payload 구조:**
```json
{
  "id": "pageId",
  "type": "page",
  "title": "페이지 제목",
  "version": { "number": 현재버전+1 },
  "body": {
    "storage": {
      "value": "<HTML 내용>",
      "representation": "storage"
    }
  }
}
```

**Why:** wiki.coway.com은 사내망 전용 서버라 외부 MCP 연결 불가. curl + PowerShell 조합으로 직접 REST API 호출.

**How to apply:** 앞으로 wiki 페이지 읽기/생성/수정 요청 시 이 워크플로우 사용. 비밀번호는 사용자에게 직접 입력받을 것 (기억하지 않음).

**2026-10-14 추가 (현행 방식):** 인증은 비밀번호 대신 Confluence PAT Bearer (`~/.claude/mcp.json`의 `NzgzNDQ1OTEzODcw…` 토큰). Python requests 사용 시 `Session().trust_env=False` 필수 — 기본값이면 ~/.netrc가 Authorization 헤더를 덮어써 401 발생. 한글 제목 검색은 curl(Git Bash)이 CP949로 인코딩하므로 Python으로.
- 기획 사양 정리 페이지 형식 예시: 슬립싱크 406323539, 모션베드 406323763, 개인형 비데 후속(슬리믹·더매너) 405832885 (2026-10-19, 생성 스크립트 패턴: Python으로 storage XML 생성 후 POST /rest/api/content, ancestors=부모ID) (info 안내 + toc + 한눈에 보기 + 장별 정책표 + 확인 필요/불일치 status 매크로 + 목록 + 문서 이력)
