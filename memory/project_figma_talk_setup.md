---
name: claude-talk-to-figma-mcp 세팅 완료 (Figma 직접 쓰기)
description: Figma 디자인 노드 쓰기 가능한 MCP 세팅 완료. Bun+WebSocket+Companion Plugin 조합
type: project
originSessionId: c3c5e961-995d-4876-8e5c-a0ae39d97d47
---
# claude-talk-to-figma-mcp 세팅 완료 (2026-10-06)

## 구성

- **MCP 서버**: `C:\nvm4w\nodejs\node_modules\claude-talk-to-figma-mcp\dist\talk_to_figma_mcp\server.js` (Node)
- **WebSocket 소켓**: `C:\nvm4w\nodejs\node_modules\claude-talk-to-figma-mcp\dist\socket.js` (Bun 필수)
- **Companion Plugin**: `C:\Users\20020911\Documents\claude-figma-plugin\src\claude_mcp_plugin\{manifest.json, code.js, ui.html}` (GitHub clone)
- **Bun 런타임**: `C:\Users\20020911\.bun\bin\bun.exe` (v1.4.2)
- **mcp.json 서버명**: `figmaWrite` (기존 읽기전용 `figma`와 공존)
- **중요**: MCP 등록 파일은 `~/.claude.json` 의 `mcpServers` 키 (`~/.claude/mcp.json`은 Claude Code가 안 읽음, 다른 도구용)

## 일상 사용 플로우

1. `C:\Users\20020911\Documents\claude-figma-plugin\start-socket.bat` 더블클릭 → 소켓 서버 (port 3055) 상주
2. Figma Desktop에서 Plugins > Development > Claude Talk to Figma Plugin 실행
3. 플러그인 UI의 녹색 박스에서 채널 ID 복사
4. Claude Code 세션에 "Connect to Figma, channel {id}" 입력
5. 이후 "…를 figma에 그려줘" 등 자연어 요청 → Claude가 직접 노드 생성

**Why**: Figma 공식 REST API와 다른 Figma MCP 모두 디자인 노드 쓰기 미지원. 이 조합이 유일한 자동화 쓰기 경로.

**How to apply**: 사용자가 "figma에 작성/추가/반영" 요청 시 바로 이 플로우 안내. 소켓이 안 떠있다면 start-socket.bat 먼저 실행 요청.

## 검증 명령

- 소켓 상태: `curl http://localhost:3055/status`
- MCP 로드 확인: Claude Code `/mcp` 명령 → `figmaWrite` 보여야 함
- 플러그인 소스 재받기: `git -C C:\Users\20020911\Documents\claude-figma-plugin pull`

## 작업안(기획팀) 페이지 작성 완료 (2026-10-06)

- 파일: `02_제품_06매트리스_v1.12` (cqHb1Abt601MqNEdscs5CY)
- 페이지: `작업안(기획팀)` (20244:2)
- 참조 기획서: `C:\Users\20020911\Documents\매트리스_v1.12_제품제어_통합기획안(기존+플러스).md`
- 마스터 컨테이너 노드: `20257:2` (VERTICAL auto-layout)
- 섹션 12개 좌(기존)/우(플러스) 비교 프레임 생성 완료:
  - S01 공통 참조맵 / S02 로딩 팝업 / S03 릴랙스 모드 / S04 스마트 집중케어
  - S05 스마트 자세 조절 / S06 플랫 타이머(신규) / S07 수면 코스(신규)
  - S08 릴랙스 음원 설정 / S09 소프트 알람 음원 설정(신규)
  - S10 소프트 알람 동작 중 / S11 조건별 제어 불가 / S12 제품제어 툴팁
- 디자인 사양: 각 섹션 1680w, 좌(기존 #F6F6F6)/우(플러스 #EEF5FF) 796w 2단, 통합메모 하단

## 추가 작업: 실제 UI 프레임 통합 배치 (2026-10-06)

사용자가 "비교 문서가 아니라 실제 두 모델 화면을 합쳐 하나의 화면 설계로 보여달라" 요청 → y=15000 아래 영역에 실제 Figma 프레임 복제·배치 완료:

- S1 (y=15120~): 매트리스홈 제품제어 메인 — 기존 17002:5469 + 플러스 메인 17002:14009 수평 복제 배치
- S2 (y=19470~, 11954h): 플러스 전용 추가 사양 전체 — 17002:16431 복제 (스마트 자세조절/플랫타이머/수면코스/음원설정/소프트알람 등 모두 포함)
- S3 (y=32084~): 기존 S7 스마트 자세 조절 — 17002:11348 복제
- S4 (y=36334~): 기존 조건별 제어 불가 10종 — 17002:14334 복제
- S5 (y=40584~): 기존·플러스 공통 소프트 알람 알람설정 — 17002:12121 복제
- S6 (y=44834~): 기존 소프트 알람 동작 중 — 17002:13284 복제
- S7 (y=46828~): 기존 릴랙스 음원 설정 — 17002:1683 복제
- S8 (y=50040~): 기존 제품제어 툴팁 11종 — 17002:274 복제

각 복제 프레임 옆에 통합 가이드 텍스트(x=2800~5500) 배치: 플러스 측 변경점·신규 요소·플러스 측 상세 영역 참조 표기.
작업안(기획팀) 페이지 최종 childCount: 27개 (비교 문서 + 통합 섹션 헤더/프레임/가이드).

## 사용 과정에서 발견한 플러그인 특성 (추가)

- **파일 전환 시 플러그인 소켓 자동 해제** — 작업 파일을 바꾸면 새 채널 ID 재발급 필요
- Pretendard 폰트 로드 실패 → **Inter 사용 가능** (한글은 Figma 자동 fallback)
- Plugin UI 창은 작업 중 닫지 말고 백그라운드 유지해야 소켓 세션 유지됨
- 소켓 끊김 발생 시 `curl http://localhost:3055/status` 로 `pluginCount` 확인
