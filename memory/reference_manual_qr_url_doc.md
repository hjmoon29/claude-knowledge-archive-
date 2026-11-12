---
name: reference-manual-qr-url-doc
description: "사용설명서 IoCare 앱 다운로드 QR·URL 관리 구글시트 = CW_IoCare_IoT서비스 소개페이지 URL정의서 (구 IoT고객앱 연결 가이드 URL정의서), 최신 v3.2_20261111"
metadata:
  node_type: memory
  type: reference
  originSessionId: 17a12527-f127-419b-8cba-3c2e9e863deb
  modified: 2026-11-11T05:29:16.570Z
---

제품 사용설명서(매뉴얼)·제품 내에 들어가는 IoCare 앱 다운로드 QR코드와 URL은 **'CW_IoCare_IoT서비스 소개페이지 URL정의서'** 구글시트에서 관리한다.
- 최신(2026-11-11 확인): Ver.3.2_20261111, ID `1ljbt1jQklNwqsuaHTi9WM6Ggd3bqQZwCLWtePMWowrU` (오가현님 수정)
- 탭: 문서이력 / URL 생성 정책 / **URL QR코드 리스트**(제품군·프로젝트명·모델명 직접 입력 → URL·QR 이미지 자동생성, 매뉴얼·제품 내 사용 Y/N) / URL QR코드 생성 및 활용 방법
- URL 형식: `https://iocare.coway.com/intro?model=<모델명>`
- 옛 이름 'CW_IoCare_IoT고객앱 연결 가이드 URL정의서'(~v1.9, 2025). 미신사 별도본: '미신사_IoT고객앱 연결 가이드 URL정의서' v1.61

- QR 이미지 폴더: 'CW_IoT_IoCare2.0 제품별 QR코드 이미지' `1QFbMQHJmiqkpcanC7vxg5evSzjVlfZe8`, 파일명 `{모델명}.jpg`, 200×200 JPEG·**바깥 1px 흰 여백**·ECC L (모듈 경계 = floor(1 + k×198/모듈수), 기존 파일과 파인더 픽셀 일치 검증됨; 여백 0으로 만들면 테두리가 달라 보임 — 11/11 지적받고 수정). JPEG는 PIL quality=75·dpi 96(기존과 양자화표 동일, ~15.6KB). **같은 파일 ID에 덮어쓰면 Drive 미리보기가 옛 이미지로 캐시돼 보임 → 수정 시 새 파일로 올리고 시트 링크 교체, 옛 파일은 휴지통.** 현재 MY 파일 ID 1099NlJzdPNnBzvPmFlCxTc8Kq6H70zh4. 시트 메뉴 'QR Code > Generate QR Codes'(Apps Script) 대신 python qrcode로 생성→OpenCV 디코딩 검증→Drive 업로드→F열 링크·J열 일시(serial, DATE_TIME 서식) 입력 가능 (2026-11-11 말련향 아이콘 프로 92행 처리)
- 2026-11-11 말련향 정수기 2종 92·93행 추가(엘리트 빌트인 모델명 TBD → D·E·F 빈칸), 문서이력 v3.2 행에 이어 기재

**How to apply:** 신규 제품(예: 좌욕 스파 비데) 매뉴얼 QR·URL 확인·추가 요청 시 이 시트의 'URL QR코드 리스트' 탭 참조. 버전 자주 바뀌니 Drive에서 이름으로 최신본 재검색.
