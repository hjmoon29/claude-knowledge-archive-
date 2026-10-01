---
name: 쇠질모드 (Exercise) 웹앱
description: 운동용 미니멀 시계+스톱워치 PWA (블랙&화이트, 세로/가로 별도 레이아웃)
type: project
originSessionId: 9911f3ef-a1ea-4436-9640-20bc02b6135b
---
**저장소:** hjmoon29/exercise (GitHub Pages 자동 배포)
**URL:** https://hjmoon29.github.io/exercise/
**로컬 경로:** C:\Users\20020911\Documents\Projects\exercise
**로컬 실행:** `node server.js` → http://localhost:8090

## 앱 개요
- 순수 HTML/CSS/JS 단일 파일 PWA (`index.html` + `sw.js` + `manifest.json`)
- 검은 배경, 흰 텍스트, 미니멀 컨셉
- Anton/Bebas Neue 폰트, HH:MM:SS 통일 포맷
- 앱 명칭 = **쇠질모드** (title/manifest name/헤더 span 모두 통일)

## 방향별 레이아웃
| 요소 | 세로 (portrait) | 가로 (landscape) |
|---|---|---|
| 상단 헤더 | 팔뚝 아이콘(흑백반전) + '쇠질모드' 얇은 타이틀 | 숨김 (`display: none`) |
| 시작·초기화 버튼 | 아래쪽 pill 형태 | 좌우 가장자리 fixed 원형 (aspect-ratio 1) |
| 숫자 폰트 | 28vw 캡 320px | 36vh 캡 340px |
| 미세 스트레치 | scaleY(1.05) | scaleX(1.05) |

## 기술 포인트
- **Screen Wake Lock API** — 앱 활성 중 화면 꺼짐 방지, visibilitychange 재요청
- **scaleFit()** — 자릿수 span 폭 흔들림 방지 + 부모 폭에 맞춰 font-size 조정, landscape는 stretchX 5% 보정
- **아이콘 반전** — 원본은 흰 배경+회색 팔뚝, `filter: invert(1) brightness(2)`로 검은배경+흰팔뚝. blur 넣으면 흐릿해지므로 크기(28~38px)로 굵기 확보
- **SW 캐시 정책** — HTML은 network-first, 그 외는 cache-first. 배포 시 sw.js `CACHE` 상수 bump 필수 (v15 기준)

## 헤더 폰트
- 타이틀 폰트: Noto Sans KR wght 300 (Google Fonts), fallback: Apple SD Gothic Neo / Malgun Gothic
