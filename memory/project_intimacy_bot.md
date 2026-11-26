---
name: project-intimacy-bot
description: "IoT업무봇 '직원 친밀도' 봇(bots/intimacy, 그룹 기타) — 직원↔직원 상호작용 순위, 나만 보기(.gitignore 제외), 메신저 Playwright (2026-11-04)" (2026-11-11 화면 명칭 "직원 커뮤니케이션"으로 변경, 폴더·id는 intimacy 그대로)
metadata:
  node_type: memory
  type: project
  originSessionId: 857b9b24-4336-4825-8428-5a0947629e35
  modified: 2026-11-04T04:27:11.220Z
---

2026-11-04 추가. 사용자 결정: 범위 = **직원↔직원 전체**, 공개 = **나만 보기**(bots/intimacy/ 를 .gitignore 로 GitHub·팀 배포 제외 → Mac 동기화도 안 됨), 메신저 = **Edge 화면 읽기 포함**.

- 데이터: runs/intimacy/data.json — days{날짜:{"A|B":{소스:횟수}}}, people(이름→팀), seen(중복 방지 45일), last(소스별 마지막 수집). 내용은 저장 안 함
- 사람 키 = 한글 이름(2~4자, '[팀/직급]' 앞부분). 동명이인 구분 안 됨
- 소스: 메일(Gmail metadata, 보낸↔받는/참조, 수신 15명 초과·noreply 제외) · Jira(updated 기준 전 프로젝트, 댓글↔담당/보고/직전댓글/[~멘션], 상한 3000) · 위키(CQL page+comment, 한 번에 50건, ri:userkey 멘션·원글 작성자) · 구글시트(수정된 시트 comments, +email 멘션·답글) · 메신저(Playwright msedge 프로필 ~/.playwright-works-profile, li.item_chat 목록 → 방 열어 .inform_date/.msg_wrap/em.name/.status_box .date 읽기, 화자 바뀜·@멘션)
- 첫 수집 30일: Jira 648·메일 785(9분)·위키 58·시트 20. 메신저는 사용자 '메신저 로그인' 1회 후 미검증
- 화면: renderIntimacy (일간/주간/월간, 전체/나와의 관계, 최근 30일 소스별 누적 막대 --s1~--s5, 친밀도 순위·활발한 직원), ⟳ 실시간 반영

## 2026-11-04 개편 (사용자 요청)
- 화면 = **나와의 관계 메인**(KPI: 나의 상호작용·함께한 직원·가장 가까운 직원·전체 중 내 순위 / 나와 가까운 직원 표 / 나의 일별 차트 / 함께한 팀), **전체는 접힌 보조 영역**(details.imall, 직접 펼칠 때만 기억). board() 가 mine·all 을 한 번에 반환, scope 옵션 폐기
- 메신저: @태그(글자+멘션 요소) + **본문 속 이름**도 집계(메시지당 사람별 1회). 이름 일부(성 뺀 이름)는 같은 방 참여자만, 그 밖 직원은 전체 이름만, 이름 뒤는 조사·호칭·끝만 허용('보라색' 제외 확인)
- 메일은 코웨이 도메인(coway.com·partner.coway.com·coway.co.kr·coway.io)만 — 외부 12명(MCNC·라이온코리아·휴넷 등) 집계 삭제

관련: [[project-work-bot]]

## 2026-11-25 네이버웍스 자동 로그인
- 로그인 화면 = auth.worksmobile.com 회사 SSO 폼(#j_username 사번 미리 채워짐, #j_password, #btnSubmit, 추가 인증 안 보임)
- bots/intimacy/works_login.py try_login(page): 로그인 화면이면 DPAPI 저장 비밀번호(~/.config/work-bot/works_pw.dpapi)로 로그인 → 'ok'/'no_password'/'failed: …'. 비밀번호는 로그·화면에 안 남김
- 저장: bot-hub/works_pw_save.bat → bots/intimacy/works_pw_save.ps1 (Get-Credential 창, UTF-8 BOM). 비밀번호 바꾸면 다시 실행
- 적용: intimacy src_msg·messenger_login, scripts/calendar_wallpaper/morning_routine.read_messenger(아침·수시 갱신 모두). 실패 시 기존 로그인 창 대기. 백업 *.bak_20261125_autologin
