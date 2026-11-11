---
name: feedback-ims-caution
description: IMS(개발계 포함) API 대량 조회·추측성 호출 금지 — 2026-11-10 IMS 서버 에러 연락으로 사용자가 중단시킴
metadata:
  node_type: memory
  type: feedback
  originSessionId: cb11de44-1278-4cb9-a6b6-70978d4c1804
  modified: 2026-11-10T07:37:08.148Z
---

2026-11-10 좌욕스파 비데 확인 중 IMS 개발계에 조회를 여러 번 호출했다(기준정보 477건 전체, POP 코드 목록 반복, 화면 접속 재현). 그중 2건은 오류가 났다(GET /v1/device/popCode 403 Invalid grant, pageSize 없는 popCode/list 400). 이후 "IMS 서버에서 계속 에러코드가 뜬다"는 연락을 받고, 사용자가 IMS 작업을 전부 멈추게 했다. 37개 기능을 한꺼번에 도는 조회는 실행 전에 거부됐다.

**Why:** IMS는 다른 팀(IoT플랫폼개발팀)이 운영하는 공용 서버라, 우리 쪽 오류 호출과 대량 조회가 모니터링에 바로 보인다.
**How to apply:** 사용자가 다시 허락할 때까지 IMS는 건드리지 않는다. 다시 쓰게 되면 필요한 화면 1~2개만 정확한 형식으로 조회한다. 추측으로 API를 부르거나 전수 조회하지 않고, 몇 번 부를지 먼저 알린다. 관련: [[reference_iot_ims]]
