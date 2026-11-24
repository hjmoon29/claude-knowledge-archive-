---
name: project-edge-claude-extension
description: "크롬 확장은 회사 정책으로 차단 → Edge에 Claude 확장 설치 완료, Claude Code 연결(Native host) 미완료 (2026-10-26)"
metadata:
  node_type: memory
  type: project
  originSessionId: 26e7d781-8dd6-4235-b12b-76e3a67e347e
  modified: 2026-10-28T06:02:55.433Z
---

목적: 네이버웍스 웹 메신저 대화방 내용을 Claude가 읽도록 브라우저 연결 (공개 MCP 중 채팅 기록 읽기 지원 없음, nworks는 발송만).

- 크롬: 회사 Google 클라우드 관리 정책(CloudManagementEnrollmentToken)으로 확장 설치 차단 → PC에서 해제 불가
- Edge: 크롬 웹 스토어에서 Claude 확장(ID fcoeoabgfenejglbffodgkkbkcdhcgfn, v1.0.102) 설치 완료 (Edge Default 프로필)
- 확장이 찾는 Native host 이름: `com.anthropic.claude_code_browser_extension`
- 2026-10-26 세션에서 `/chrome` 실행해도 HKCU\Software\Google\Chrome\NativeMessagingHosts에 Claude 항목이 생기지 않음 (`.claude.json` claudeInChromeDefaultEnabled: true, Claude Code 2.1.310)

- 2026-10-26 10:34 확인: Chrome·Edge 양쪽 HKCU NativeMessagingHosts에 `com.anthropic.claude_code_browser_extension` 등록 완료 (manifest `%APPDATA%\Claude Code\ChromeNativeHost\...json` 10:26 생성, allowed_origins에 확장 ID 포함, `~\.claude\chrome\chrome-native-host.bat` 정상). Edge가 08:05부터 켜져 있어 미반영 → Edge 완전 재시작 필요.

- **2026-10-26 Edge 재시작 후 연결 성공** ✅ (Windows 브라우저 1개 연결, 탭 그룹 생성·조작 가능).
- **메신저 읽기 실사용 완료** ✅: 10/26 `[기획 사양 정리] 말련향 정수기 2종` docx(~/Downloads, v1.2~v1.4)에 Wiki·Jira·메일·**메신저(네이버웍스)** 대화방([IoT기획/플랫폼], [리빙/베렉스 파트] 등) 인용을 넣음. 단 웍스 로그인 세션이 끊기면 못 읽음(v1.3·v1.4는 "메신저 로그인 필요로 재확인 못함").
- 2026-10-28 부팅 자동 열기: 시작프로그램에 `네이버웍스(Edge).lnk` (msedge --profile-directory=Default https://talk.worksmobile.com/, 최소화). 비밀번호 저장·자동 입력은 안 함 → 로그인 유지는 웍스 '로그인 상태 유지' 체크에 의존. 해제는 lnk 삭제
- 2026-10-28: 사용자가 "메신저 못 읽는다"는 내 답을 정정함 → 업무 질문에 소스 현황 답할 때 메신저(Edge 확장 경유, 로그인 필요)도 읽기 가능으로 안내할 것.

**(이전) 다음 단계:** `claude --chrome`으로 새 세션 시작 → Chrome NativeMessagingHosts에 `com.anthropic.claude_code_browser_extension` 생기는지 확인 → 같은 manifest 경로를 `HKCU\Software\Microsoft\Edge\NativeMessagingHosts\com.anthropic.claude_code_browser_extension` (기본값)에 등록 → Edge 완전 종료 후 재실행 → 연결 확인. Edge는 공식 지원 여부 불확실.
**Why:** 사용자가 네이버웍스 메신저 대화를 Claude로 확인하길 원함. Playwright 등 확장 우회 방식은 IT 확인 없이 설치하지 않기로 함.
**How to apply:** 사용자가 "크롬/엣지 연결", "네이버웍스 대화 읽기" 이어서 요청하면 위 다음 단계부터 진행. 연관: [[project_naverworks_notify]]
- 2026-11-24 메신저 발송 성공: Playwright 프로필 ~/.playwright-works-profile(msedge)로 로그인→방 찾기→발송을 한 창에서 처리(창 닫으면 로그인 풀림). 나와의 대화방 이름 = "문효준 님[IoT기획팀/팀원]", 입력창 [contenteditable=true], 줄바꿈 Shift+Enter. 스크립트는 세션 scratchpad msg_send.py(방이름 정확 일치 1개일 때만 발송)
