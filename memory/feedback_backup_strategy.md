---
name: 지식 백업 전략 - 3중 백업 + 자동 sanitize 선호
description: 메모리·작업 산출물 영구 보관 시 로컬 Git + 클라우드 + GitHub 조합, 토큰 자동 마스킹 필수
type: feedback
originSessionId: 4d7a40c2-476f-487f-b032-66b3f5c925db
---
사용자는 Claude Code 메모리 유실을 우려하여 다중 백업 시스템을 요청함. **가장 실용적인 조합** = 로컬 Git repo + Google Drive Desktop 자동 동기화 + GitHub 프라이빗 리포.

**Why:** 메모리만 있으면 소실 위험. 사용자는 회사 업무 자산이므로 클라우드+로컬+원격 3중 안전망을 원함. Google Drive는 이미 IoT기획 폴더로 사용 중이라 자연스러운 확장.

**How to apply:**
- 지식·작업 산출물 영구 보관 요청 시 이 3중 조합 제안
- 토큰/크리덴셜은 **자동 sanitize** 필수 (평문 클라우드 업로드 절대 금지) — 권한 시스템이 실제로 이걸 막았고 사용자도 동의
- 자동화는 기존 `ClaudeMCPTokenCheck` 패턴처럼 Task Scheduler로 (매일 09:30)
- 원본 토큰은 로컬 memory 파일에만 두고, 아카이브에는 `CREDENTIALS_LOCATIONS.md`로 위치만 참조
- 스크립트 인코딩: PS 5.1 호환 위해 UTF-8 **BOM 포함**, `2>&1` 사용 금지 (NativeCommandError 방지)
