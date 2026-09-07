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
