---
name: project-pc-backup
description: "PC 문서 백업 진행 상황 — 압축 완료(E:\\Backup), 구글드라이브 업로드 남음 (2026-10-13)"
metadata:
  node_type: memory
  type: project
  originSessionId: 2df9759b-7f80-48c8-b47d-f0096a714bb4
  modified: 2026-10-13T08:18:18.039Z
---

2026-10-13 PC 문서 백업 작업 중 사용자 요청으로 중단했고, 다음 날 이어서 하기로 함.

- 기준: 수정일 2025-01-01 이후 파일만 압축. 폴더 기준으로 분류함 — 업무 = Desktop·Downloads·Documents\Projects·workfiles·projects / 그외 = Pictures·Music·Videos·Documents의 나머지 폴더
- 제외: 설치파일(exe·msi·apk·crdownload·iso·dmg·tmp), node_modules, Downloads\barcode.zip(4.3GB, 사용자 결정)
- 압축 완료: E:\Backup\업무_2025이후_20261013.zip (5,057개, 5.82GB), E:\Backup\그외_2025이후_20261013.zip (708개, 0.08GB), 오류 0건
- 남은 일: 두 zip을 G:\내 드라이브\PC백업\ 으로 복사 (드라이브 여유 공간 약 8.2GB)

**Why:** C: 여유 공간이 8.7GB뿐이라 E:에서 압축했고, 구글드라이브 용량 때문에 barcode.zip을 뺐음.
**How to apply:** 다음 세션에서 백업 이야기가 나오면 업로드 단계부터 다시 시작할 것. 스크립트는 세션 scratchpad에 두었던 것이라 남아 있지 않을 수 있음.
