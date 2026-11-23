---
name: project_malaysia_rnr_doc
description: "IoT_업무 진행 안내(구 말련향 주관부서표) — Drive 구글 문서가 원본, 수정 방법, 일정은 Jira 2810 하위작업 기한 기준 (2026-11-23)"
metadata:
  node_type: memory
  type: project
  originSessionId: a9d80678-dbe0-4cf6-80dc-48502a752694
  modified: 2026-11-23T01:08:51.490Z
---

**본사 IoT 업무 주관부서·담당자** (Drive 파일명, 11/23 "IoT_업무 진행 안내"→본문 제목으로 재변경. 구 IoT_업무별_주관부서표, 말련향 아이콘 프로 v2·엘리트 빌트인, 말련법인 회신용). 2026-11-23부터 **Drive 파일이 원본**, 수정은 여기서 진행 (로컬 v12가 마지막 로컬 버전).
- **원본 = 네이티브 Google 문서** `19DqANPlXQ7TUiqJg0ncyDJmJ5iQvqSZG7Y3uLo99S6M` (2026-11-23 docx에서 변환, 표 3개·병합·색·취소선·A4 가로 유지 확인)
- 수정 방법: Docs API batchUpdate (gsheets-token.json drive scope로 동작), 수정 전 문서 다시 읽어 인덱스 확인. 문서 내 변경 이력 줄은 계속 추가
- 변환 전 docx(`1gTMIQ…`)는 'IoT_업무 진행 안내_변환전(docx).docx'로 이름 바꿔 같은 폴더에 보관
- 로컬: Downloads\IoT_업무별_주관부서표_vN.docx, 백업 Documents\backup\
- Drive 원본 폴더(2026-11-23 신설): IoT서비스 / 01. IoT 기획 / 99. 내부용 / 30.진행중 / 상품_말련향 정수기 (아이콘 프로 v2·엘리트 빌트인) — 폴더 ID `1mFk-YwQsUgk3M70CHeMdXJjS8STDqeb7`
- 확정 공유본은 Water상품기획2팀 이경희님 '말련/대만/태국 아이콘프로(v2)_협업폴더'(18Nx8eE85VkZTV8-JzhLw8eowSzn4IG_r)에 올릴 예정, 이경희님 확인 후
- 문서의 "화면기획" = IoCare+ 화면기획(제품 UI 화면기획 아님, 사용자 확인 11/23)
- MCMC 등 말련 인증: 착수서 12)인증 담당부서=말련법인, CFT시트는 전기안전인증팀 오승훈(전기안전/전자파). 인증용 앱 제공 여부 미확정(11/23)
- 우리 팀 담당 표기: 팀장 제외, 문효준(정) / 최린아(부)
- 화면기획 단계 기한은 Jira 2810 하위작업 기한 기준 (기능정의서 ≠ 화면기획서 배포, 2916 화면기획 27/1/15)
- 아이콘 프로 상품화착수서 '7)개발일정'(1DPL_m7r…, gid 1585772649)에 '화면기획서 배포 11/30'이 있으나, 사용자 판단으로 **최신 일정 아님** → 이걸로 문서 수정하지 말 것 (2026-11-23). 최신 일정 출처는 미확정
- 인증용 앱: 아이콘 프로 v2는 "제공 없을 가능성, 법인 확인 예정"(킥오프 10/15), 엘리트 빌트인은 논의 기록 없음 (2026-11-23 기준)

**Why:** 사용자가 Drive에서 버전 원본 관리하기로 결정(2안). 기능정의서 기한을 화면기획서 배포로 뭉뚱그렸다가 지적받음.
**How to apply:** 새 버전 만들면 Drive 폴더에도 업로드 제안. 일정 표기 시 산출물별 Jira 기한을 구분. 관련 [[project_malaysia_wp_jira]] [[feedback_doc_version_backup]]
