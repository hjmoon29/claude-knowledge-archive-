---
name: Figma 파일 쓰기 능력 (중요: Plugin만 가능)
description: Figma 파일에 프레임/텍스트/섹션 등 디자인 노드를 생성·수정하는 방법은 Figma Plugin API 뿐. REST API와 설치된 MCP는 모두 읽기 전용
type: reference
originSessionId: c3c5e961-995d-4876-8e5c-a0ae39d97d47
---
# Figma 파일 쓰기 — 가능/불가능 명확한 구분

## 불가능 (아무리 요청해도 안 됨)

- **Figma REST API**: 디자인 노드(FRAME/TEXT/SECTION/GROUP 등) 생성·수정 엔드포인트 **없음**
  - 사용 중인 토큰 `figd_...` 로 가능한 쓰기: POST comments / POST variables / POST dev_resources 세 가지 뿐
- **figma-developer-mcp** (mcp.json에 설치됨, Framelink): `get_figma_data`, `download_figma_images` 두 개만 — **읽기 전용**
- **공식 Figma Dev Mode MCP** (mcp.figma.com, OAuth): `get_code`, `get_variable_defs`, `get_image` 등 — **읽기 전용**

## 가능한 유일한 경로: Figma Plugin

- Figma Plugin API는 JavaScript로 Figma 파일 내 모든 노드 생성/수정 가능
- 사용자가 Figma 데스크톱 앱에서 수동으로 Import & 실행 필요 (웹 브라우저에서는 로컬 플러그인 import 불가)
- 플러그인 구성: `manifest.json` + `code.js`
- Import 경로: Figma 데스크톱 > 상단 Plugins > Development > Import plugin from manifest

## 작업 패턴 (이 사용자 요청 시 표준)

1. 사용자가 "Figma에 작성/추가/반영" 요청 시
2. Figma REST API로 쓰기 불가함을 명확히 설명
3. 두 산출물 함께 제공:
   - 상세 기획서(.md) — 로컬 참조용, 기획팀 수기 반영 가능
   - Figma Plugin 폴더 — manifest.json + code.js + README.md로 자동화
4. Plugin 저장 위치: `C:\Users\20020911\Documents\figma-plugin-<프로젝트명>\`

## 사례

- 2026-10-06: 매트리스 v1.12 제품제어 통합기획안
  - 로컬 기획서: `C:\Users\20020911\Documents\매트리스_v1.12_제품제어_통합기획안(기존+플러스).md`
  - Figma Plugin: `C:\Users\20020911\Documents\figma-plugin-mattress-v1.12\`
  - 대상: '작업안(기획팀)' 페이지(20244:2), 섹션 12개 좌/우 비교 구조

## 체크 포인트

- 과거 "Figma에 직접 작성했었다"는 사용자 기억은 대부분 (a) 로컬 기획서 전달 + 기획팀 수기 반영, (b) 플러그인 실행이었을 가능성이 높음
- 혹시 socket-based MCP (cursor-talk-to-figma, mcp-figma-devdotttool 류) 설치 요청이 올 수 있음 — 이 경우 Figma 데스크톱 내 companion 플러그인 설치 + 로컬 Node.js 소켓 서버 필요
