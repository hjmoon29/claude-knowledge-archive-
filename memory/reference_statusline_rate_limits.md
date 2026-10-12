---
name: statusline-rate-limits
description: Claude Code statusline stdin에 공식 rate_limits(5h/7d 사용률·리셋 epoch) 포함 — 토큰 표시는 이 값 기준
metadata:
  type: reference
---

Claude Code가 statusline 스크립트 stdin JSON에 `rate_limits.five_hour/seven_day.{used_percentage, resets_at}`를 넘겨줌 (계정 전체·전 PC 합산, 2026-10-08 확인).
- `scripts/statusline.py`: 이 값 우선 사용, `~/.claude/rate-limits-cache.json`에 캐시 저장
- `scripts/session_token_usage.py`(SessionStart): 그 캐시를 읽어 5h/주간 표시 (없으면 로컬 jsonl 추정)
- 로컬 jsonl 추정은 다른 PC(Mac) 사용량이 빠져 크게 틀림 (주간 45% vs 실제 84%, 리셋 18:00 vs 실제 18:40)
- 사용자 선호: 오늘 누적 대신 5h(맨 앞·강조·리셋시각) + 주간 표시
