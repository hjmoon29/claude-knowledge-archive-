---
name: project-calendar-wallpaper
description: 노트북 캘린더 월페이퍼 매일 자동 갱신 + 업무봇 아침 자동 실행(메신저·내 할 일·제품별 진행상황) — 예약 작업 IoTWorkBot_Morning (2026-11-11)
metadata:
  node_type: memory
  type: project
  originSessionId: c0755bc3-e333-4c4c-a9e5-95c08a271a38
  modified: 2026-11-11T01:34:24.137Z
---

매일 아침 업무봇 데이터를 갱신하고 `그림\캘린더월페이퍼.png`(1920×1080, 오른쪽 4개월 달력 2×2·오늘 청록 원)를 다시 그려 배경화면으로 지정. 2026-11-11 구축.

- 폴더 `C:\Users\20020911\scripts\calendar_wallpaper\`: make_wallpaper.py(render, 공휴일 HOLIDAYS 하드코딩 2028 상반기까지 — 매년 추가), morning_routine.py, morning.ps1, data\(morning.log, last_run.txt 하루 1회 도장, messenger_recent.json 로컬 전용, content.json, wallpaper_yymmdd.png)
- 예약 작업 **IoTWorkBot_Morning**: 매일 08:15 + 로그인 3분 후, run_hidden.vbs. 순서: ①메신저(친밀도 봇 Edge 프로필 ~/.playwright-works-profile, 세션이 브라우저 닫으면 끊김 → 로그인 창 띄워 최대 10분 대기 후 **같은 창에서** 읽음, 월요일은 금요일부터) ②내 할 일(mt.run) ③제품별 진행상황(ps.jira_fill, 데이터 G:/내 드라이브/IoT업무봇/product-status) ④Claude(sonnet) 요약 → content.json → 렌더 → SystemParametersInfo 적용. 요약 실패 시 지난 content로 달력만 갱신
- 수동: `python -I morning_routine.py --only wallpaper|messenger|tasks|products [--no-apply]` (--no-apply는 그림\캘린더월페이퍼_시안.png에만 저장), `--force`로 오늘 재실행
- 왼쪽 구성(사용자 지정): 담당 제품 다음 단계·날짜·D-day / 최근 오간 내용 5건(메신저·메일·Jira·업무) / 팀 일정 최린아·오가현·오종하님 3열
- 원본 백업 `그림\캘린더월페이퍼_원본백업.png` (11/11 시험 중 원본 덮어씀 → Photos 앱 사본으로 복구한 것)
- 기존 IoTWorkBot_0810(허브 실행)은 그대로. 관련 [[project-work-bot]], [[project-scheduled-tasks-hidden]]
- **(11/11) 수시 갱신 추가**: 예약 작업 **IoTWorkBot_Wallpaper** 평일 10·12·14·16시 → morning.ps1 --refresh. 로그인 창 안 띄움(메신저는 세션 살아 있을 때만, 아니면 지난 대화 사용), 내 할 일(1.5h 넘었으면)·제품별 진행상황·월페이퍼(~3분). 아침 갱신 안 됐으면 아침 갱신부터. dataun.lock(90분)으로 겹침 방지, tasks_last.txt. 아침 작업 08:12→08:15. 백업 *.bak_20261111_refresh
- **(11/25) 배치 변경(사용자 요청)**: 달력 6→4개월(2×2, x 1320/1610), 왼쪽 패널 폭 150~1230으로 확장, 담당 제품 2열, 팀 일정 2×2·사람당 4건 → 팀 일정이 화면 밖으로 잘리던 문제 해결. 백업 make_wallpaper.py.bak_20261125_layout

## 2026-11-25 팀 일정 8명으로 확대
- morning_routine.py TEAM = 최린아·오가현·오종하·김태현·원창연·김보라·최유나·문효준(마지막=나). 프롬프트 team 8명(일정 없으면 빈 items). make_wallpaper.py: 5명 이상이면 4열×2줄·사람당 3건, 일정 없으면 '예정 일정 없음'. 백업 *.bak_20261125_team8
- 11/25 팀원 업무량 게이지: scripts/calendar_wallpaper/team_load.py (Jira 담당 미해결 중 최근 2주 움직임/2주 내 기한·기한 지남, 월페이퍼 팀 일정 2주 내 개수, 내 메일함 from:그사람 3일, 메신저 업무방 2일 메시지 수, 5영업일 휴가). 가중치 W·FULL=40 → 0~100, 여유<35≤보통<60≤바쁨<80≤매우 바쁨. 이름 옆 5칸 게이지. 계정 캐시 data/team_users.json (김태현=asderio@coway.com, 동명이인 많아 최근 이슈에서 찾음). run_wallpaper에서 content["load"]. 백업 *.bak_20261125_load
- 팀 휴가 읽기는 구글 캘린더 로그인 만료 상태(11/25) — 로그인 창 10분 대기 후 건너뜀
- 11/25 게이지 단계 표기 영어로: Very Busy(≥80)·Busy(≥60)·Normal(≥35)·Light (사용자 요청)
- 11/25 메신저 전체 보관(사용자 지시: 목적별 검색 말고 매일 전체를 긁어 보관 후 필요한 정보 추출): scripts/calendar_wallpaper/messenger_archive.py → data/messenger_archive/YYYY-MM-DD.jsonl(이 PC만, 외부 업로드 X, scripts 폴더는 git 아님). read_messenger가 지난 보관일(state.json last_day)부터 전체 대화방(최대 300)·방마다 위로 스크롤해 전부 읽고 text 4000자·mentions 저장, 요약용 messenger_recent.json은 최근 창 40개/방 유지. team_load: 메신저 수(2일)+requests_to(이름+님/멘션 + '진행 바랍니다·부탁·검토 요청…' 7일) 가중 2.0, member_sources에 '메신저 요청'·'메신저 본인 업무' 줄. 사적 대화는 보관만, 표시·요약 X. -I 실행이라 sys.path.insert(HERE) 필요
- 팀원별 단서(member_sources): 완료 안 된 Jira·보낸 메일 제목 7일·회의 초대 14일 → 오종하님(팀장)처럼 주간보고 블록 없는 사람도 3칸 채움
- 11/26: 담당 제품을 표(구분·제품·다음 단계·그다음 단계·현재 상태, 줄무늬)로, 팀 일정 팀원당 5줄(프롬프트 최대 5개). 백업 make_wallpaper.py.bak_20261126_table, morning_routine.py.bak_20261126_team5
