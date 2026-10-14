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

## 2026-10-12 갱신: 공유 DB 방식으로 전환
- 화면 https://claude.ai/artifact/3KiDAHTUN4KELhGbWQwtia 의 db 컬렉션 `usage`(문서 `<pc>__YYYY-MM-DD`), `account`(`acct__<pc>__날짜`)
- 절차는 아티팩트 파일 `tools/README.md`. 이 PC 이름은 **windows**, 작업폴더 `~/Downloads/claude-daily-summary/` (summaries.json에 세션 요약)
- "데일리써머리 업데이트" = export --machine windows → ArtifactData batch set (기존 문서는 if_version)
- 이 PC엔 `~/.claude/usage-snapshots.jsonl` 없음 → account 업로드 없음 (statusline은 rate-limits-cache.json만 저장)
- 메일 설정: ~/.config/claude-daily/gmail.json (daily_summary.py 자격 재사용, 2026-10-12). 전체 메일: DB usage+account를 out_dir로 받고 send all --from <dir>
- 17:10 자동 합산 메일 (2026-10-12): 작업 스케줄러 `ClaudeAllPCsSummary` → scripts/daily_all_pcs.ps1 → Downloads/claude-daily-summary/send_all_pcs.py (이 PC 새 export + `db_cache/` 사본 합산 → send 오늘)
- 헤드리스 `claude -p`에는 ArtifactData 없음(테스트 확인) → db_cache는 대화 세션에서 "데일리써머리 업데이트" 시 ArtifactData list(out_dir=db_cache)로 갱신해야 함
- 기존 `ClaudeDailySummary`(이 PC 전용 메일)도 17:10에 그대로 돌아감
- Mac 자동 반영 (2026-10-12): 통로 = Google Drive `G:/내 드라이브/claude-daily/{mac,mac-account,windows}`. Mac은 `mac_setup.sh`(같은 폴더) 1회 실행 → launchd 17:00 export+복사. send_all_pcs.py는 Drive·db_cache 중 generated 최신 파일 사용. Mac 설치 실행 여부 미확인

## 2026-10-14: 토큰 합계 기준 = 입력+출력+캐시 쓰기+캐시 읽기 전부 포함 (최종)
- 오전에 잠시 "캐시 읽기 제외(basis: no_cache_read)"로 바꿨다가, 사용자가 Mac에서 전부 포함으로 되돌림 → Windows도 동일 적용
- Windows claude_daily.py = 화면 tools/claude_daily.py(Mac 버전)와 동일. load_docs의 normalize()가 no_cache_read 문서를 전부 포함 기준으로 환산
- Windows usage 10/14까지 DB 재업로드 완료. 화면도 Mac이 이미 원래 기준으로 재게시함
