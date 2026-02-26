<#
.SYNOPSIS
Life Coach System Installation Script
#>

Write-Host "================================================"
Write-Host "    Life Coach System Installation Script       "
Write-Host "    Life Coach 系统安装脚本                     "
Write-Host "================================================"
Write-Host ""

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
    $SkillFile = "SKILL.md"
    $PromptMsg = "请输入你的 Obsidian 库的绝对路径。`n(例如: C:\Users\yourname\Documents\Obsidian)"
    $ErrorMsg = "错误：目录不存在！"
    $InstallMsg = "正在安装 Life Coach 到"
    $CopyMsg = "正在复制模板和日志文件夹..."
    $ConfigMsg = "正在配置 Claude Code Skill..."
    $DoneMsg = "安装完成！🎉`n请确保正在运行 Claude Code，并使用 '/life-coach morning' 开始。"
} else {
    $SkillFile = "SKILL_en.md"
    $PromptMsg = "Please enter the absolute path to your Obsidian Vault.`n(e.g., C:\Users\yourname\Documents\Obsidian)"
    $ErrorMsg = "Error: The directory does not exist!"
    $InstallMsg = "Installing Life Coach to"
    $CopyMsg = "Copying templates and journal folders..."
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

Copy-Item -Path "templates\$LangDir\*" -Destination $DestTemplates -Recurse -Force
Copy-Item -Path "journal\$LangDir\*" -Destination $DestJournal -Recurse -Force

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
