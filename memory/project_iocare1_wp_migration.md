---
name: project_iocare1_wp_migration
description: "2027 IoCare 1.0 정수기 → IoCare+ 이관 계획 초안 (미이관 대상 55 modelCode, 웨이브 구성, 근거 문서 ID)"
metadata:
  node_type: memory
  type: project
  originSessionId: cab49265-d53a-47df-b92d-ed41033adbf9
  modified: 2026-11-09T23:29:57.786Z
---

2026-11-10 사용자 요청으로 2027년 IoCare 1.0 정수기 이관 계획 초안을 작성함→ 위키 초안 페이지 405837425 게시 (부모 182287313).

- 대상 기준 문서: 위키 "IoCare v1 only 제품현황" 392072242 (2026-09-28, isUseV1=true·isUseV2=false) → 정수기 IOT 9건 + NFC 46건
  - 국내 IOT: CHP-482L(마이한뼘2017/엘리트, 02EPN), AIS 3.0 CHPI/CPI-7511L(02FCI/02FCJ, 26/9 출하등록 有), 프라임 아이스 맥스 CHPI-5810L(02FI2, 26/9 출하등록 有)
  - 해외 IOT: 아이콘2 TW(02FRT)·SG(02FSR/02FSS), 노블 빌트인 TW(02FWX)·SG(02FU2) — 국내는 이미 2.0 지원 하드웨어
  - NFC 46: 마이한뼘2016/2017, 스스로살균, 듀얼아이스, 아이스 스탠드
- 기 이관: 아이콘 시리즈 v25.10, 노블 시리즈 v25.11 (위키 전체 일정 111055323). 청정기 8종 v26.11 진행(김태현님), IMS 입력시트 Drive 폴더 1IfmoKVcncoGiLdCNlzySOqs92mTzNhRV
- 정례회의(196970470): "1.0 제품 이관 완료되는 대로 종료(3~6개월)", "IoCare 1.0 내년까지 유지"
- 제안 웨이브: W1 국내 IOT 3종(v27.4) → W2 해외 4종(v27.6) → W3 NFC 정책결정(27/3) 후 이관 or 종료(v27.10) → 1.0 정수기 종료(27/12)

**How to apply:** 이관 계획 후속 요청 시 이 근거로 이어가고, 등록대수·NFC 정책·해외 국가 오픈 여부는 미확정임을 유지. 관련: [[project_wiki_cwiotsvc_structure]], [[project_gdrive_iot_docs]]

## 2026-11-18 사용자 지시·추가 확인
- **NFC 모델은 후순위: 이관 대상에서 완전 제외는 아니나 당분간 검토 대상에서 제외**
- 기준 문서 URL: https://wiki.coway.com/pages/viewpage.action?pageId=392072242 (총 82건 = 정수기 IOT 9·NFC 46, 청정기 24, 비데 3)
- **비데 이관 대상 3건(KR)**: 02FDJ BAS37-A 더블케어 비데, 02FQQ BAS37-B 더블케어 비데, 02FEN BAS38-A 더블케어 플러스 비데 (업그레이드 BAS37-C/38-C·BAS37-D는 IoCare+ 지원)
- 청정기 24건도 기준 문서에 있음(NFC 1·PORTABLE 에어보틀 2·안테나 공기진단기 1 포함, 해외 다수). 진행 중인 청정기 8종과의 대응 미확인
- **사용자 담당 범위(11/18 확정): 정수기 IoT 9건 + 비데 3건 = 12건만.** 청정기는 사용자 담당 범위 아님, NFC는 후순위.
- 2026-11-18 위키 405837425 v3(문서 v0.3) 수정: 제목 「27년 IoCare 1.0 정수기·비데 이관 계획 (초안)」, 12건 기준 W1 국내정수기 v27.4 → W2 비데 v27.5 → W3 해외정수기 v27.6, NFC는 6장 별도. 이전 버전 백업 Documents/wiki_backup/405837425_v2_20261118.json
- 11/18 위키 v4(문서 v0.4): 리스크 '담당자 일정 중복'을 문효준 기준(좌욕스파 비데·말련 2종·태국 부담당)으로 수정, 아이콘 얼음 정수기 삭제. 백업 Documents/wiki_backup/405837425_v3_20261118.json
- 11/25 위키 v5(문서 v0.5): 비데 3종 Wi-Fi & BLE(Mercury) 확정 → **Wi-Fi&BLE 정책으로 이관**(BLE Only 개인형 비데 정책 X, 사용자 확정). 리퍼브 모델 제외(BAS37-B 리퍼브 02FX0). 1장·부록 출시일 추가(출처 모델별 기본정보 v3.21 '1.0_모델 기본 정보 및 정책' 탭, 노블 빌트인 TW 02FWX 출시일 미기재). '담당자 일정 중복' 리스크 삭제(다른 업무와 별개로 진행), NFC 재검토 시점 문구 삭제, 사전 준비(공통) 행 추가. 백업 Documents/wiki_backup/405837425_v4_20261125.json
