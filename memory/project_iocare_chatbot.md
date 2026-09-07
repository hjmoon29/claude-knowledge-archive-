---
name: IoCare+ 지식베이스 챗봇 개발 진행 상황
description: Confluence/Jira/Figma 기반 RAG 챗봇 개발 현황 및 다음 단계 (2026-08-03)
type: project
originSessionId: 982cdc51-9d12-468d-a947-a665027619bb
---
## 프로젝트 개요
Confluence(CWIOTSVC) + Jira(IOCARERENEW2023) + Figma(67개 파일) 내용을 기반으로 질의응답하는 웹 챗봇

## 프로젝트 경로
`C:\Users\20020911\iocare-chatbot\`

## 완료된 작업
- 프로젝트 구조 생성 (Next.js 14 + Node.js)
- 데이터 수집 스크립트 완성 (confluence.js / jira.js / figma.js)
- 챗봇 백엔드 API (app/api/chat/route.js) — Claude sonnet-4-6 + RAG
- 챗봇 프론트엔드 UI (app/page.js) — 스트리밍 응답
- Supabase DB 세팅 완료 (vector(1024) 테이블 + match_documents 함수)
- 데이터 수집 완료: Confluence 951페이지(2138청크) + Jira 2355개 + Figma 62개
- **임베딩 저장 미완료** — Voyage AI rate limit 문제로 중단

## API 키 현황 (.env.local에 저장됨)
- Confluence Bearer 토큰 ✅
- Jira Bearer 토큰 ✅
- Figma Personal Access Token ✅
- Claude API 키 ✅
- Supabase URL + anon key ✅
- Voyage AI API 키 ✅ (결제 수단 미등록으로 3RPM 제한 중)

## 다음에 할 일
1. Voyage AI rate limit 해결 (둘 중 선택):
   - **옵션 A**: dashboard.voyageai.com에서 결제 수단 등록 (실제 과금 없음, rate limit만 해제)
   - **옵션 B**: Ollama로 전환 (완전 로컬 무료, 설치 필요)
2. 임베딩 저장 재실행: `node --env-file=.env.local collector/run.js all`
3. 로컬 테스트: `npm run dev`
4. Vercel 배포

**Why:** Voyage AI 무료 플랜은 결제 수단 등록 전 3RPM 제한 → 4493개 임베딩 처리 불가
**How to apply:** 2026-08-04 오전 8시 이후 대화 시작 시 이 메모리 확인 후 rate limit 해결부터 바로 시작
