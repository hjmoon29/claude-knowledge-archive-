---
name: feedback-login-window-center
description: 자동화가 로그인 창(Edge/Playwright)을 띄울 때는 주 모니터 화면 가운데에 띄운다
metadata:
  node_type: memory
  type: feedback
  originSessionId: c0755bc3-e333-4c4c-a9e5-95c08a271a38
  modified: 2026-11-11T01:53:02.205Z
---

Playwright/Edge 로그인 창(네이버웍스·구글 등)을 사용자에게 띄울 때는 주 모니터 가운데에 적당한 크기(약 1200×860)로 띄우고 bring_to_front 한다. 기본 위치(측면)는 잘 안 보인다.

**Why:** 2026-11-11 사용자 — "앞으로 로그인창 띄울때 화면 가운데에 띄워줘 측면에 있어서 잘 안보인다". (노트북 1536×864 + 외부 1920×1080 2대, 주 모니터는 외부)
**How to apply:** `--window-position=x,y --window-size=w,h` 를 GetSystemMetrics(0/1)로 계산 (캘린더 월페이퍼 morning_routine.py `center_args()`·`open_login()` 참고). 업무봇의 다른 봇(친밀도 messenger_login, 팀 휴가 login 등)을 고칠 때도 같은 방식으로. 관련 [[project-calendar-wallpaper]]
