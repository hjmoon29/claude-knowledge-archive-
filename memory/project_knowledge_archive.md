---
name: Claude Knowledge Archive 3중 백업 시스템
description: 메모리·JIRA답변·Figma학습 결과를 로컬 Git + Google Drive + GitHub Private로 3중 백업 (2026-09-07 구축)
type: project
originSessionId: 4d7a40c2-476f-487f-b032-66b3f5c925db
---
## 위치
- **아카이브 루트**: `G:\내 드라이브\claude-archive\` (Google Drive Desktop 자동 동기화)
- **GitHub 원격**: https://github.com/hjmoon29/claude-knowledge-archive- (프라이빗, 리포명 끝 하이픈 주의)
- **로컬 Git**: 위 아카이브 폴더 안에 `.git/` 존재

## 폴더 구조
```
claude-archive/
├── memory/           # Claude 자동 메모리 sanitize 사본 (매일 자동 동기화)
├── jira-answers/     # QA/JIRA xlsx 미러 (Documents/*.xlsx에서 자동 수집)
├── figma-scans/      # Figma 학습 결과 (일자별 폴더)
├── scripts/          # archive-knowledge.ps1 (v1.3)
├── logs/             # sync-YYYY-MM.log (gitignore)
├── CREDENTIALS_LOCATIONS.md   # 토큰 위치 참조 (실제 값 없음)
└── README.md
```

## 자동화
- **Task Scheduler**: `ClaudeKnowledgeArchive` — 매일 **09:30** 실행
- **워크플로우**: 메모리 sanitize → JIRA/QA 미러 → 토큰 leak 스캔 → git commit → GitHub push
- **수동 실행**: `& "G:\내 드라이브\claude-archive\scripts\archive-knowledge.ps1"`

## 토큰 sanitize 규칙 (커밋 전 자동 마스킹)
- `figd_[A-Za-z0-9_]{20,}` → `figd_***REDACTED***`
- `ATATT3xFf[A-Za-z0-9=/_-]{20,}` → `ATATT***REDACTED***`
- `NzY2NTg2N[A-Za-z0-9=/+]{15,}` → `PAT_***REDACTED***`
- leak 감지 시 `exit 2`로 커밋 중단

## 사용자가 자주 하는 요청 패턴
- **검색**: "G:/내 드라이브/claude-archive/memory/ 에서 XXX 관련 내용 찾아줘"
- **회고**: "지난주 뭐 결정했었는지 git log로 확인해줘"
- **강제 sync**: "지금 수동으로 sync 스크립트 실행해줘"

## 노트북 교체 시 복원 순서
1. Git 설치 → `git clone https://github.com/hjmoon29/claude-knowledge-archive-.git`
2. 클론한 `memory/*.md` → `~/.claude/projects/C--Users-XXXXXXXX/memory/`로 복사 (사번 폴더명 자동생성)
3. 토큰 3종 재발급 (Figma, Atlassian, Confluence Data Center) → `***REDACTED***` 자리에 붙여넣기
4. Task Scheduler 재등록 (스크립트는 `scripts/archive-knowledge.ps1` 그대로 사용)

**How to apply:** 사용자가 과거 대화 내용을 요청할 때 이 아카이브 경로에서 grep. 메모리 저장 안 됐던 것도 여기 있을 수 있음. 토큰 관련 질문 시 CREDENTIALS_LOCATIONS.md 참조 (실제 값은 원본 memory 파일에만).
