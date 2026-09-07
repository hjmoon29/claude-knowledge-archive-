# Claude Knowledge Archive - Daily Sync Script
# Task Scheduler: ClaudeKnowledgeArchive (daily 09:30)
# Ver: 1.2 (2026-09-07)

$ArchivePath = "G:\내 드라이브\claude-archive"
$MemorySrc = "$env:USERPROFILE\.claude\projects\C--Users-20020911\memory"
$LogFile = Join-Path $ArchivePath "logs\sync-$(Get-Date -Format 'yyyy-MM').log"

function Log {
    param($msg)
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "$ts  $msg"
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
    Write-Output $line
}

Log "=== Sync start ==="

# 1. Sanitize + copy
$patterns = @(
    @{ Regex = 'figd_[A-Za-z0-9_]{20,}';       Repl = 'figd_***REDACTED***' },
    @{ Regex = 'ATATT3xFf[A-Za-z0-9=/_-]{20,}'; Repl = 'ATATT***REDACTED***' },
    @{ Regex = 'NzY2NTg2N[A-Za-z0-9=/+]{15,}'; Repl = 'PAT_***REDACTED***' }
)

$copied = 0
Get-ChildItem "$MemorySrc\*.md" | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    foreach ($p in $patterns) { $c = $c -replace $p.Regex, $p.Repl }
    Set-Content -Path (Join-Path $ArchivePath "memory\$($_.Name)") -Value $c -Encoding UTF8 -NoNewline
    $copied++
}
Log "Memory files copied: $copied"

# 2. Safety scan for token leaks
$leak = Select-String -Path "$ArchivePath\memory\*.md" -Pattern "figd_[A-Za-z0-9_]{15,}", "ATATT3xFf[A-Za-z0-9]{15,}", "NzY2NTg2N[A-Za-z0-9]{10,}" -ErrorAction SilentlyContinue
if ($leak) {
    Log "TOKEN LEAK DETECTED - aborting commit"
    foreach ($m in $leak) { Log "  $($m.Path):$($m.LineNumber)" }
    exit 2
}

# 3. Git commit + push (stderr NOT redirected - avoids PS 5.1 NativeCommandError)
Set-Location $ArchivePath
$status = git status --porcelain
if ($status) {
    git add .
    $msg = "auto: sync $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    git commit -m $msg | Out-Null
    Log "Git commit: $msg"
    $remotes = git remote
    if ($remotes -match "origin") {
        git push origin main | Out-Null
        if ($LASTEXITCODE -eq 0) { Log "Git push success" } else { Log "Git push failed (exit $LASTEXITCODE)" }
    } else {
        Log "Git remote not set (local commit only)"
    }
} else {
    Log "No changes"
}

Log "=== Sync end ==="