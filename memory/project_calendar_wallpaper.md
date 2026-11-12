---
name: project-calendar-wallpaper
description: 노트북 캘린더 월페이퍼 매일 자동 갱신 + 업무봇 아침 자동 실행(메신저·내 할 일·제품별 진행상황) — 예약 작업 IoTWorkBot_Morning (2026-11-11)
metadata:
  node_type: memory
  type: project
  originSessionId: c0755bc3-e333-4c4c-a9e5-95c08a271a38
  modified: 2026-11-11T01:34:24.137Z
---

매일 아침 업무봇 데이터를 갱신하고 `그림\캘린더월페이퍼.png`(1920×1080, 오른쪽 6개월 달력·오늘 청록 원)를 다시 그려 배경화면으로 지정. 2026-11-11 구축.

- 폴더 `C:\Users\20020911\scripts\calendar_wallpaper\`: make_wallpaper.py(render, 공휴일 HOLIDAYS 하드코딩 2028 상반기까지 — 매년 추가), morning_routine.py, morning.ps1, data\(morning.log, last_run.txt 하루 1회 도장, messenger_recent.json 로컬 전용, content.json, wallpaper_yymmdd.png)
- 예약 작업 **IoTWorkBot_Morning**: 매일 08:15 + 로그인 3분 후, run_hidden.vbs. 순서: ①메신저(친밀도 봇 Edge 프로필 ~/.playwright-works-profile, 세션이 브라우저 닫으면 끊김 → 로그인 창 띄워 최대 10분 대기 후 **같은 창에서** 읽음, 월요일은 금요일부터) ②내 할 일(mt.run) ③제품별 진행상황(ps.jira_fill, 데이터 G:/내 드라이브/IoT업무봇/product-status) ④Claude(sonnet) 요약 → content.json → 렌더 → SystemParametersInfo 적용. 요약 실패 시 지난 content로 달력만 갱신
- 수동: `python -I morning_routine.py --only wallpaper|messenger|tasks|products [--no-apply]` (--no-apply는 그림\캘린더월페이퍼_시안.png에만 저장), `--force`로 오늘 재실행
- 왼쪽 구성(사용자 지정): 담당 제품 다음 단계·날짜·D-day / 최근 오간 내용 5건(메신저·메일·Jira·업무) / 팀 일정 최린아·오가현·오종하님 3열
- 원본 백업 `그림\캘린더월페이퍼_원본백업.png` (11/11 시험 중 원본 덮어씀 → Photos 앱 사본으로 복구한 것)
- 기존 IoTWorkBot_0810(허브 실행)은 그대로. 관련 [[project-work-bot]], [[project-scheduled-tasks-hidden]]
- **(11/11) 수시 갱신 추가**: 예약 작업 **IoTWorkBot_Wallpaper** 평일 10·12·14·16시 → morning.ps1 --refresh. 로그인 창 안 띄움(메신저는 세션 살아 있을 때만, 아니면 지난 대화 사용), 내 할 일(1.5h 넘었으면)·제품별 진행상황·월페이퍼(~3분). 아침 갱신 안 됐으면 아침 갱신부터. dataun.lock(90분)으로 겹침 방지, tasks_last.txt. 아침 작업 08:12→08:15. 백업 *.bak_20261111_refresh
