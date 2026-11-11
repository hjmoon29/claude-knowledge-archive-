---
name: reference-pop-code-base36
description: "POP코드 = 자재코드를 36진수(0-9,A-Z)로 변환해 5자리 0패딩한 값 — 문서 조회 없이 계산으로 구할 것"
metadata:
  node_type: memory
  type: reference
  originSessionId: 17a12527-f127-419b-8cba-3c2e9e863deb
  modified: 2026-11-11T00:42:57.109Z
---

POP코드는 자재코드(10진수)를 **36진수(0~9, A=10 … Z=35)로 변환하고 앞을 0으로 채운 5자리** 값이다.
- 검증 예: 113838→02FU6, 113853→02FUL, 113854→02FUM, 114346→02G8A (모델별 기본정보 v3.18과 일치)

**How to apply:** 사용자가 "자재코드를 POP코드로 변환" 요청 시 구글 문서 조회 말고 직접 진수 변환으로 계산 (2026-11-11 사용자 요청). 역변환(POP→자재코드)도 같은 규칙. 관련: [[feedback-ims-caution]]
