---
name: project-work-bot
description: "업무 봇(구 봇 허브) — ~/Downloads/bot-hub 로컬 웹(127.0.0.1:8765), Jira 하위문서·기획 사양 정리·QA 대응·토큰 리포트 봇 (2026-10-20)"
metadata:
  node_type: memory
  type: project
  originSessionId: 2901365a-934a-4b84-9da5-7527e2f9182c
  modified: 2026-10-20T00:34:21.919Z
---

업무 봇 = 2026-10-20 '봇 허브'에서 개명. 저장소 GitHub hjmoon29/jira, 각 PC `~/Downloads/bot-hub`, 실행 `업무봇 실행.bat/.command`, 동기화 봇으로 Mac·Windows 공유.

봇 구성 (2026-10-20 기준, 아직 git 미푸시 — 사용자 검토 후 올리기로 함):
- Jira 하위 문서 생성: '직접 입력' 탭 추가(요약·이슈유형·보고자·담당자·우선순위·구성요소·레이블·기한·설명, 에픽 키 입력 시 기존 하위문서 값 자동 채움). Windows Jira 토큰 `~/.config/jira-bot/token`(44자; 숨김 입력에 5번 붙여넣어 220자 됐던 적 있음)
- 기획 사양 정리 (wiki) `bots/spec-doc`: 위키(상위+하위)·Figma REST(SPEC 제외/표지/작업안 페이지 스킵, 취소선 제외)·Drive 수집 → `claude -p --model opus[1m] --tools ""` 로 storage XML 초안 → 미리보기 → 위키 게시(같은 제목이면 갱신). 형식 규칙 format_guide.md. ODM 매트리스 테스트: 61만자 자료, 6분, 약 $5
- QA 대응 `bots/qa`: Jira 이슈(CWCQIOTN, 상태는 ID로 JQL) / 문의사항 시트(담당·문의·답변 열 자동 탐지, 열 지정 가능) → Claude 답변 초안 → 자체 xlsx → Gmail(`~/.config/claude-daily/gmail.json`) 발송. 예약은 runs/qa-schedules.json + OS 작업(Windows `WorkBotQA` 10분 / Mac launchd com.workbot.qa), 첫 예약 저장 시 자동 등록
- 회의실 예약 `bots/meeting-room` (2026-10-20 추가): gapps.coway.com 페이지 내 `var jsonData`(회의실 93개·수용인원·내 위치 G타워 13층) + `/schedule/floor/reservationAjax.json`(빈 시간, declined 제외) → 구글 로그인 사용자는 gapps도 캘린더 eventedit(add=회의실 리소스 이메일)로 예약하므로 Playwright(Edge, 프로필 `~/.playwright-edge-profile`)로 같은 화면 열어 저장(button jsname=x8hlje). Chrome 확장은 회사 관리콘솔 정책으로 차단돼 Playwright 사용
- 헬스케어 예약 `bots/healthcare` (2026-10-21 추가): portal.coway.com/emate-k15_02/help_care.nsf ByWeek 화면의 JS 전역(rdate·Catalogue1·personcnt·after2week·myname·g_keeper·g_time)을 읽어 빈칸 탐색. rdate 항목 = 시간번호^남/여^사번^docid^N(예약)/휴가/오전반차/오후반차. 시간번호 -1~4(17:10=5는 버튼 없음). 예약 = 주간 화면에서 openpage(entry?OpenForm&form=헬스케어&caredate&carenum&caresex) 팝업 → savedoc(), 이후 주간 화면에서 내 사번 확인. 포털 로그인은 NETSPASS MFA라 자동 불가 → '로그인' 탭(headed) 후 LtpaToken 쿠키를 `~/.config/work-bot/healthcare_cookies.json`에 저장해 headless 재사용. 실제 예약 제출 경로는 아직 미검증(첫 실사용 때 확인)
- 회의실 예약 화면: bot.json 필드 `follows: {field, minutes}` 로 종료 시각이 시작+60분 자동 (index.html 공통 처리, 2026-10-21)
- 인증: `~/.config/work-bot/credentials.json` 또는 ~/.claude/mcp.json 의 confluence/figma/gdrive 값 자동 탐색

**Why:** 사용자가 반복 기획 업무(하위문서 생성, 사양 정리, QA 답변)를 버튼으로 돌리고 싶어 함. 직접 쓰기(Jira·구글문서)는 피하고 엑셀/미리보기로 검토 후 반영하는 방식을 선호.
**How to apply:** 봇 수정 요청 시 이 구조 기준. Bash heredoc은 백슬래시를 깨뜨리니 패치 스크립트는 Write로 파일 작성 후 실행. 관련: [[project_wiki_workflow]], [[project_claude_daily_summary]]
