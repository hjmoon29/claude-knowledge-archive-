---
name: IoT 기획 Google Drive 폴더 구조 및 핵심 문서
description: 01. IoT 기획 Google Drive 공유폴더 전체 구조, 핵심 스프레드시트 ID, 학습된 내용 요약 (2026-06-11)
type: project
originSessionId: 72069768-bafa-44c4-a8f5-1c172aa0d67a
---
## 폴더 기본 정보
- 폴더 ID: `1cSMs35NALynrvac6jxmArWS_pPRgUwz-`
- 폴더명: 01. IoT 기획 (공유드라이브)
- 총 규모: 폴더 1,179개 / 파일 3,427개 (스프레드시트 559개)

## 최상위 서브폴더 9개
1. 01. IoCare 1.0
2. 02. IoCare 2.0
3. 03. NECOA
4. 09. 서비스매니저 페어링 앱
5. 10. 프로젝트
6. 30. IoT운영
7. 70. 제품 공유자료
8. 90. 공유
9. 99. IoT 기획 (내부용) - 위치 이동 예정

## 핵심 스프레드시트 (최신 버전 기준)

| 문서명 | 파일 ID | 시트 구성 |
|--------|---------|----------|
| 모델별 기본 정보 및 기능정의_v.2.81_20260608 | `1p8COpGH5aCzjwQ582BvcxYdWs6qTmol7btSHvoJYld8` | 출시모델별 서비스지원여부, 2.0_모델기본정보, 비데군/청정기군/정수기군 기능정의 등 14개 시트 |
| CW_IoCare_제품_기능정의서_v2.21_20260611 | `1w15PUJrj9uqBBfZQLJrbYqSmm66NPC8gpf3vyQS2nkU` | 정수기, 청정기, 제습기, 매트리스, 개인형비데, 모션베드, 음식물처리기, 에어컨, 로봇청소기 등 12개 시트 |
| IoCare+ Release Note (2026) | `188DxdGgeOr4s9dAoKLvzc7yHr4Q8THX4hIQrXKoQoXk` | 참고사항, 배포미정, 26.1~26.6 |
| CW_IoCare_소모품_정의서_v1.69_260610 | (검색 필요) | 소모품 교체주기 |
| CW_IoCare_알림_정의서_v1.22_260420 | (검색 필요) | 알림 정의 |
| CW_IoCare_자동화_정의서_V1.01_260420 | (검색 필요) | 자동화 정의 |

**Why:** 사용자가 IoCare+ IoT 기획 관련 질문 시 이 Drive 폴더의 문서들을 참조해서 답변해야 함
**How to apply:** 매트리스·비데·정수기·청정기 등 제품별 기능 질문 시 위 파일 ID로 Sheets API 직접 조회. 토큰 만료 시 gsheets-token.json의 refresh_token으로 갱신 필요.

## 매트리스 모델 현황 (v2.81 기준)
- S5: CMSS/CMQ/CMK-AS02 (IoCare+ ○, IoCare 1.0 ○)
- S7: CMSS/CMQ/CMK-AS03 (IoCare+ ○, IoCare 1.0 ○)
- S6+: CMSS/CMQ/CMK/CMLK-AS04 NV/BG (IoCare+ ○ 전용)
- S8+: CMSS/CMQ/CMK/CMLK-AS05 NV/BG/_RA/_EM (IoCare+ ○ 전용)
- 해외(말레이시아): S6+(CMK-AS04_NV), S8+(CMK-AS05_NV)

## 스마트 집중케어 지원 모델 (제품기능정의서 v2.21 기준)
- S5: **미지원**
- S7: **지원** (부위: 머리/허리/다리, 회수: 3/4/5회)
- S6+: **지원** (부위: 머리/허리/다리, 회수: 3/4/5회)
- S8+: **지원** (부위: 머리/허리/다리, 회수: 3/5/7/10회)

## IoCare+ Release Note 26.6.1 주요 배포 (2026-06-08)
- 신규 제품: 커피 얼음 정수기 (CHPCI-8400N)
- 신규 제품: C-Mighty 유럽향 청정기, Airmega 450S 유럽향
- 매트리스: S6+/S8+ 제품등록 시 앱 표시 명칭 변경 (사이즈 표시 삭제)
- 에어컨: ODM 프로토콜 기반 연결/상태/제어 기능 추가

## OAuth 토큰 갱신 방법
토큰 파일: `C:\Users\20020911\.gmail-mcp\gsheets-token.json`
만료 확인: `$tokenData.expiry_date` vs 현재 UnixTimeMilliseconds 비교
갱신: `https://oauth2.googleapis.com/token` POST with refresh_token
BOM 없이 저장: `[System.IO.File]::WriteAllText(path, json, New-Object System.Text.UTF8Encoding $false)`
