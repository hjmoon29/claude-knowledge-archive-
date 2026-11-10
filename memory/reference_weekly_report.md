---
name: 주간보고 Google 문서 위치 & 담당 파트
description: 팀 주간보고 Google Docs URL과 사용자(hjmoon)가 담당하는 제품 파트
type: reference
originSessionId: 78162927-fdeb-4322-a0a3-a7677bb9eba1
modified: 2026-11-10T00:59:18.058Z
---
**문서 URL**
https://docs.google.com/document/d/1UGlRAW_ycZT_nqwPNpDdeBUoNoIIODbNTGE7ih5gd9Y/edit?tab=t.8o73ea5wmm9x

- Google Docs 포맷의 공유 주간보고
- 특정 탭(`tab=t.8o73ea5wmm9x`)으로 바로 이동하는 링크 (해당 탭이 최근 주차)

**사용자 담당 파트**
- **LIVING** (리빙 — 청정기·정수기·비데·음식물처리기 등 리빙가전 IoT)
- **BEREX** (비렉스 — 매트리스·모션베드·안마의자 등 슬립/힐링케어)

**How to apply**
- 사용자가 "주간보고", "이번 주 보고", "주보" 등을 언급하면 이 문서를 가리키는 것으로 판단
- 보고 내용 요청 시 LIVING + BEREX 섹션만 작성/업데이트 (다른 파트는 관여하지 않음)
- Google Drive MCP 재연결 전까지는 사용자가 직접 복사·붙여넣기해주시거나 수동 방식 필요

**쓰기 방법 (2026-11-10 확인)**
- 로컬 토큰(.gmail-mcp/gsheets-token.json, drive 범위) + Docs API REST로 직접 수정 가능 (11/10 사용자가 GCP 프로젝트에서 Docs API 활성화)
- 탭 구조: 상위 '제품 별 & 서비스화'(t.wz6zcm707fdo) 아래 Water(t.0)·Air·Living·Berex(t.8o73ea5wmm9x)·Health/Pet·New Product 등 → 말련향·태국향 정수기는 **Water(t.0)** 탭 큰 표 행
- 갱신 내용 표시 = 텍스트 배경 연한 노란색3(#FFF2CC), 글꼴 Roboto Mono 10pt·글자색 #222222
- **일정(표) 변경 시 기존 값 삭제 금지**: `기존값(취소선, 배경 없음) → 신규값(배경색)` 형식, 배경색은 신규값에만 (사용자 지시 11/10)
- **일정이 바뀌면 제품 일정 표 바로 밑에 `※ 일정 변동 사유` 문단 추가** (글머리 없음, 왼쪽 들여쓰기 14.17pt)
- **항목마다 관련 문서 링크**: 끝에 ` (link)`를 붙이고 'link' 글자에 하이퍼링크(파란색 #1155CC, 밑줄)를 건다. 대상은 Jira·구글시트·위키·Figma. 프로젝트 제목 칸에는 WIKI 링크
- 목록 단계 주의: API로 기존 맞춤 목록(➢●○╺)에 새 하위 단계를 붙일 수 없다(별도 목록이 생김). 같은 단계로 끼워 넣는 것만 기존 목록에 합쳐짐

**연관 제품(기획 메모리 참조)**
- LIVING: IoCare+ 청정기 v1.21, 정수기, 비데(점유인증·BLE), 음식물처리기 v1.11 등
- BEREX: 스마트 매트리스·시그니처 파이어쉴드 슬립싱크, 스트레칭 모션베드, 매트리스 리포트 v1.11 등
