---
name: project-work-bot
description: "업무 봇(구 봇 허브) — ~/Downloads/bot-hub 로컬 웹(127.0.0.1:8765), Jira 하위문서·기획 사양 정리·QA 대응·토큰 리포트 봇 (2026-10-20)"
metadata:
  node_type: memory
  type: project
  originSessionId: 2901365a-934a-4b84-9da5-7527e2f9182c
  modified: 2026-10-27T00:58:15.809Z
---

업무 봇 = 2026-10-20 '봇 허브'에서 개명. 저장소 GitHub hjmoon29/jira, 각 PC `~/Downloads/bot-hub`, 실행 `업무봇 실행.bat/.command`, 동기화 봇으로 Mac·Windows 공유.

봇 구성 (2026-10-20 기준, 아직 git 미푸시 — 사용자 검토 후 올리기로 함):
- Jira 하위 문서 생성: '직접 입력' 탭 추가(요약·이슈유형·보고자·담당자·우선순위·구성요소·레이블·기한·설명, 에픽 키 입력 시 기존 하위문서 값 자동 채움). Windows Jira 토큰 `~/.config/jira-bot/token`(44자; 숨김 입력에 5번 붙여넣어 220자 됐던 적 있음)
- 기획 사양 정리 (wiki) `bots/spec-doc`: 위키(상위+하위)·Figma REST(SPEC 제외/표지/작업안 페이지 스킵, 취소선 제외)·Drive 수집 → `claude -p --model opus[1m] --tools ""` 로 storage XML 초안 → 미리보기 → 위키 게시(같은 제목이면 갱신). 형식 규칙 format_guide.md. ODM 매트리스 테스트: 61만자 자료, 6분, 약 $5
- QA 대응 `bots/qa`: Jira 이슈(CWCQIOTN, 상태는 ID로 JQL) / 문의사항 시트(담당·문의·답변 열 자동 탐지, 열 지정 가능) → Claude 답변 초안 → 자체 xlsx → Gmail(`~/.config/claude-daily/gmail.json`) 발송. 예약은 runs/qa-schedules.json + OS 작업(Windows `WorkBotQA` 10분 / Mac launchd com.workbot.qa), 첫 예약 저장 시 자동 등록
- 회의실 예약 `bots/meeting-room` (2026-10-20 추가): gapps.coway.com 페이지 내 `var jsonData`(회의실 93개·수용인원·내 위치 G타워 13층) + `/schedule/floor/reservationAjax.json`(빈 시간, declined 제외) → 구글 로그인 사용자는 gapps도 캘린더 eventedit(add=회의실 리소스 이메일)로 예약하므로 Playwright(Edge, 프로필 `~/.playwright-edge-profile`)로 같은 화면 열어 저장(button jsname=x8hlje). Chrome 확장은 회사 관리콘솔 정책으로 차단돼 Playwright 사용
- 헬스케어 예약 `bots/healthcare` (2026-10-21 추가): portal.coway.com/emate-k15_02/help_care.nsf ByWeek 화면의 JS 전역(rdate·Catalogue1·personcnt·after2week·myname·g_keeper·g_time)을 읽어 빈칸 탐색. rdate 항목 = 시간번호^남/여^사번^docid^N(예약)/휴가/오전반차/오후반차. 시간번호 -1~4(17:10=5는 버튼 없음). 예약 = 주간 화면에서 openpage(entry?OpenForm&form=헬스케어&caredate&carenum&caresex) 팝업 → savedoc(), 이후 주간 화면에서 내 사번 확인. 포털 로그인은 NETSPASS MFA라 자동 불가 → '로그인' 탭(headed) 후 LtpaToken 쿠키를 `~/.config/work-bot/healthcare_cookies.json`에 저장해 headless 재사용. 실제 예약 제출 경로는 아직 미검증(첫 실사용 때 확인)
- IoT IMS 조회 `bots/ims` (2026-10-22 추가, 미푸시): 읽기 전용 37개 항목(catalog.py → make_botjson.py 로 bot.json 생성), 개발/운영 선택, 결과 view "table"(index.html 신규) + runs/ims/*.xlsx(qa.write_xlsx 재사용). 인증은 사용자가 고른 '브라우저 세션 방식': `~/.playwright-ims-profile` 에 headed 로그인 → headless 로 열어 IMS 화면 요청의 Authorization 헤더를 가로채 API 호출(토큰 추출·저장 방식은 자동모드 분류기가 거부해 폐기). GET .../page 류는 page 0부터. 등록·수정·삭제 탭(writes.py 147개 작업, 미리보기→'IMS에 반영' 확인, 운영은 '운영' 입력, 기록 runs/ims/changes.jsonl, 본문 틀 templates.json) 추가 — 사용자 지시로 실제 반영 시험은 안 함(본문 형식 미검증)
- 회의실 예약 화면: bot.json 필드 `follows: {field, minutes}` 로 종료 시각이 시작+60분 자동 (index.html 공통 처리, 2026-10-21)
- 인증: `~/.config/work-bot/credentials.json` 또는 ~/.claude/mcp.json 의 confluence/figma/gdrive 값 자동 탐색

**Why:** 사용자가 반복 기획 업무(하위문서 생성, 사양 정리, QA 답변)를 버튼으로 돌리고 싶어 함. 직접 쓰기(Jira·구글문서)는 피하고 엑셀/미리보기로 검토 후 반영하는 방식을 선호.
**How to apply:** 봇 수정 요청 시 이 구조 기준. Bash heredoc은 백슬래시를 깨뜨리니 패치 스크립트는 Write로 파일 작성 후 실행. 관련: [[project_wiki_workflow]], [[project_claude_daily_summary]]

## 2026-10-23: 코웨이 디자인 통합 + 창 없는 실행
- bot-hub-coway(8766, 별도 사본)의 코웨이 테마(네이비 상단 바·Pretendard·브레드크럼·상단 한도 표시 `/api/limits`→daily-summary now)를 원본 bot-hub에 합침. 사용자: "이걸로 쭉 가자" → 원본 bot-hub 하나로 운영. 백업 index.html/hub.py `.bak_before_coway`
- 창 없이 실행: `업무봇 실행(창없음).vbs`(cmd 숨김, 출력 runs/hub.log) / `업무봇 종료.bat`(8765 리슨 프로세스 종료). bat 안 한글은 cmd 파싱 깨짐 → ASCII만
- Windows에선 SO_REUSEADDR 때문에 같은 포트에 서버 중복 실행 가능 → 종료 bat이 전부 정리
- 여전히 git 미커밋·미푸시

## 2026-10-27: 팀원 배포 (각자 설치 방식)
- 사용자 선택: 공개 URL 대신 '각자 설치용 배포' (봇이 본인 토큰으로 Jira·위키·메일·IMS 쓰기 하므로 공유 URL은 위험)
- 배포 zip: `~/Downloads/업무봇_팀배포.zip` (runs·.git·백업·토큰·summaries.json·export 제외). 저장소 루트에 `처음 설치.bat`(ASCII, pip playwright openpyxl + setup.py)·`팀원 설치 안내.md` 추가
- 토큰 리포트 봇: `bots/daily-summary/claude_daily.py` 사본 동봉(데일리 써머리 폴더 없으면 사용, 개인 artifact 링크 제거) → 팀원 PC에서 자기 기록으로 동작
- 동기화 봇: '저장소 연결'(connect) 추가 — zip 설치본에 git init+fetch+reset(mixed). 저장소 hjmoon29/jira는 private → 팀원 GitHub 초대 필요. 원격이 로컬보다 뒤처짐(ims 등 미푸시) → 푸시해야 팀원 동기화 정상

- 2026-10-27 명칭 변경: **IoT업무봇(Beta)** (화면 제목·로고·브레드크럼), 문장 속은 'IoT업무봇'. 실행 파일 `IoT업무봇 실행.bat/.command`, `IoT업무봇 실행(창없음).vbs`, `IoT업무봇 종료.bat`
- 설치 zip 최소화: `~/Downloads/IoT업무봇(Beta)_설치.zip` (39파일, 풀면 `IoT업무봇` 폴더). README·.git*·skills·make_botjson.py 제외. 동기화 '저장소 연결' 시 빠진 추적 파일은 git checkout으로 복원(.gitignore 없으면 runs/ 가 올라갈 위험). 생성 스크립트는 세션 scratchpad make_dist.py(화이트리스트 방식)

## 2026-10-27: 부팅 시 자동 실행
- 시작프로그램 폴더(shell:startup)에 `IoT업무봇.lnk` → wscript.exe "…\bot-hub\IoT업무봇 실행(창없음).vbs". hub.py가 브라우저 자동으로 엶. 해제는 lnk 삭제

## 2026-10-27: 팀 공유 URL = 소개·설치 포털 (claude.ai Artifact)
- 사용자 선택: 봇 자체를 공유 서버로 여는 대신 '소개·설치 포털 URL' → https://claude.ai/artifact/QCbZVKMQTKXoBFxxHUx84g (비공개, 팀원에게 Share 필요)
- zip은 Artifact 부속 파일로 못 올림 → base64 텍스트(iot-workbot-beta.b64.txt)로 올리고 페이지가 downloads 캡ability로 zip 복원 저장
- 소스: 해당 세션 scratchpad iot-workbot-portal.html. zip 갱신 시 같은 URL에 b64 다시 올려야 함

## 2026-10-28: Jira '새 제품 하위 문서' 탭 (첫 탭)
- 제품명 + 국내향/해외향 라디오 → 향지별 기본 문서 체크 목록(전부 체크) → '값 설정' 창(기준 에픽 config `reference_epic`=IOCARERENEW2023-2597 의 같은 문서에서 담당자·구성요소·레이블·우선순위, 기한 직접) → 생성하기(미리보기+확인 후 생성)
- config default_docs에 `regions`, 해외향 전용 4종(통합회원 향지·언어 변경·개인정보/약관·포토모드 법무) + 공통 2종(제품 기본 정보·화면 기획) 추가. '기본 하위 문서' 탭은 숨김
- 코드: jira_tasks.py doc_values/plan_new, adapter new/doc_options/doc_values, index.html openValues(dialog#dlg). 백업 *.bak_20261028. 미커밋

## 2026-10-28: Jira '새 프로젝트 문서' 탭 (맨 앞)
- 제품명만 입력 → 에픽(큰틀) 생성: 제목 `[프로젝트][제품] {제품} 개발을 위한 IoT 기획`, 우선순위 블로커, 구성요소 기획, 레이블 없음, 담당·보고자=나, Epic Name=제목. 설명 틀 = 2597의 대상 제품·주요 결정 사항·전체 일정·기획 문서 표(빈칸). config `epic_template` 에서 수정
- JQL은 '큰틀'(번역명)을 못 읽음 → 기준 에픽 issuetype id(10000)로 검색·생성. 같은 제목 큰틀 있으면 '이미 있음'
- 생성 후 config products 에 제품→에픽 자동 등록 → '새 제품 하위 문서' 탭에서 바로 사용
- 코드: jira_tasks.py plan_epic/register_product, apply kind=epic, adapter new_epic, index.html 확인창. 백업 *.bak_20261028_epic. 실제 생성 시험은 안 함
- 2026-10-28: 우선순위 '블로커'를 이름으로 지정하면 Jira 오류 → `DEFAULT_PRIORITY="블로커"` 는 보내지 않고 Jira 기본값(=블로커)에 맡김 (에픽·하위문서 모두). 다른 우선순위는 그대로 전송
- 2026-10-28: 이름 변경 'JIRA 자동 생성기', QA 부제 'QA 이슈 대응 및 문의사항 답변', 봇 아이콘 이모지→선형 SVG(index.html ICON_PATHS, bot id 기준). Figma UX 봇(3번째) 기능은 사용자와 논의 중(미정)
- 2026-10-28: find_epic 에 '제목에 제품명이 있는 에픽(issuetype id)' 검색 단계 추가 — 하위 문서 없는 에픽(예: 좌욕 스파 비데 2492)도 찾음. 띄어쓰기 다르면 Jira 검색 특성상 못 찾음
- 2026-10-28: 담당자 기본값 = 나(토큰 주인) — 값 설정 창·직접 입력·기본/별도 문서 모두. 기준 에픽·제품 등록 담당자는 더 이상 기본값으로 안 씀
- 2026-10-28: 좌욕 스파 비데 3023~3028 담당자→나, 레이블 정수기→비데 (Jira 직접 수정). 레이블 기본값 = 설정(IoCare+) + 제품명 속 제품군(CATEGORIES, product_labels) — 기준 에픽 레이블 복사 중단. 제품 등록에 labels 있으면 그것 우선

## 2026-10-29: Figma UX 기획봇 `bots/figma-ux` (3번째, order 13)
- 사용자 결정: 그릴 곳 = **원본 파일(첫 참고 주소의 파일)의 '작업안(UX봇)' 페이지**, 미리보기 후 그리기
- plan: spec_doc.figma_source로 참고 화면 글자 수집 → `claude -p`(도구 없음)가 설계안 JSON(screens: base node-id·layout·changes·states·policy) → runs/figma-ux/ux-*.json(+sources.txt). check_bases가 자료에 없는 node-id 제거
- revise: 수정 요청 → 새 버전(versions[]). draw: 헤드리스 `claude -p --tools ReadMcpResourceTool --allowedTools mcp__figma__*`(figma-use 스킬 리소스 읽고 use_figma) → 섹션 '[UX봇] 제목 vN · 날짜', 다른 페이지 수정 금지(clone만)
- 헤드리스에서 Figma MCP(use_figma 포함) 사용 가능 확인. 계정: COWAY 조직 View 시트 / DX/IT서비스센터 Pro Full 시트 → 원본 쓰기 권한은 첫 draw 때 확인 필요(미검증)
- 설계안 테스트: 매트리스 투데이(dSRZfxlfwHhwPFPtg0Ei7y 17002:60) 4화면, 71초·$0.15. index.html view ux_plan/ux_list. 미커밋
