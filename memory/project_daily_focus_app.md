---
name: 부부젤라 (구 Daily Focus) 웹앱
description: 부부 전용 D-Day·할일·기념일·가계부·기분 통합 PWA (Vanilla JS 단일파일), GitHub Pages 배포 (hjmoon29/vuvuzela)
type: project
originSessionId: b7a1fa91-0e80-4607-b53c-87648bd61e2e
---
# 부부젤라 웹앱 (구 Daily Focus)

**Why:** 2026-09-09 개인 생산성 PWA(Daily Focus)로 시작 → 2026-09-18 부부 전용앱 "부부젤라"로 전면 개편. "focus 앱", "부부젤라", "daily-focus" 언급 시 모두 이 프로젝트.

**How to apply:** 사용자가 focus 앱, daily-focus, 뽀모도로 관련 요청 시 이 리포지토리를 우선 참조. 로컬 클론은 `C:/Users/20020911/Documents/Projects/daily-focus/`. 커밋 시 GitHub Pages가 main 브랜치 루트를 자동 서빙하므로 push만 하면 배포됨.

## 위치
- **GitHub**: https://github.com/hjmoon29/vuvuzela (2026-09-18 daily-focus에서 리네임)
- **배포 URL**: https://hjmoon29.github.io/vuvuzela/ (GitHub Pages, main 브랜치 루트 서빙)
- **구 URL**: hjmoon29.github.io/daily-focus/ → 404 (GitHub이 리포 URL은 301 리다이렉트하지만 Pages 사이트는 리다이렉트 안 함)
- **로컬 클론**: `C:/Users/20020911/Documents/Projects/daily-focus/` (유일)
- **최초 생성**: 2026-09-09 06:27 UTC (KST 15:27)
- **통합 이력**: `~/Desktop/my-productivity-app/`는 같은 리포지토리 중복 클론이었음 → 2026-09-09 삭제

## 스택
- **Vanilla HTML/CSS/JS 단일 파일** (`index.html`에 모두 포함, 프레임워크 없음)
- **PWA**: `manifest.json` + `sw.js` (service worker, cache-first-then-network)
- **로컬 개발 서버**: `server.js` (Node.js http 모듈, 8080 포트, LAN IP 자동 안내로 폰 접속 가능)
- **저장소**: localStorage (서버 저장 없음, 순수 클라이언트)

## 파일 구성 (전체 7개)
```
index.html    (427줄) — 앱 전체 (스타일+마크업+로직)
manifest.json         — PWA 매니페스트 (한국어, portrait 고정, standalone)
sw.js                 — 서비스 워커 (CACHE = 'daily-focus-v1')
server.js             — 개발용 정적 서버 (LAN IP 표시)
icon-192.svg, icon-512.svg
README.md, .gitignore
```

## 기능 (v3 부부젤라, 2026-09-18 개편)
GNB 5탭 하단 고정 구조:
1. **🏠 홈** — D-Day 히어로 카드, 함께한 일수, 오늘의 기분(각자 8종 이모지), 감사 한줄(각자), 남은 할일/이번달 지출 통계
2. **✅ 할 일** — 담당자 배지(아내/남편/함께), 필터 칩, `us:todos` (owner 필드 포함)
3. **💝 기념일** — 매년 반복 옵션, D-Day 자동 정렬, `us:anniversaries`
4. **💰 가계부** — 수입/지출, 카테고리 이번달 합계, 담당자, `us:budget`
5. **⚙️ 더보기** — 프로필(이름/만난날/결혼일/홈D-Day소스), 오늘의 공유 메모(`us:notes-YYYY-MM-DD`), JSON 백업/복원/초기화

**데이터 네임스페이스**: 모든 신규 키는 `us:` 프리픽스 (`us:profile`, `us:todos`, `us:anniversaries`, `us:budget`, `us:mood-DATE`, `us:grat-DATE`, `us:notes-DATE`)
**마이그레이션**: 기존 `todos` → `us:todos` 자동 이관 (owner='both'), `us:migrated` 플래그로 1회만 실행
**제거된 기능**: 뽀모도로 타이머, Wake Lock, 세션 카운터 (개인 생산성 요소)

## 이전 기능 (v1-v2, 삭제됨)
- Pomodoro 25/5/15 타이머, sessions 카운터 — 부부 공동 앱과 맞지 않아 제거

## UI 컬러/디자인 (v3)
- 다크 웜톤: bg `#14111a`, panel `#1e1a26`, accent `#ff8fab`(핑크), accent-2 `#a29bfe`(라벤더), accent-3 `#ffc078`(피치)
- 담당자 컬러: wife `#ff8fab`, husband `#7aa2f7`, both `#c8a2ff`
- 단일 컬럼 세로 스크롤 + 하단 고정 GNB (safe-area-inset-bottom 대응)
- max-width 720px 중앙 정렬, body bottom padding = `calc(96px + env(safe-area-inset-bottom))` GNB 공간 확보

## 해결된 이슈 (2026-09-09 커밋 4e8ec98)
- **타이머 정확도**: `Date.now()` 기반 종료시각(`endAt`) 계산 → 백그라운드 throttle 무관하게 정확
- **자정 롤오버**: 매 분 & 가시상태 복귀 시 `todayKey()` 재계산 → 메모/세션/헤더 자동 갱신
- **Wake Lock**: `navigator.wakeLock.request('screen')` — 타이머 실행 중 활성화, "화면 유지" 배지 노출, hidden→visible 복귀 시 재요청
- **SW 업데이트**: HTML은 network-first로 전환 (즉시 반영), 자산은 SWR. 새 SW 감지 시 사용자에게 새로고침 토스트 → `SKIP_WAITING` 승인 후 자동 reload. **배포 시 `sw.js`의 `CACHE` 상수를 반드시 bump (예: v2→v3)**
- **Notifications**: Notification API로 백그라운드 알림, 미허용 시 가시상태일 때만 alert fallback. 첫 start 클릭 시 권한 요청

## 남은 개선 여지
- iOS Safari 백그라운드 알림 제약 (Notification API 지원이 최근 추가되었지만 홈 화면 설치 PWA에서만 동작)
- 통계/그래프 뷰 (일자별 세션 수 시각화) 없음
- 다크/라이트 테마 토글 없음 (다크만)

## 향후 작업 시 참고
- **XSS 안전**: `textContent`로 todo 텍스트 삽입 (innerHTML 아님) ✓
- **커밋/배포**: `git push origin main` → GitHub Pages 자동 반영 (수 분 지연)
- **로컬 테스트**: `node server.js` → `http://<LAN-IP>:8080` (같은 WiFi에서 폰 접속 가능)
- **PWA 설치**: 폰 Chrome/Safari에서 "홈 화면에 추가"
