---
name: project-work-bot
description: "업무 봇(구 봇 허브) — ~/Downloads/bot-hub 로컬 웹(127.0.0.1:8765), Jira 하위문서·기획 사양 정리·QA 대응·토큰 리포트 봇 (2026-10-20)"
metadata:
  node_type: memory
  type: project
  originSessionId: 2901365a-934a-4b84-9da5-7527e2f9182c
  modified: 2026-11-05T06:25:30.718Z
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

## 2026-11-05: 매일 08:10 자동 실행 (작업 스케줄러)
- 작업 `IoTWorkBot_0810` (매일 08:10, StartWhenAvailable) → wscript run_hidden.vbs → `scripts\start_workbot.ps1`: 8765가 이미 리슨 중이면 브라우저만 열고, 아니면 창없음 vbs 실행(중복 서버 방지). 시험 실행 결과 0·리슨 확인
- 이 시점 시작프로그램 `IoT업무봇.lnk` 는 없음(삭제됨)

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

## 2026-10-29: '내 할 일' 봇 `bots/my-tasks` (그룹 '내 업무', order 5, 맨 위)
- 1차 범위(사용자 확정): 메일(Gmail gmail.json, 보낸 메일 포함)·Jira(담당/보고/watcher/댓글 멘션)·위키(멘션+내 이름 CQL)·Drive 폴더(config drive_folder=01. IoT 기획 1cSMs35NALynrvac6jxmArWS_pPRgUwz-)·업무메모. 메신저는 2차 이후
- 증분: runs/my-tasks/state.json 소스별 last 시각, Drive는 drive_seen(파일별 modifiedTime)+cache/ 사본 → 처음 읽는 문서는 내 이름 줄만, 재수정은 바뀐 줄(+)만. 공유드라이브 폴더 맵 folders.json(7일 캐시, 6273폴더 26초)
- 할 일 누적 runs/my-tasks/tasks.json (new/update/done을 Claude가 판단, 화면에서 완료·내 일 아님·되돌리기)
- 업무메모 memo_clean: '<…비번…>' 등 구역·비밀값 줄 제거(검증: 비번 구역 0줄 유출)
- 아침 메일: 작업 스케줄러 `WorkBotMyTasks` 매일 08:10 (StartWhenAvailable) → morning.py, 로그 runs/my-tasks/morning.log. 설정 탭에서 시각·받는 사람·켜기/끄기
- 첫 실행(10/29): 7일치 217건 → 할 일 19건, 277초 · $2.11, 메일 발송 확인. 미커밋

## 2026-11-04: GitHub 푸시 완료
- 커밋 22914ab (main, hjmoon29/jira) — 그동안 미커밋이던 my-tasks·product-status·ims·figma-ux·jira 탭·코웨이 테마·메뉴 접기·실행파일 개명 등 50파일. runs/·*.bak* 는 .gitignore로 제외(제품별 진행상황 데이터 runs/product-status 는 로컬 전용)

