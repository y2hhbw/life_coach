<#
.SYNOPSIS
Life Coach System Installation Script
#>

Write-Host "================================================"
Write-Host "    Life Coach System Installation Script       "
Write-Host "    Life Coach 系统安装脚本                     "
Write-Host "================================================"
Write-Host ""
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Copy-MissingTree {
    param(
        [Parameter(Mandatory = $true)][string]$SourceRoot,
        [Parameter(Mandatory = $true)][string]$DestinationRoot
    )

    Get-ChildItem -Path $SourceRoot -Recurse -File | ForEach-Object {
        $relativePath = $_.FullName.Substring($SourceRoot.Length).TrimStart('\', '/')
        $destFile = Join-Path -Path $DestinationRoot -ChildPath $relativePath
        $destDir = Split-Path -Path $destFile -Parent

        if (-not (Test-Path -Path $destDir)) {
            New-Item -ItemType Directory -Force -Path $destDir | Out-Null
        }

        if (-not (Test-Path -Path $destFile -PathType Leaf)) {
            Copy-Item -Path $_.FullName -Destination $destFile -Force
        }
    }
}

function Copy-IfMissing {
    param(
        [Parameter(Mandatory = $true)][string]$SourceFile,
        [Parameter(Mandatory = $true)][string]$DestinationFile
    )

    $destDir = Split-Path -Path $DestinationFile -Parent
    if (-not (Test-Path -Path $destDir)) {
        New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    }

    if (-not (Test-Path -Path $DestinationFile -PathType Leaf)) {
        Copy-Item -Path $SourceFile -Destination $DestinationFile -Force
    }
}

# Language Selection
Write-Host "Please select your language / 请选择你的语言:"
Write-Host "1) 中文 (Chinese)"
Write-Host "2) English"
$LangChoice = Read-Host "Enter choice / 输入选项 (1 or 2)"

if ($LangChoice -ne "1" -and $LangChoice -ne "2") {
    Write-Host "Invalid choice. Defaulting to English. / 选择无效，默认使用英文。"
    $LangChoice = "2"
}

if ($LangChoice -eq "1") {
    $SkillFile = Join-Path -Path $ScriptDir -ChildPath "SKILL.md"
    $PromptMsg = "请输入你的 Obsidian 库的绝对路径。`n(例如: C:\Users\yourname\Documents\Obsidian)"
    $ErrorMsg = "错误：目录不存在！"
    $InstallMsg = "正在安装 Life Coach 到"
    $CopyMsg = "正在复制模板并创建日志结构（不会覆盖已有文件）..."
    $ConfigMsg = "正在配置 Claude Code Skill..."
    $DoneMsg = "安装完成！🎉`n请确保正在运行 Claude Code，并使用 '/life-coach morning' 开始。"
} else {
    $SkillFile = Join-Path -Path $ScriptDir -ChildPath "SKILL_en.md"
    $PromptMsg = "Please enter the absolute path to your Obsidian Vault.`n(e.g., C:\Users\yourname\Documents\Obsidian)"
    $ErrorMsg = "Error: The directory does not exist!"
    $InstallMsg = "Installing Life Coach to"
    $CopyMsg = "Copying templates and creating journal structure (without overwriting existing files)..."
    $ConfigMsg = "Configuring Claude Code Skill..."
    $DoneMsg = "Installation complete! 🎉`nPlease ensure Claude Code is running and use '/life-coach morning' to start."
}

Write-Host ""
Write-Host $PromptMsg
$VaultPath = Read-Host ">"

# Validate path
if (-not (Test-Path -Path $VaultPath -PathType Container)) {
    Write-Host "$ErrorMsg ($VaultPath)" -ForegroundColor Red
    Exit
}

Write-Host "$InstallMsg '$VaultPath'..." -ForegroundColor Cyan
Write-Host ""

# Determine language directory
if ($LangChoice -eq "1") {
    $LangDir = "zh"
} else {
    $LangDir = "en"
}

# Copy folders
Write-Host $CopyMsg
$DestTemplates = Join-Path -Path $VaultPath -ChildPath "templates"
$DestJournal = Join-Path -Path $VaultPath -ChildPath "journal"

if (-not (Test-Path -Path $DestTemplates)) { New-Item -ItemType Directory -Force -Path $DestTemplates | Out-Null }
if (-not (Test-Path -Path $DestJournal)) { New-Item -ItemType Directory -Force -Path $DestJournal | Out-Null }

$SourceTemplates = Join-Path -Path $ScriptDir -ChildPath "templates\$LangDir"
$SourceJournal = Join-Path -Path $ScriptDir -ChildPath "journal\$LangDir"
Copy-MissingTree -SourceRoot $SourceTemplates -DestinationRoot $DestTemplates

# Create clean journal structure (no sample history data)
$VisionDir = Join-Path -Path $VaultPath -ChildPath "journal\vision_2028"
$DailyDir = Join-Path -Path $VaultPath -ChildPath "journal\daily"
$WeeklyDir = Join-Path -Path $VaultPath -ChildPath "journal\weekly"
if (-not (Test-Path -Path $VisionDir)) { New-Item -ItemType Directory -Force -Path $VisionDir | Out-Null }
if (-not (Test-Path -Path $DailyDir)) { New-Item -ItemType Directory -Force -Path $DailyDir | Out-Null }
if (-not (Test-Path -Path $WeeklyDir)) { New-Item -ItemType Directory -Force -Path $WeeklyDir | Out-Null }

# Install core strategy files only if missing
Copy-IfMissing -SourceFile (Join-Path -Path $SourceJournal -ChildPath "vision_2028\plan.md") -DestinationFile (Join-Path -Path $VisionDir -ChildPath "plan.md")
Copy-IfMissing -SourceFile (Join-Path -Path $SourceJournal -ChildPath "vision_2028\anti-vision.md") -DestinationFile (Join-Path -Path $VisionDir -ChildPath "anti-vision.md")

# Install goal template only if missing
$GoalDest = Join-Path -Path $VaultPath -ChildPath "journal\vision_2028\2026\goal.md"
$GoalTemplate = Join-Path -Path $SourceTemplates -ChildPath "goal_template.md"
$GoalDestDir = Split-Path -Path $GoalDest -Parent
if (-not (Test-Path -Path $GoalDestDir)) {
    New-Item -ItemType Directory -Force -Path $GoalDestDir | Out-Null
}
if (-not (Test-Path -Path $GoalDest -PathType Leaf)) {
    Copy-Item -Path $GoalTemplate -Destination $GoalDest -Force
}

# Install NAV template only if missing
$NavDest = Join-Path -Path $VaultPath -ChildPath "journal\nav_tracker.md"
$NavTemplate = Join-Path -Path $SourceTemplates -ChildPath "nav_template.md"
if (-not (Test-Path -Path $NavDest -PathType Leaf)) {
    Copy-Item -Path $NavTemplate -Destination $NavDest -Force
}

# Tool Selection
Write-Host ""
Write-Host "Please select your AI Assistant / 请选择你的 AI 助手:"
Write-Host "1) Claude Code"
Write-Host "2) Codex"
Write-Host "3) Qwen"
Write-Host "4) Opencode"
$ToolChoice = Read-Host "Enter choice / 输入选项 (1-4)"

switch ($ToolChoice) {
    "1" { $SkillsDir = Join-Path -Path $HOME -ChildPath ".claude\skills"; $ToolName = "Claude Code" }
    "2" { $SkillsDir = Join-Path -Path $HOME -ChildPath ".codex\skills";  $ToolName = "Codex" }
    "3" { $SkillsDir = Join-Path -Path $HOME -ChildPath ".qwen\skills";   $ToolName = "Qwen" }
    "4" { $SkillsDir = Join-Path -Path $HOME -ChildPath ".opencode\skills"; $ToolName = "Opencode" }
    default { 
        Write-Host "Invalid choice. Defaulting to Claude Code. / 选择无效，默认使用 Claude Code。" -ForegroundColor Yellow
        $SkillsDir = Join-Path -Path $HOME -ChildPath ".claude\skills"
        $ToolName = "Claude Code"
    }
}

if ($LangChoice -eq "1") {
    $ConfigMsg = "正在配置 $ToolName Skill..."
    $DoneMsg = "安装完成！🎉`n请确保正在运行 $ToolName，并使用 '/life-coach morning' 开始。"
} else {
    $ConfigMsg = "Configuring $ToolName Skill..."
    $DoneMsg = "Installation complete! 🎉`nPlease ensure $ToolName is running and use '/life-coach morning' to start."
}

# Configure Skill
Write-Host $ConfigMsg
$DestSkillDir = Join-Path -Path $SkillsDir -ChildPath "life-coach"
if (-not (Test-Path -Path $DestSkillDir)) {
    New-Item -ItemType Directory -Force -Path $DestSkillDir | Out-Null
}

$DestSkillFile = Join-Path -Path $DestSkillDir -ChildPath "SKILL.md"

# Read content, replace VAULT_ROOT, and write to destination
$Content = Get-Content -Path $SkillFile -Raw
# Using regex to match the exact VAULT_ROOT assignment line
$UpdatedContent = $Content -replace '(?m)^VAULT_ROOT\s*=\s*.*$', ("VAULT_ROOT = " + $VaultPath)

Set-Content -Path $DestSkillFile -Value $UpdatedContent -Encoding UTF8

Write-Host ""
Write-Host $DoneMsg -ForegroundColor Green
Write-Host ""
