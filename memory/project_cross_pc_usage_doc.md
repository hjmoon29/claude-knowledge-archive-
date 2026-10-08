---
name: Claude 멀티 PC 사용량 공유 저장소 Doc
description: Mac·Windows 등 여러 PC의 Claude Code 일일 사용량을 하나의 Claude Doc에 모아 교차 집계하는 시스템 (2026-10-08)
type: project
originSessionId: 8ce9232a-cdfb-4b01-be53-d8aee2ebf4cb
---
# 설계

여러 PC에서 같은 Claude 계정을 쓸 때 PC별로 분산된 사용량을 하나로 모아 보기 위한 공유 저장소.

## 핵심 자원
- **공유 저장소 Doc**: https://claude.ai/code/artifact/12cf0fc0-a090-4f98-84e3-90fa39cc8797 ("Claude 일일 사용량 공유 저장소")
- **집계 스크립트**: 각 PC의 `claude_daily.py` (Windows: `C:\Users\20020911\scripts\claude_daily.py`, Mac: `~/Downloads/claude-daily-summary/claude_daily.py`)
- **Doc 내부 섹션**: `저장소 (usage)` 테이블 / `tools/claude_daily.py` / `tools/README.md` / `운영 메모`

## 데이터 네이밍
`<pc>__<YYYY-MM-DD>` 형식 (예: `win__2026-10-08`, `mac__2026-10-08`). PC 라벨은 OS로 자동 추론 (`Darwin→mac`, `Windows→win`), `CLAUDE_PC_LABEL` env로 덮어쓰기 가능.

## 운영 흐름
1. 각 PC 23:58 KST — `claude_daily.py` 실행 → `last_run.log`에 JSON + 복붙용 markdown 1행 생성
2. 다음 Claude 세션에서 사용자가 "오늘 1행 공유 저장소에 추가" 요청 → Claude가 docs 툴로 Doc 저장소 테이블에 append
3. 완전 자동 push는 불가 (Claude Docs는 Claude 세션 안에서만 수정 가능, 외부 REST 없음)

## 제약·주의
- Claude Docs에 사용량 수치 쓸 때 permission hook이 "data exfiltration"으로 처음 블록함. 사용자가 승인해야 통과 (2026-10-08 승인 완료).
- 비용 수치는 Opus 요율 상한 기준이라 실제 Sonnet/Haiku 혼용 시 1/3~1/5 수준.

**Why**: 여러 PC를 번갈아 쓰며 일하는데 로컬 `daily_summary.py`는 그 PC 세션만 봐서 전체 사용량이 안 잡힘. 사내 공유 폴더(A안)·NAS가 Mac에서 접근 불편해 Claude Doc으로 선회.
**How to apply**: 사용자가 "다른 PC 사용량까지 포함" 요청하면 이 Doc 링크 공유 + 저장소 테이블에 PC별 행 append. 새 PC 추가 시 Doc 안 `tools/README.md` 가이드대로 세팅 요청.