## 2026-11-04: 왼쪽 메뉴 접기
- 왼쪽 메뉴 오른쪽 경계선 세로 가운데의 ‹/› 탭 버튼(#navtoggle, position fixed — 상단 ☰는 사용자가 비직관적이라 해서 폐기) 또는 Ctrl+B → .app.mini(64px 아이콘 메뉴, 본문 max-width 해제), localStorage hub.navMini 기억, 760px 이하에선 메뉴 완전 숨김

## 2026-11-04: '제품별 진행상황' 봇 `bots/product-status` (그룹 '내 업무', order 6)
- 제품(행) × 15단계(열: 킥오프·DPP·상품화 착수서 / IoT서비스 기능정의·IoT 기능정의서·세부 정의서·기획 사양 전달·Figma / 서버·앱·IMS / ITG·QA / 양산인정·출시) — 단계·키워드는 config.json
- 데이터 runs/product-status/products.json, 칸 클릭 → 상태(미착수/예정/진행중/완료/보류/해당없음)·날짜·메모·링크 직접 입력. 제품 추가·수정·삭제·순서·종료 표시
- Jira: 내 담당 진행 중 큰틀 에픽 → 제품 불러오기(5개 등록됨), 하위 문서('Epic Link' OR parent) 제목 키워드로 빈칸만 채움(src=Jira, 직접 입력 칸은 안 덮음)
- index.html renderPs·#psdlg, 백업 index.html.bak_20261104_ps. 미커밋
- 사용자 담당 확정(11/04): 해외향 정수기 [말련향] 아이콘 프로(CHP-7212N_V2)·[말련향] 엘리트 빌트인·[태국향] 아이콘 프로(최린아님 공동) + 좌욕 스파 비데. 매트리스·더매너·원가절감 비데·중국 ODM은 제외(excluded_epics로 Jira 재불러오기 차단). 말련 Jira 에픽 = IOCARERENEW2023-2810(2종 공유, 담당 최린아), 대만 에픽 = 2597. 태국 에픽 없음
- 11/04 단계 재구성(35열): 착수3 / IoT기획20(서비스 기능정의·모델별 기본정보·POP·기능정의서·알림·스마트진단·소모품·루틴·문제해결·앱 가이드·Figma·다국어·법무 + 맨 끝 '사양 전달 · 부서' 7개: 상품기획·제품개발/전장·플랫폼·서비스·앱/FE·디자인퍼블리싱·CS) / 개발6(제품 F/W·플랫폼/IMS·서비스 서버·앱 네이티브·FE·디자인퍼블리싱, 부서는 help) / 검증4 / 출시2. 근거: 최근 69개 제품 에픽 하위 문서 팀별 분석. 말련 2종 = 에픽 2810 공유 → jira_fill이 제품명 토큰으로 문서 구분. 이전 데이터 백업 products.json.bak_before_split
- 출처: 위키 전체 일정 111055323, 주간보고 Doc(LIVING '[말련향] 정수기 2종'·'[태국향] 정수기' 섹션), 모델별 기본 정보 v3.16 '2.0_모델 기본 정보 및 정책' 시트

## 2026-11-04: 내 할 일 → 워드 문서 저장 (메일 가시성 불만)
- 아침 08:10 실행 결과를 `~/Downloads/[IoT업무봇] 내 할 일_yymmdd.docx` 로 저장 (같은 날 덮어씀, 워드로 열려 있으면 _HHMM 붙임). 메일은 설정 `mail_on`(기본 꺼짐) 켜면 워드 첨부 + 요약 본문
- 서식 = '[기획 사양 정리] 말련향 정수기 2종' 9장 업무 가이드 복제 (원본 docx-js make_doc.js → python-docx `bots/my-tasks/docx_report.py`): H1 파란 글자+밑줄선, 근거 구분 배지(요청/Jira/약속/메모/추정/중요), ▍기한 묶음별 5열 표, 최근 완료 7일 2열 표, 푸터 Coway Confidential · 쪽
- 설정 탭 '지금 목록 워드로 저장'(save_now, 저장 후 파일 열기). index.html init이 체크박스 저장값도 반영하도록 수정. 백업 *.bak_20261104. 미커밋
- 2026-11-04 (2차): 상태 open/done/notmine/**hold(보류)**/deleted. 보류→할 일 되돌리기는 기한 필수(+중요도 선택), 삭제는 confirm. board(): 기한 지남(overdue_days, 빨간 박스/워드 빨간 소제목) → 기한 묶음(묶음 안 중요도→기한 순) → 보류 → 완료 날짜별(done_days, 30일; 워드는 7일) → 내 일 아님. 중요도 열(높음/보통/낮음)은 Claude가 프롬프트 기준으로 판단·재평가(update changes.priority), 보류 항목도 프롬프트에 status로 넘겨 중복 생성 방지. 화면 '워드로 저장·열기' 버튼. 백업 *.bak_20261104b

## 2026-11-04: 회의록 작성봇 `bots/minutes` (그룹 '내 업무', order 6)
- 사용자 선택: 음성 인식은 **PC 안에서**(faster-whisper large-v3-turbo int8, CPU 4스레드, beam 5, ko, VAD) — 음성은 외부 전송 안 함, Claude엔 녹취록 글자만. 모델 캐시 ~/.cache/huggingface (1.6GB). **PyAV는 <16 고정**(av 19는 faster-whisper 1.2.1의 metadata_errors 인자 제거로 오류)
- 속도(i5-10210U): 실제 길이의 약 1.2배 → 1시간 회의 ≈ 1시간. beam 1도 10%만 빨라 기본 5 유지. 화자 구분 없음(Claude가 문맥 추정)
- hub.py에 `/api/upload` 추가(X-File-Name, runs/uploads/, 4GB, 하루 지난 첨부 정리). index.html에 필드 type "file"(XHR 진행률 업로드 → 경로를 파라미터로) — 다른 봇도 재사용 가능
- 흐름: start → worker.py를 창 없이 낮은 우선순위로 분리 실행(파일 잠금으로 STT 1개씩) → job.json 진행률 → 목록 5초 자동 갱신 → 열기(미리보기 iframe, 버전 선택, 수정 요청 revise, 녹취록) → 위키 게시(제목·상위 페이지 입력, 같은 제목이면 갱신, 마지막 위치 config parent 기억). txt/vtt/srt 녹취록이면 STT 생략. 녹취록 원문 접기 옵션
- config glossary(말련향 등 용어)로 인식·정리 보정. 시험: TTS 45초 → 인식 80초 + 정리 43초 $0.08, 수정 요청 정상. 위키 게시는 미시험(사용자 첫 게시 때 확인). 시험 작업 m20261104-114200 남아 있음
- 처음 설치.bat에 python-docx faster-whisper "av>=11,<16" 추가. 백업 hub.py/index.html *.bak_20261104(c). 미커밋
- 2026-11-04: 회의록 작성봇 아이콘 🎙️ 이모지 → 선형 SVG 마이크(ICON_PATHS "minutes"). 새 봇 추가 시 ICON_PATHS에 bot id(폴더명)로 선형 SVG 꼭 추가. 백업 index.html.bak_20261104_mic

## 2026-11-04: '팀 휴가 캘린더' 봇 `bots/team-leave` (그룹 '내 업무', order 7)
- 네이버웍스 주소록 팀 화면(config orgunit_url …/orgunit/220000000766134, `span.text strong` = '이름 님[IoT기획팀/팀원(경조휴가)]')에서 상태 파싱(긴 상태 우선, 공백 무시) → 구글 캘린더 'IoT기획팀'에 오늘 종일 일정 '{name} {status}' (eventedit URL + 캘린더 선택 드롭다운 UI)
- 중복 방지: runs/team-leave/state.json (날짜·이름·상태) + 등록 전 일 보기에서 이름+상태 든 일정 있으면 건너뜀(사용자 요청)
- 프로필 ~/.playwright-teamleave-profile 하나에 웍스·구글 로그인(로그인 탭, 10분 대기). 자동: 작업 스케줄러 WorkBotTeamLeave 평일 08:40·10:00·13:30 → auto.py (설정 탭에서 켬, 아직 미등록)
- 11/04 첫 로그인 창 시간 초과(사용자 미로그인) → 캘린더 선택 UI(_calendar_pick)·일정 감지(day_events) 미검증. 미커밋

## 2026-11-04: GitHub 2차 푸시
- 커밋 46ebac4 (main) — 회의록 작성봇·팀 휴가 캘린더·동기화 미리보기/비밀값 검사·아이콘. bots/intimacy 는 .gitignore 제외. 원격과 동기화됨

## 2026-11-05: 반응형 넓은 화면
- index.html 끝 CSS: ≥1280px 본문 최대 1500px + 양식 짧은 입력란 여러 열(auto-fill 280px, textarea·목록·버튼 줄은 전체 폭, :has 사용) / ≥1600px 본문 최대 1840px. 1279px 이하는 이전과 같음. 백업 index.html.bak_20261105_resp
- 같은 날 사용자 요청: '최근 실행'은 오른쪽 열 X, 모든 화면 맨 아래 유지. 목록은 5건 높이만 보이고 나머지 스크롤(JS fitHist, 창 크기 바뀌면 재계산). 백업 index.html.bak_20261105_hist

## 2026-11-09: 팀 휴가 캘린더 '실행 중지'
- 탭 '실행 중지' + '지금 확인' 탭의 '⏹ 실행 중지' 버튼 → adapter `stop` → team_leave.stop(): 명령줄로 team-leave adapter.py/auto.py 프로세스 찾아 taskkill /T, `schtasks /end WorkBotTeamLeave`, 전용 프로필(.playwright-teamleave-profile) Edge 재스캔해 닫음. 결과는 taskkill 코드 말고 실제로 사라졌는지로 판단(하위 창 먼저 닫히면 코드≠0)
- 화면 공통: bot.json 액션/extra에 `bypass_busy: true` 면 다른 기능 실행 중에도 실행 가능(전역 busy 안 건드림). hub.py: 강제 종료(출력 없음+코드≠0) 시 '⏹ 실행이 중지되었습니다'
- 백업 *.bak_20261109, 미커밋

## 2026-11-09: 실행 중 잠금 봇별로 + 마지막 갱신 막대
- index.html: 전역 busy → 봇별(busyBots, holdBusy(id)가 해제 함수 반환, `busy`는 현재 봇 기준 getter). 다른 봇은 동시 실행 가능, 같은 봇만 막음(같은 저장 파일). 서버는 원래 ThreadingHTTPServer라 동시 처리 OK
- 원인 사례: 팀 휴가 미리보기가 로그인 대기로 9~11분 돌며 전체 화면을 막았음
- 내 할 일·제품별 진행상황 첫 탭 상단 `.fresh` 막대(freshBar): 마지막 갱신 시각 크게 + n시간 전, 24시간 넘으면 빨강. 버튼: 내 할 일 '↻ 지금 새로 찾기'(find 기본값으로 실행, 결과는 board 탭) / 제품별 '↻ 지금 새로 가져오기'(jira_fill — 기존 'Jira 하위 문서로 빈칸 채우기' 버튼을 이걸로 옮김)
- 백업 index.html.bak_20261109b. 새 노트북에서 내 할 일 '매일 아침 자동 실행 꺼짐' 상태 확인됨(11/05 08:10 이후 미실행)

## 2026-11-09: 진행률 게이지 (공통 장치)
- `bots/hub_progress.py`: progress(pct,msg) / stage(a,b,msg) 하위 구간 / waiting(a,b,msg,fn,est_sec) 끝을 모르는 작업(Claude)은 지난 소요시간 기준 지수로 채움(95%까지). 허브 밖 실행(예약)에선 무동작
- hub.py: 실행마다 env BOT_HUB_PROGRESS=runs/progress/<bot>__<action>.json, bot.json 액션 `progress:true`면 ACTIVE 등록 → GET `/api/progress?bot=` (새로 고침 뒤 복원용). 끝나면 파일 삭제
- bot.json `progress: true` + `progress_tab: "board"`(게이지를 보일 탭). 적용: my-tasks find(자료 0~45%·Drive 파일별·Claude 45~92%·state.claude_sec 학습·워드/메일), product-status jira_fill(제품별)
- index.html: progHTML/paintProg/watchProgress/resumeProgress, runs[k].prog 저장 → 탭/봇 이동·새로 고침 후에도 유지. runAction은 실행 중에도 이전 res 보존, 같은 봇 실행 중이면 auto 탭은 저장 결과(없으면 조용히 board 조회)+게이지
- 시험: 가짜 봇으로 서버 경로, 브라우저 route 모킹으로 화면(이동·복귀·새로 고침 복원) 확인. 실제 find/jira_fill 실행으로는 미확인
- 팀 배포 zip 만들 때 bots/hub_progress.py 포함 필요(화이트리스트). 백업 *.bak_20261109c

## 2026-11-09: 제품별 진행상황 '출시' / '운영 배포' 분리 + 해외향 출시 일정 갱신
- config stages: release(출시, jira ["출시"]) + deploy(운영 배포, jira ["운영 배포","운영배포","앱 오픈","앱오픈"]) 분리. 백업 config.json.bak_20261109_deploy, 데이터 백업 products.json.bak_20261109_release (Drive G:/내 드라이브/IoT업무봇/product-status)
- 최신 일정 출처는 위키·주간보고가 아니라 상품기획 시트: [말/대/태] 아이콘 프로 프로젝트 개요 1ZqpbniBxFO4VeXqunP8eyBvIYf0aFFftBZHQkJJLjZI, 통합 착수서 1DPL_m7r-178g836ZI7YPaDcZvubWAY1nv95hmJnpZPk('8)개발일정'), 엘리트 빌트인 협업 시트 1hBULMQJfPXRWkzWlxxzhoRxHAKmKgCfICdSz5itVLhw
- 11/9 기준: 말련 아이콘 프로 출시 28/1/3·양산인정 27/11/16 / 엘리트 빌트인 출시 28/2월中(27/11→28/2)·양산인정 27/12/2 / 태국 아이콘 프로 출시 27/12M(확인 필요)·양산인정 27/10/14. 운영 배포는 세 제품 모두 미정. 위키(111055323)·주간보고는 아직 27/11M·27/6M로 미갱신

## 2026-11-09: 진행률 게이지 6개 봇 추가 적용
- progress:true — qa(answer·run_now: 이슈 읽기 5~22·참고자료 22~30·Claude 15건 단위 30~90·엑셀), spec-doc draft(collect(prog=)로 위키·Figma·Drive 0~45, Claude 45~97 예상=지난 초안 글자당 시간), figma-ux plan·revise·draw(past_sec 평균, draw는 화면 수 비례), intimacy refresh(소스별 가중치), minutes revise, team-leave run·preview·login(단계 + 로그인 남은 시간 카운트다운)
- 회의록 백그라운드: worker.py 가 job.pct(음성 인식 0~80, 정리 80~99 지난 평균 기준, 완료 100) 기록, 목록에 progHTML 게이지. tick 스레드는 최종 저장 전에 join
- 화면: #progzone(결과 카드 위) = 별도 버튼으로 실행한 기능 게이지 모음(startProg(botId, actId, label)), 현재 봇 것만. 일반 실행 버튼 기능은 #st 옆
- 시험: 각 봇 실제 코드를 외부 호출 스텁으로 실행(BOT_HUB_RUNS 임시) + 화면 route 모킹. 실데이터 실행은 미확인. 백업 *.bak_20261109d

## 2026-11-11: 공통 '중지' 기능 + 명칭 변경
- hub.py: 기능 실행을 Popen(새 프로세스 그룹)으로 바꾸고 RUNNING 등록 → POST /api/stop {bot, action?} 이 taskkill /T /F 로 하위(Edge·Claude)까지 종료, runs/<봇>/*.lock 삭제, 결과 {stopped:true, headline '⏹ 실행이 중지되었습니다'}. GET /api/running 추가
- index.html: stopBtn(s) — 진행률 게이지(progHTML) 오른쪽, 게이지 없는 기능은 1초 뒤 상태줄 옆 '■ 중지'(확인창). runs 항목에 bot·act 저장. 백업 hub.py.bak_20261111_stop, index.html.bak_20261111_stop
- 시험: intimacy refresh 실행 1.5초 뒤 중지 → 0.5초 만에 종료, run.lock 정리 확인
- '직원 친밀도' → 화면 명칭 '직원 커뮤니케이션' (폴더 id intimacy 유지)
- 제품별 진행상황 순서: 좌욕 스파 비데 맨 위 (Drive products.json, 백업 .bak_20261111_order)
- 2026-11-11: '앱 연결 QR·URL 등록' 봇 추가(bots/qr-url, 기획 업무 그룹, order 14) — URL정의서 행 추가·QR 생성 업로드·문서이력(같은 버전 이어쓰기/작성자별 행 분리·병합/새 버전 사본백업+파일명 변경), QR 다시 만들기, 목록 확인. 시트 사본으로 3가지 이력 모드 실측 검증 후 테스트 파일 휴지통. 미푸시(동기화 '변경 올리기' 필요). 쓰기 토큰: ~/.gmail-mcp/gsheets-token.json(이 PC) / 팀원은 credentials.json gdrive_write_token 필요
- 2026-11-11 왼쪽 메뉴 개선(1~7): 묶음 간격 18px·제목 진하게, 접기 버튼 위쪽(topbar+12px), '기타'→'리포트'에 직원 커뮤니케이션, 팀 휴가 캘린더→사내 예약(order 22), 이름 통일(Jira 자동 생성·기획 사양 정리(위키)·회의록 작성·Figma UX 기획 — README·팀원 설치 안내·SKILL 포함), 배지(hub.py /api/badges: 내 할 일 오늘·지난 기한 수 빨강, 동기화 올릴 변경 주황 점, 60초 갱신). 백업 *.bak_20261111_nav. 서버 재시작함. 미푸시
## 2026-11-12: '프로젝트 대응' 봇 추가 (bots/projects, 내 업무 맨 위)
- 프로젝트별 탭 → 지금 상황(Claude 요약)·해야 할 일·메일·Jira 생성/변경·파일 섹션. 처음엔 제품별 진행상황 products.json에서 시드(종료 제외)
- 메일: 키워드(+지역어 AND) Gmail 검색, 자동리포트·[COWAY-JIRA] 알림 제외(config mail_exclude). 첨부 받기 → ~/Downloads/IoT업무봇/<프로젝트>/ 저장 후 미리보기. 답장 초안(sonnet, 보내지 않음)
- Jira: 에픽 하위 changelog(생성·상태·담당·기한·댓글). 같은 에픽 공유 프로젝트(말련향 2종)는 제목 키워드로 구분. '처리' = 댓글·상태 전환 즉시 반영
- 파일: 다운로드 최근 90일 xlsx/pptx/docx/pdf/csv 키워드 매칭 + 직접 연결. 미리보기(xlsx 80행·pptx 글자·docx). .txt·'업무내용' 등 이름은 목록·열기 모두 차단(업무메모 계정정보)
- 데이터 runs/projects/{projects.json,data/<id>.json}, 증분(mail_at/jira_at). 백업 index.html.bak_20261112_projects. 미커밋, 자동 예약 실행은 아직 없음
- 11/12 오후: 프로젝트 대응을 **전용 화면**으로 분리 — 상단 바 [🗂️ 프로젝트 대응 | 🧰 업무 도구] 전환(hub.mode, 기본 pj). 프로젝트 모드: 왼쪽=프로젝트 목록(#pjside, 배지), 본문 전체=#pjmain(헤더+한눈에 2열 대시보드: 상황·할일 | 메일·Jira, 아래 파일). 업무 도구 목록에서는 projects 봇 제외(selectBot이 projects면 pj 모드로). 백업 index.html.bak_20261112_pjmode
- 11/12: 프로젝트 목록 드래그 순서 변경(reorder 액션, 즉시 화면 반영 후 저장) + 제품 종류 아이콘(정수기·비데·공기청정기·매트리스·식기세척기·에어컨·가습기·제습기·기타 SVG). 종류는 이름·모델명 자동 추정(guess_category), ✎ '제품 종류'에서 직접 지정 가능. 백업 index.html.bak_20261112_drag, projects.py.bak_20261112_icon
- 11/12: 프로젝트 새로 확인에 **메일 첨부 자동 저장**(본문 그림 제외, ~/Downloads/IoT업무봇/<프로젝트>/, 같은 이름·크기면 건너뜀, 다른 내용이면 _yymmdd_HHMM) + **다운로드 폴더 전체 스캔**(하위 4단계, bot-hub·claude-daily-summary·'개인' 폴더 제외, 폴더 이름 키워드도 매칭). **아침 자동 확인** 작업 스케줄러 `WorkBotProjects` 매일 08:20 → bots/projects/morning.py(pythonw), 로그 runs/projects/morning.log, run.lock으로 화면 실행과 겹침 방지. 왼쪽 아래 '⏰ 매일 아침 자동 확인' 버튼에서 켜기/시각 변경. 11/12 10:00 수동 실행 검증 완료. PDF는 화면 미리보기 미지원(열기만)

## 2026-11-24: 제품별 진행상황 단계 순서 재배치
- 착수: 킥오프→상품화 착수서→DPP / IoT기획: 기능정의서 바로 뒤 '사양 전달·제품 개발·전장', Figma 뒤로 문제해결·앱 가이드 / 개발: 디자인·퍼블리싱을 앱·FE 앞 / 출시: 양산인정→운영 배포→출시
- 순서만 변경(id 동일, 데이터 영향 없음). 백업 bots/product-status/config.json.bak_20261124_order. 커밋·푸시 6c968bf(config.json만, index.html·bots/projects는 미커밋 유지)

## 2026-11-25: 제품별 진행상황 'Jira 프로젝트 생성' 단계 (킥오프 다음)
- config stage id `jira_epic`(착수 그룹). jira_fill이 제품의 에픽 자체를 조회해 상태 완료·날짜=에픽 생성일·메모 '키 제목 · 하위 문서 n건' 자동 채움(직접 입력 칸은 안 덮음). 백업 config.json/product_status.py .bak_20261125_jiraepic, 데이터 products.json.bak_20261125_jiraepic
- 태국향 아이콘 프로 에픽 = IOCARERENEW2023-3154 연결(제품별·프로젝트 대응 둘 다). 대만향 더매너 비데 플러스(3340)·더블케어 비데(3341) 추가. 미커밋
- 11/25 DPP 칸 분리: dpp=label '1차 DPP'(jira ['1차 DPP']) + dpp2 '2차 DPP'(jira ['2차 DPP']). 백업 config.json.bak_20261125_dpp2·products.json.bak_20261125_dpp2
- 11/25 일정 갱신: 좌욕스파 비데 출시 27/3/2(11/24 안정수님 메일, 기존 3/29), 양산인정은 김영표님 세부 일정 안내 대기. 정수기 3종은 프로젝트 개요·협업시트와 동일 확인
- 11/25 DPP 1·2차 통합: 1차 칸 메모에 '통합' 있거나 Jira 문서가 차수 없는 'DPP'(2차 DPP 문서 없음)면 sync_dpp()가 2차 칸을 1차와 같은 상태·'1·2차 통합 DPP' 메모(src '통합')로 자동 표시. 직접 입력한 2차 칸은 안 덮음. 백업 product_status.py.bak_20261125_dppmerge

## 2026-11-25: 문서이력 자동 반영 + 프로젝트 대응 통합 + PC 시작 자동 실행
- `bots/product-status/doc_sync.py`: 모델별 기본정보·IoT기능정의서 '문서이력' 새 행 → 제품 매칭(config doc_sync.products match/proj_code) → 내 담당 Jira(제품 기본 정보/제품 기능 정의/POP)에 댓글+상태 전진(기본정보: 2.0 탭 TBD 없고 시트 출시월=진행상황 출시월이면 해결, POP 칸 다 차면 POP 해결, 기능정의서는 할 일→진행 중만). 남의 담당 문서는 안 건드리고 알림에만. 진행상황 칸 갱신(직접 입력·더 최근 정리 칸은 메모 유지). 메일(gmail.json)+Windows 토스트 알림. state=Drive product-status/doc_sync_state.json, 로그 runs/product-status/doc_sync.log. 작업 WorkBotDocSync 평일 09:30·13:30·17:30. 첫 실행 11/25: 3027·3023 할 일→진행 중, 2915·2925 댓글
- 제품별 진행상황 → 프로젝트 대응 화면 '전체 진행상황'(pjSel "__ps", 들어가면 항상 먼저). 업무 도구 목록에서 제외. 제품 화면 상단에 그 제품 단계 칩 줄(pjPsStrip, 칩 누르면 입력). '지금 상황' 색 배지 카드(pjSumHTML, 결정/진행/이슈/미정/다음), 요약 프롬프트도 줄마다 머리말 형식으로. 할 일 ✓완료·⏸보류·✕삭제(+보류/완료 목록에서 다시 열기), projects.mark에 hold, 보류 항목은 Claude가 재생성 안 하게 프롬프트에 전달. 백업 index.html.bak_20261125_pjps/pjps2, projects.py.bak_20261125_hold
- PC 시작: 작업 `IoTWorkBot_Startup`(로그온+30초) → bots/startup_refresh.py: start_workbot.ps1 → 네트워크 대기 → morning_routine.py --force(메신저·팀휴가·내 할 일·진행상황·월페이퍼) → doc_sync → projects/morning.py → intimacy.refresh → 토스트. 로그 runs/startup.log. 사용자 요청으로 IoTWorkBot_0810·IoTWorkBot_Morning·WorkBotProjects(08:20) 비활성화(삭제 아님). 낮 IoTWorkBot_Wallpaper·WorkBotDocSync는 유지. 프로젝트 화면 자동 확인 버튼은 'PC 켤 때 켜짐' 표시
- 미커밋
- 11/25 해외향 단계 추가(출처: 본사 IoT 업무 주관부서·담당자 문서 19DqANPl…): ovs_policy(법인 판매·운영 정책, 착수)·ovs_member(통합회원 국가·언어)·ovs_cs(고객센터 연락처 IMS)·ovs_photo(포토모드 법무, only 아이콘 프로)·ovs_terms_pub(약관 번역·게시·IMS)·ovs_erp(ERP 연동, 개발)·ovs_field(현지 필드테스트, 검증)·ovs_store·ovs_train(출시) + 공통 qr(매뉴얼 앱 다운로드 QR). i18n은 '지원 언어·앱 번역'(해외향 전용), legal 키워드에서 '법무' 제외. stage에 regions/only 속성 → product_status.apply_scope()가 load 때 비해당 칸을 '해당없음'(src 자동)으로, 향지 바뀌면 자동 칸 해제. 백업 config/product_status .bak_20261125_ovs, products.json.bak_20261125_ovs. 제품 화면 진행상황 줄은 줄바꿈 배치
- 11/25 비고: 첫 줄=핵심(항상 표시, ⚠ 시작 시 빨강), 둘째 줄부터 '상세 n줄' 접힘(psNoteHTML) — 전체 표 비고 칸·제품 화면 진행상황 상단(✎ 비고 버튼) 공통. 6개 제품 비고 재정리. 백업 index.html/products.json .bak_20261125_note
- 11/25: 첫 화면을 항상 「프로젝트 대응」으로 고정(index.html 끝 setMode("pj"), 이전엔 마지막 모드 hub.mode 기억). 백업 index.html.bak_20261125_firstpj, 미커밋

## 2026-11-26: '통합테스트 TC 작성' 봇 `bots/tc-writer` (기획 업무, order 15)
- draft: 제품명(+모델) → IoT기능정의서 최신본(사본·백업·FE 제외)에서 제품 열 블록 자동 추출(제목 줄에서 모델/토큰 매칭, '-'·빈 행 제외) → 탭으로 제품군 결정 → 참고 TC = Drive '10. [기획] 통합테스트 TC'(1ET-QxYJ…) 제품군 폴더(01_water·02_air·03_sleep·04_living, water는 검수/01.통합테스트 TC도) 최근 시트 중 '2. IoT App 통합 테스트_TC' 탭 있는 것 → Figma 제품군 02_제품 파일(표지·이력·작업안/작업본·SPEC 제외 페이지 스킵, 선택 시 00_03제품등록) → claude -p opus[1m] JSON(overview·tc[]·review_points) → runs/tc-writer/tc-*.json
- create: 참고 TC를 제품군 폴더에 files.copy(서식·참고 탭 유지) → 표지·문서이력(v0.1)·개요(프로젝트 정보·진행방향·일정 TBD)·TC 행(행 삭제/삽입+row 서식 복사+가로 병합 MERGE_ROWS+구분 열 세로 병합, RAW 쓰기, 행 높이 자동)·이슈 탭 비움. 쓰기 토큰은 qr_url.token()
- 설정 bots/tc-writer/config.json (제품군→폴더·기능정의서 탭·Figma 키). Figma 토큰은 projects:read 범위 없어 파일 목록 API 불가 → 키 고정
- 시험 11/26: 좌욕스파 비데 BASH53-A → 90행·확인 필요 18건, 4분 30초·$1.28, 문서 생성 1jJ7Gmh1iQ5vMaR57t6bKnKQS5J81QI4earFCxNLokHI (04_living). TC 머리의 검토·승인 담당자 이름은 참고 문서 값 유지
- index.html view tc_draft/tc_list·아이콘(백업 index.html.bak_20261126_tc). 미커밋, 팀 배포 zip 화이트리스트에 bots/tc-writer 추가 필요
