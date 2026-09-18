---
name: Python 3.12 로컬 설치 완료
description: 로컬 개발 환경에 Python 3.12.10 설치 완료. xlsx 조작·데이터 분석·API 스크립트에 활용 가능
type: project
originSessionId: d4b50e34-02ca-49a2-8058-75c63198f23f
---
## 설치 정보 (2026-09-17)

- **Python**: 3.12.10 (winget Python.Python.3.12, user scope)
- **경로**: `C:\Users\20020911\AppData\Local\Programs\Python\Python312\python.exe`
- **PATH 등록**: User PATH 최상단 (Windows Store stub보다 우선)
- **Bash에서 사용 시**: 새 세션에서는 자동 인식되지 않을 수 있음. 필요 시 앞에 다음 export 추가:
  ```bash
  export PATH="/c/Users/20020911/AppData/Local/Programs/Python/Python312:/c/Users/20020911/AppData/Local/Programs/Python/Python312/Scripts:$PATH"
  ```

## 설치된 패키지

| 패키지 | 버전 | 용도 |
|--------|------|------|
| openpyxl | 3.1.5 | xlsx 읽기/쓰기 (스타일·병합·수식 지원) |
| pandas | 3.0.5 | 데이터 프레임·CSV·xlsx 분석 |
| requests | 2.34.2 | HTTP API 호출 (Jira·wiki·Figma REST) |
| Pillow (PIL) | 12.3.0 | 이미지 처리·리사이즈·포맷 변환 |
| xlsxwriter | 3.2.9 | 고급 xlsx 생성 (차트 삽입 등 openpyxl보다 강력) |
| numpy | 2.5.3 | 수치 계산 |

**Why:** PowerShell Excel COM은 배열 자동 언랩, `=` 시작 문자열 수식 오해석, 인코딩 이슈(CP949) 등 함정이 많아 xlsx 조작 시 openpyxl/xlsxwriter가 훨씬 안정적. Jira/Confluence REST 호출도 curl·PowerShell보다 requests가 깔끔.

**How to apply:**
- xlsx 생성/편집 작업은 Python + openpyxl 또는 xlsxwriter 우선 사용
- 기존 PowerShell Excel COM 스크립트는 유지되지만 새 작업은 Python으로
- 추가 패키지 필요 시 `python -m pip install --user <pkg>`
- 사내 API 호출(jira.coway.com, wiki.coway.com)도 Python requests로 교체 가능

## 참고
- winget CLI 사용 가능 (v1.29.290)
- pip: 25.0.1 → 26.2.1 업그레이드 알림 있음 (필요 시 업그레이드)
- `--user` 설치 스크립트는 `%APPDATA%\Python\Python312\Scripts`에 배치 (PATH 추가 완료)
