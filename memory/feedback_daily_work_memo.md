---
name: feedback-daily-work-memo
description: "업무 질문·작업 시 ~/Downloads/yymmdd_업무내용.txt 일일 메모도 참고 (CP949, 상단에 계정·비밀번호·카드정보 있음 → 절대 인용·복사 금지)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 7508c6d4-fef4-48c6-9f10-4463436226e7
  modified: 2026-10-28T06:05:21.999Z
---

업무 관련 요청·질문에 답할 때 위키·Figma·Jira·구글시트·메일·메신저와 함께 `~/Downloads/yymmdd_업무내용.txt` (사용자 일일 업무 메모, 2026-10-28 기준 196개, 최신순 `ls -t`) 도 참고한다.

- 인코딩 CP949(ANSI, CRLF) → `open(f, encoding="cp949")` 로 읽기
- **파일 상단에 사내 시스템 계정·비밀번호, 카드번호, 개인 연락처가 평문으로 들어 있음.** 이 부분은 답변·문서·위키·아카이브·커밋·로그 어디에도 인용·복사·요약하지 말 것. 키워드 grep 으로 업무 내용 줄만 골라 읽는 방식 권장
- 출처 표기 시 "업무메모 10/28" 처럼 날짜만

**Why:** 사용자가 2026-10-28 "앞으로는 다운로드 폴더의 yymmdd_업무내용.txt 메모장 파일들도 참고해줘" 요청. 사용자 본인의 일정·결정·할 일이 여기 정리돼 있음.
**How to apply:** 업무 질문이면 관련 키워드로 최근 메모부터 grep. 관련: [[project_edge_claude_extension]] (메신저), [[project_wiki_workflow]]
