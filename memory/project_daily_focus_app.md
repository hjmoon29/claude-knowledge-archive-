---
name: Daily Focus 웹앱
description: 뽀모도로+할일+메모 통합 개인 생산성 PWA (Vanilla JS 단일파일), GitHub Pages 배포 (hjmoon29/daily-focus)
type: project
originSessionId: b7a1fa91-0e80-4607-b53c-87648bd61e2e
---
# Daily Focus 웹앱

**Why:** 사용자가 2026-09-09 다른 Claude 세션에서 만든 개인 생산성 PWA. 향후 세션에서 "focus 앱" 언급 시 이 프로젝트임.

**How to apply:** 사용자가 focus 앱, daily-focus, 뽀모도로 관련 요청 시 이 리포지토리를 우선 참조. 로컬 클론은 `C:/Users/20020911/Documents/Projects/daily-focus/`. 커밋 시 GitHub Pages가 main 브랜치 루트를 자동 서빙하므로 push만 하면 배포됨.

## 위치
- **GitHub**: https://github.com/hjmoon29/daily-focus
- **배포 URL**: https://hjmoon29.github.io/daily-focus/ (GitHub Pages, main 브랜치 루트 서빙)
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

## 기능
1. **할 일 리스트** — 추가/체크/삭제, 완료 카운터, localStorage key: `todos`
2. **집중 타이머** — Focus 25 / Short Break 5 / Long Break 15 모드
   - 시작/일시정지(재개)/리셋 + `document.title`에 실시간 표시
   - 완료 시 Web Audio API로 660Hz 삐 소리 + `alert()`
   - Focus 세션 완료 시 자동 카운트
3. **오늘 세션 카운터** — localStorage key: `sessions` = `{[YYYY-MM-DD]: count}`
4. **오늘 메모** — 400ms 디바운스 자동저장, localStorage key: `notes-YYYY-MM-DD` (일자별 분리)

## UI 컬러/디자인
- 다크 테마 (Tokyo Night 계열): bg `#0f1115`, panel `#1a1d24`, accent `#7aa2f7`, accent-2 `#9ece6a`, danger `#f7768e`
- 3열 그리드 (`grid-template-columns: 1fr 1fr 1fr`), 900px 이하 1열 반응형
- `env(safe-area-inset-*)` iOS notch 대응
- 44px 최소 터치 영역 (모바일)

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
