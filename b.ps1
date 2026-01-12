# quick-git-commit.ps1
# 快速Git提交脚本（无交互）

# 检查是否有未提交的更改
$status = git status --porcelain
if (-not $status) {
    Write-Host "没有需要提交的更改" -ForegroundColor Yellow
    exit 0
}

# 获取当前时间（带时区）
$now = Get-Date
$timezone = [System.TimeZoneInfo]::Local
$offset = $timezone.BaseUtcOffset
$offsetString = if ($offset.Hours -ge 0) {
    "+{0:00}:{1:00}" -f $offset.Hours, $offset.Minutes
} else {
    "-{0:00}:{1:00}" -f [Math]::Abs($offset.Hours), $offset.Minutes
}

$timestamp = $now.ToString("yyyy-MM-dd HH:mm:ss.fff") + " (UTC$offsetString)"
$commitMessage = "Update: $timestamp"

# 执行Git操作
git add .
git commit -m $commitMessage
git push
Write-Host "已提交: $commitMessage" -ForegroundColor Green
