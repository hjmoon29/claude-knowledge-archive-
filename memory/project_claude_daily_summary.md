---
name: Claude 일일 요약 (daily_summary.py)
description: 매일 17:10 KST Gmail 발송되는 Claude 사용량/작업 리포트. 과거 기록 아카이브 지원 (2026-10-06)
type: project
originSessionId: 08e42ab2-9385-4159-8508-7732ca463e56
---
# Claude 일일 요약 스크립트

## 핵심 위치
- 메인 스크립트: `C:\Users\20020911\scripts\daily_summary.py`
- 백필 스크립트: `C:\Users\20020911\scripts\backfill_daily_archive.py`
- 로컬 웹 서버: `C:\Users\20020911\scripts\daily_summary_server.py` (포트 8787)
- 서버 실행 배치: `C:\Users\20020911\scripts\start_daily_server.bat`
- 아카이브 디렉토리: `C:\Users\20020911\scripts\daily_summaries\`
- 인덱스 (브라우저로 열람): `C:\Users\20020911\scripts\daily_summaries\index.html`
- 라이브 URL: http://localhost:8787/ (서버 가동 시, 새로고침마다 오늘 데이터 재집계)

## 발송 사양
- 매일 17:10 KST 자동 실행 → hjmoon@coway.com
- Gmail OAuth refresh token으로 자체 발송 (Gmail MCP 의존 X)
- 자격: `GMAIL_CLIENT_ID`/`SECRET`/`REFRESH_TOKEN` 하드코딩 (스크립트 내부)

## 리포트 섹션
1. 상단 요약 박스 (토큰·메시지·세션·비용·메모리 변경)
2. 모델별 토큰 테이블
3. 시간대별 메시지 수
4. **시간대별 작업 세션** — 사용자 프롬프트를 키워드 분류기(`_summarize_prompt`)로 요약 노출 (프롬프트 원문 노출 금지)
5. 토큰 TOP 10 작업
6. 당일 메모리 변경
7. 오전 자동화 결과 (Figma/Wiki 11:30 batch)
8. 미완료 작업 상태
9. 내일 할 일 제안

## 아카이브 (2026-10-06 신규)
- 매일 실행 시 자동으로 `daily_YYYY-MM-DD.html` + `daily_YYYY-MM-DD.json` 저장
- 저장 후 `index.html` 재빌드 (전체 일자 테이블 + 누적 통계)
- 이메일 상단에 "📚 전체 일일 요약 아카이브 보기" 링크 삽입
- 백필: `python backfill_daily_archive.py` → 세션 JSONL에서 활동 날짜 감지해 전부 재생성

## 계정 사용 한도 (2026-10-08 추가)
- 일일 리포트·인덱스 상단에 '⏱ 계정 사용 한도' 박스: 5h/주간 사용률 + 리셋시각 (`~/.claude/rate-limits-cache.json`, statusline.py가 저장)
- 일자별 JSON에 `rate_limits` 스냅샷 저장, 인덱스 테이블에 '5h / 주간 한도' 컬럼 (과거 날짜는 저장된 스냅샷만, 없으면 -)

## 수동 발송
```bash
cd /c/Users/20020911/scripts && python daily_summary.py
```

## 로컬 라이브 조회 서버 (2026-10-07 신규)
- `start_daily_server.bat` 더블클릭 또는 `python daily_summary_server.py` 실행
- 브라우저가 자동으로 http://localhost:8787/ 오픈
- F5 누를 때마다 오늘자 아카이브 재생성 + 인덱스 재빌드 (최소 간격 3초)
- 강제 재집계: `http://localhost:8787/?force=1`
- 자동 오픈 끄기: `set DAILY_SUMMARY_NO_BROWSER=1`

**Why**: 매일 작업한 내용·토큰 사용량·미완료 작업을 추적하고, 과거 기록도 한눈에 비교 가능하게.
**How to apply**: 사용자가 "데일리써머리 발송" 요청 시 수동 실행. "과거 기록 보고 싶다" 요청 시 `index.html` 열어 안내.
