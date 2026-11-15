---
name: project-iocare-plus-proto
description: "IoCare+ 앱 웹 프로토타입 복사본(고도화 실험용) — projects/iocare-plus-proto, v1 기능·v2 디자인 (2026-11-13)"
metadata:
  node_type: memory
  type: project
  originSessionId: fa6f70fb-100a-4cf6-93b5-882559aef2fe
  modified: 2026-11-13T03:17:44.003Z
---

IoCare+ 앱의 고도화 실험용 복사본. 실제 앱 소스는 로컬에 없어 Figma(GNB·투데이·제품·더보기)를 기준으로 바닐라 HTML/JS PWA로 새로 만듦.

- 위치: C:\Users\20020911\projects\iocare-plus-proto (로컬 git, 미푸시)
- 파일: index.html, styles.css, icons.js(SVG 아이콘·제품군 컬러), data.js(제품 10종 제어·소모품·투데이·리포트 정의), app.js(해시 라우터·화면)
- 커밋: v1 기능 골격(21e09ec) → v2 디자인 고도화(dc354e7: 원형 게이지·도넛·다크모드·모션)
- GNB 5탭: 투데이/제품/리포트/자동화/더보기 + 장소 선택 시트·제품 등록 4단계(BLE/Wi-Fi 분기)·장소관리·알림
- 상태는 localStorage('iocare-proto-v1'), 더보기 > 데모 데이터 초기화
- 테스트: scratchpad Playwright(msedge) 스모크 테스트로 22개 화면 확인

**Why:** 사용자가 "iocare앱 복사본을 만들어 고도화해 보자"고 요청 (전체 제품군 범위 선택).
**How to apply:** 고도화 후속 요청 시 이 폴더에서 이어서 작업. 수치는 예시 데이터이며 정책은 [[project-iocare-loc-planning]]·[[project-iocare-ble-products]] 참고.
