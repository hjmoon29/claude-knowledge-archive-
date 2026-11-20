---
name: project_iot_example_apps
description: "IoT 기능 예시앱 5종(정수기·청정기·비데·매트리스·음식물처리기) 작성 중, 2026-11-20 이어서 검증 예정"
metadata:
  node_type: memory
  type: project
  originSessionId: 26624f8b-f4f3-44f8-831d-94543653fcc7
  modified: 2026-11-19T02:54:34.606Z
---

2026-11-19 "iot기능앱을 예시앱을 5개 만들어줘" 요청으로 작성 시작 → 사용자가 "내일 이어서 하자"로 중단.

- 위치: C:\Users\20020911\Downloads\IoT_예시앱\ (index.html, kit.js 공용 엔진, 1_정수기~5_음식물처리기.html)
- 구조: 각 HTML이 window.APP 설정(테마·제어·소모품·알림·루틴·FAQ·진단) → kit.js가 폰 프레임 UI 렌더
- 담은 IoT 기능: 등록·Wi-Fi 연결 4단계, 제어·상태(홈), 소모품(방문/자가관리), 알림·루틴, 스마트진단·문제해결·고객센터 — 주관부서표 v6의 기능 분류 기준
- 파일 작성만 끝남. **브라우저 실행·스크린샷 검증은 아직 안 함**

**How to apply:** 다음 대화에서 Playwright로 5개 앱 열어 오류·화면 확인 → 수정 → 사용자에게 결과 공유. 원하면 GitHub Pages 배포·공유 링크 여부 확인. 관련: [[project_app_examples_v2]]
