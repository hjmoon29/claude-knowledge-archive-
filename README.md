# Claude Knowledge Archive

문효준(hjmoon@coway.com) IoT기획팀 — Claude Code 세션에서 축적한 지식을 영구 보관하는 아카이브.

## 구조
```
claude-archive/
├── memory/            # Claude 자동 메모리 (sanitize된 사본, 매일 동기화)
├── jira-answers/      # JIRA 티켓 답변, QA 작업물
├── figma-scans/       # Figma 학습 결과 스냅샷 (일자별)
├── scripts/           # 자동화 스크립트
├── logs/              # 동기화 로그 (gitignore)
└── CREDENTIALS_LOCATIONS.md  # 크리덴셜 위치 참조 (값 없음)
```

## 백업 3중 구조
1. **로컬 Git repo** (이 폴더 자체, `.git/`) — 시간별 스냅샷·grep 가능
2. **Google Drive Desktop** (`G:\내 드라이브\claude-archive\`) — 자동 클라우드 동기화
3. **GitHub Private Repo** — 원격 백업, 다른 기기 접근

## 자동 동기화
- **매일 09:30**: `scripts/archive-knowledge.ps1` 실행 (Task Scheduler: `ClaudeKnowledgeArchive`)
- Claude 메모리 → sanitize → memory/ 복사 → git commit → git push

## 크리덴셜 원칙
- 토큰 평문은 절대 이 폴더에 저장하지 않음
- 메모리 파일 sanitize 시 `figd_***REDACTED***` 등으로 마스킹
- 원본 토큰은 `~/.claude/projects/.../memory/` 로컬 파일에만 존재

## 복원 방법
Claude 메모리 유실 시:
```bash
# sanitize 사본을 로컬 memory 폴더로 복원
cp -r "G:/내 드라이브/claude-archive/memory/"*.md ~/.claude/projects/C--Users-20020911/memory/
# 토큰이 필요한 파일은 CREDENTIALS_LOCATIONS.md 참조하여 원본 값으로 교체
```
