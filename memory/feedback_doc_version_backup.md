---
name: feedback-doc-version-backup
description: 기획 정의서(모델별 기본정보·알림·소모품·루틴 등) 수정 시 반드시 백업 복제→파일명 버전/일자 갱신→문서이력 기재
metadata:
  node_type: memory
  type: feedback
  originSessionId: cb11de44-1278-4cb9-a6b6-70978d4c1804
  modified: 2026-11-09T23:49:18.809Z
---

모델별 기본정보·알림·자동화(루틴)·소모품·스마트진단 정의서를 수정할 때는 항상:
1. 현재 최신 문서를 복제해 구글 드라이브 백업 폴더로 이동 (사본명 '…의 사본')
2. 본 문서 파일명의 버전·일자 갱신 (예: v1.44_261109 → v1.45_261110)
3. '문서이력' 시트에 번호·버전·일자·변경 내용·작성자(IoT기획팀 문효준) 추가

백업 폴더(2026-11-10 확인): 모델별 기본정보 1a5pVZKyDl-sQiwvsWuBmAF4Sv2zeHpo_ / 알림·소모품 1biNGeQdtdsaHpLgqQiDLiK3HJzg9pWMQ / 스마트진단 1ud05Bfi32b4JW6W0ieQRMUMowNMaL9OZ (원본과 같은 폴더)

**Why:** 사용자가 2026-11-10 "잊지 말아야 한다"고 명시한 팀 문서 관리 규칙.
**How to apply:** 파일 복제·이동에는 Drive 쓰기 권한(drive 범위)이 필요. gsheets-token.json이 drive.readonly면 재인증부터.
