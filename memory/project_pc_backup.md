---
name: project-pc-backup
description: "PC 반납·노트북 교체 대비 백업 — 2024년 이후 파일 zip(E:\\Backup) → Drive 내 드라이브/PC백업 API 업로드, 이사 키트 11/04 재생성"
metadata:
  node_type: memory
  type: project
  originSessionId: 7429f583-cd55-4a62-a260-88f4fd7ccae1
  modified: 2026-11-04T08:06:39.762Z
---

2026-11-04 사용자: 이 PC 반납 후 새 노트북으로 교체 예정 → 데이터 백업 진행.

- 범위: 수정일 2024-01-01 이후, Desktop·Downloads·Documents·workfiles·projects(업무) / Pictures·Music·Videos(그외). 제외: exe·msi·apk·crdownload·iso·dmg·tmp, node_modules·.git·__pycache__
- 결과: `E:\Backup\업무_2024이후_20261104.zip`(8,344개, 8.19GB) · `그외_2024이후_20261104.zip`(561개, 0.05GB), 오류 0·testzip 통과. `Downloads\barcode.zip`(4.3GB)은 사용자 지시로 백업 제외
- 업로드: Drive `내 드라이브/PC백업` 으로 Python resumable 업로드(scratchpad drive_upload.py, 상태 `E:\Backup\_upload_state.json`, 업로드용 토큰 `~/.gmail-mcp/drive-upload-token.json` = drive.file 스코프, 기존 gsheets-token 과 별개)
- Claude 이사 키트: 11/04 16:54 재생성 `G:\내 드라이브\claude-migration\claude-backup-20261104-1654.zip`(102MB, ~/.config 포함). 반납 직전 변경 있으면 export-claude.ps1 재실행
- 10/13 구 백업(E:\Backup 2025이후 zip, .pia) 은 이번 백업에 포함됨 → 업로드 확인 후 삭제 가능(사용자 판단)

**✅ 2026-11-04 17:1x 업로드·검증 완료 (크기+MD5 일치):**
- 그외_2024이후_20261104.zip 52,223,621 B / 업무_2024이후_20261104.zip 8,789,222,013 B
- Drive 폴더: https://drive.google.com/drive/folders/1-AcWJTPXqrK2tqWok-R_aUUl42OTnoez (내 드라이브/PC백업)
- 이사 키트 claude-backup-20261104-1654.zip 107,187,735 B Drive 동기화 확인
- 사용자 요청으로 검증 후 PC 종료. 11/05 오전 사용자가 "잘 됐는지" 확인 요청 예정 → 위 결과 보고, 문제 없으면 PC 교체 진행(새 PC 복원은 restore-claude.ps1 + [[project_pc_migration_plan]] 체크리스트)

**주의 (내가 틀렸던 것):** G: 드라이브(Drive 앱)의 '여유 공간'은 Drive 용량이 아니라 C: 로컬 디스크 여유다. 실제 용량은 Drive API `about?fields=storageQuota` 로 확인 — 회사 Workspace 공용 풀이라 사실상 무제한. 이걸 잘못 안내해 사용자가 MOV 영상·Meet 녹화를 지우고 휴지통까지 비움.
**Why:** E: 는 PC 내장 디스크(반납 시 소실), C: 여유 3.4GB 라 Drive 앱 복사는 캐시로 실패 위험 → E:에서 API 직접 업로드.
**How to apply:** 백업 이야기 나오면 업로드 완료 여부(_upload_state.json)부터 확인. 새 PC 복원은 [[project_pc_migration_plan]] 체크리스트.
