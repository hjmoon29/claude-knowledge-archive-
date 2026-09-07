# Claude Knowledge Archive - Daily Sync Script
# Task Scheduler: ClaudeKnowledgeArchive (매일 09:30)
# Ver: 1.0 (2026-09-07)

$ErrorActionPreference = "Stop"
$ArchivePath = "G:\내 드라이브\claude-archive"
$MemorySrc = "$env:USERPROFILE\.claude\projects\C--Users-20020911\memory"
$LogFile = Join-Path $ArchivePath "logs\sync-$(Get-Date -Format 'yyyy-MM').log"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function Log { param($msg) "$Timestamp  $msg" | Tee-Object -FilePath $LogFile -Append }

Log "=== Sync 시작 ==="

# 1. sanitize + 복사
$patterns = @(
    @{ Regex = 'figd_[A-Za-z0-9_]{20,}';       Repl = 'figd_***REDACTED***' },
    @{ Regex = 'ATATT3xFf[A-Za-z0-9=/_-]{20,}'; Repl = 'ATATT***REDACTED***' },
    @{ Regex = 'NzY2NTg2N[A-Za-z0-9=/+]{15,}'; Repl = 'PAT_***REDACTED***' }
)

$copied = 0
Get-ChildItem "$MemorySrc\*.md" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    foreach ($p in $patterns) { $content = $content -replace $p.Regex, $p.Repl }
    $dst = Join-Path $ArchivePath "memory\$($_.Name)"
    Set-Content -Path $dst -Value $content -Encoding UTF8 -NoNewline
    $copied++
}
Log "메모리 파일 복사: $copied개"

# 2. Git commit + push (변경 있을 때만)
Set-Location $ArchivePath
$status = git status --porcelain 2>&1
if ($status) {
    git add . 2>&1 | Out-Null
    $msg = "auto: sync $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git commit -m $msg 2>&1 | Out-Null
    Log "Git commit: $msg"
    # push (remote 설정 있을 때만)
    $remote = git remote 2>&1
    if ($remote -match "origin") {
        try {
            git push origin main 2>&1 | Out-Null
            Log "Git push 성공"
        } catch {
            Log "Git push 실패: $_"
        }
    } else {
        Log "Git remote 미설정 (로컬 커밋만)"
    }
} else {
    Log "변경사항 없음"
}

Log "=== Sync 완료 ==="
