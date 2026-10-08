---
name: 앱 데모 v2 (5종 완전 분화)
description: 마켓온/하우스/동네생활/머니로그/올인원을 톤·디자인·기능 전부 다르게 재설계한 로컬 프로토타입 세트 (2026-10-07)
type: project
originSessionId: cf3eed6b-8b58-426f-bbd1-716213e9db25
---
# app-examples v2

## 위치
`C:\Users\20020911\projects\app-examples-v2\` (로컬)

## 파일
- `index.html` — 5개 비교 랜딩 + 토큰 테이블 + 공통 원칙
- `01-marketon.html` — **에디토리얼 매거진** (오프화이트+테라코타, Noto Serif KR 900, Lookbook pin-tag, Waitlist)
- `02-house.html` — **코맨드 센터 다크 테크** (네이비+청록, Live chart, ⌘K Command Palette, 자동화 시뮬레이션, Guest QR)
- `03-community.html` — **소프트 핸드메이드** (크림+라즈베리, Do Hyeon, 5종 리액션, 번개 모임, 미니 지도뷰)
- `04-moneylog.html` — **미니멀 뱅킹** (순백+140px 숫자, 라임/적 2색만, 주간 리뷰 슬라이드, 구독 캘린더, "쓰지 말까요" 2초 지연)
- `05-superapp.html` — **네온 모자이크** (다크블루+5색 그라데이션, 조립식 위젯 홈, 미니앱 스토어, Today's Flow, 긴급 배너)
- `README.md` — 외부 세션 배포·활용 가이드

## 설계 원칙
- 5개 앱 **디자인·톤·폰트·레이아웃 완전 분화** (v1은 모두 동일 디자인 컨셉 6종 공유했었음)
- **사용 편의성 원칙만 공통**: 한 손 도달 · 44pt 타겟 · 즉시 피드백 · 되돌리기 · tabular-nums · aria/포커스/ESC

## v2.1 — 각 앱 톤별 전용 업그레이드 (2026-10-07)
공통 기능이 아니라 각 앱 성격에 맞춰 다른 성격의 업그레이드 추가 (JS node 구문 검사 통과).
- 마켓온 (Reading Experience): 리딩 프로그레스 바 · PDP bottom sheet · Save drawer · 페이드인 · 종이 질감
- 하우스 (Operational Depth): Floor plan SVG · Activity log 터미널 · Device detail flyout · Health Score 링
- 동네생활 (Community Life): 댓글 쓰레드 bottom sheet · 리액션 플라이어웨이 · typing indicator · 풀투리프레시 · 온도 카운터
- 머니로그 (Financial Clarity): 저축 목표 링 · 7일 스파크 바 · 월별 비교 바차트 · 카테고리 필터 · 인사이트 카드
- 올인원 (Live Services): 날씨 애니메이션 SVG · 알림 drawer · 포인트 링 · 음성 waveform · 라이브 티커

## 각 앱 디자인 컨셉 전환 UI (2026-10-07 추가)
각 앱의 톤에 맞춰 완전히 다른 UI 패턴으로 "컨셉 변경 버튼" 넣음. localStorage 저장.
- 마켓온: `ISSUE №26 ‹ ›` 매거진 호 네비 (26·25·24, 팔레트 함께 전환)
- 하우스: `> MODE DEFAULT▸` CLI 셀렉터 (DEF·FOC·PEAK·NGT)
- 동네생활: ☀️ 마스코트 탭하면 날씨 로테이션 (맑음·비·눈·봄)
- 머니로그: `···` 미니 메뉴 (Compact·Comfort·Loud — 숫자 크기)
- 올인원: ⭕⭕⭕⭕ 원형 피커 (Vibrant·Pastel·Mono·Cyber — 그라데이션 세트 통째 교체)

## v1과의 관계
- v1: `exercise0867.github.io/app-examples/` (GitHub Pages 공개) — [project_app_examples.md](project_app_examples.md) 참조
- v2는 그 리뷰 → 사용자 "5종 전부 다르게 고도화" 요청으로 재설계
- v1의 상호작용 깊이(송금 3단계, 공과금 체크 납부, 자동화 IF/THEN 등)는 유지하면서 디자인만 분화

**Why**: v1이 "같은 디자인 토큰·같은 6종 컨셉 토글" 공유해 비교 축이 흐렸음. 각 앱이 다른 세계관을 가져야 "기획 참고용 샘플"로서 가치가 큼.

**How to apply**: 사용자가 "앱 데모", "마켓온/하우스/동네생활/머니로그/올인원 v2", "고도화된 앱" 등 언급 시 위 로컬 경로 참조. 다른 세션(exercise0867)에서 반영하려면 README의 ①토큰 추출 / ②섹션 추출 / ③전체 교체 중 선택.
