---
name: 네이버웍스 알림 발송 준비
description: 네이버웍스(Naver Works) Bot API 2.0 연동 스크립트 작성 완료, 자격증명 발급 대기 (2026-10-02)
type: project
originSessionId: 92734680-c1f9-4020-b571-b6464c0e1a45
---
## 상태 (2026-10-02)
- Python 모듈·설정 템플릿·가이드 작성 **완료**.
- Developer Console 등록 및 자격증명 입력은 **사용자 수동 작업 대기 중**.

**Why:** Daily Summary 등 자동화 결과를 Gmail 외 네이버웍스로도 받고 싶다는 요구.

**How to apply:** 자격증명 발급 완료되면 `naverworks-config.json` 채우고 `python naverworks_notify.py`로 ping 테스트. 이후 `daily_summary.py`에 send_text() 호출 추가 가능.

## 파일
- 모듈: `C:\Users\20020911\scripts\naverworks_notify.py` (JWT RS256 Bearer, Access Token 캐시, send_text/send_markdown/ping)
- 설정 템플릿: `C:\Users\20020911\.claude\naverworks-config.json` (placeholder)
- 토큰 캐시(자동생성): `C:\Users\20020911\.claude\naverworks-token-cache.json`
- 가이드: `C:\Users\20020911\scripts\naverworks_setup_guide.md`

## 사용자 선행 작업 체크리스트
1. [ ] https://developers.worksmobile.com/kr/console/openapi/main 접속 (코웨이 Admin 권한)
2. [ ] API 2.0 > App 신규 등록 → clientId/clientSecret/serviceAccountId/privateKey 발급
3. [ ] Bot 등록 → botId 발급, Admin 공개 승인
4. [ ] 알림 받을 톡방(1:1 or 그룹)에 봇 초대
5. [ ] `naverworks-config.json`에 값 입력 (privateKey는 `\n`으로 줄바꿈 치환)
6. [ ] `python naverworks_notify.py` ping 테스트
7. [ ] 성공 시 `daily_summary.py`에 send_text() 호출 추가

## 설치된 의존성
- PyJWT 2.15.1, cryptography 50.0.2 (2026-10-02 pip 설치)
- 기존 requests 재사용

## 보안
- `naverworks-config.json`은 claude-archive sanitize 대상에 **추가 필요** (TODO)
- Private Key 분실 시 Developer Console에서 재발급 필요
