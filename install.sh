#!/bin/bash

# Function to print messages based on language choice
print_msg() {
    local msg_en="$1"
    local msg_zh="$2"
    if [ -z "$LANG_CHOICE" ]; then
        echo -e "$msg_en / $msg_zh"
    elif [ "$LANG_CHOICE" = "1" ]; then
        echo -e "$msg_zh"
    else
        echo -e "$msg_en"
    fi
}

echo "================================================"
echo "    Life Coach System Installation Script       "
echo "    Life Coach 系统安装脚本                       "
echo "================================================"
echo ""

# Language Selection
echo "Please select your language / 请选择你的语言:"
echo "1) 中文 (Chinese)"
echo "2) English"
read -p "Enter choice / 输入选项 (1 or 2): " LANG_CHOICE

if [ "$LANG_CHOICE" != "1" ] && [ "$LANG_CHOICE" != "2" ]; then
    echo "Invalid choice. Defaulting to English. / 选择无效，默认使用英文。"
    LANG_CHOICE="2"
fi

if [ "$LANG_CHOICE" = "1" ]; then
    SKILL_FILE="SKILL.md"
else
    SKILL_FILE="SKILL_en.md"
fi

echo ""
print_msg "Please enter the absolute path to your Obsidian Vault." "请输入你的 Obsidian 库的绝对路径。"
print_msg "(e.g., /Users/yourname/Documents/Obsidian or /home/yourname/Documents/Obsidian)" "(例如: /Users/yourname/Documents/Obsidian 或 /home/yourname/Documents/Obsidian)"
read -p "> " VAULT_PATH

# Expand tilde if present
eval VAULT_PATH="$VAULT_PATH"

if [ ! -d "$VAULT_PATH" ]; then
    print_msg "Error: The directory '$VAULT_PATH' does not exist." "错误：目录 '$VAULT_PATH' 不存在。"
    exit 1
fi

print_msg "Installing Life Coach to '$VAULT_PATH'..." "正在将 Life Coach 安装到 '$VAULT_PATH'..."
echo ""

# Determine language directory
if [ "$LANG_CHOICE" = "1" ]; then
    LANG_DIR="zh"
else
    LANG_DIR="en"
fi

# Copy files
print_msg "Copying templates and journal folders..." "正在复制模板和日志文件夹..."
mkdir -p "$VAULT_PATH/templates"
mkdir -p "$VAULT_PATH/journal"
cp -r "templates/$LANG_DIR/"* "$VAULT_PATH/templates/"
cp -r "journal/$LANG_DIR/"* "$VAULT_PATH/journal/"

# Tool Selection
echo ""
print_msg "Please select your AI Assistant / 请选择你的 AI 助手:" "Please select your AI Assistant / 请选择你的 AI 助手:"
echo "1) Claude Code"
echo "2) Codex"
echo "3) Qwen"
echo "4) Opencode"
read -p "$(print_msg "Enter choice / 输入选项 (1-4): " "Enter choice / 输入选项 (1-4): ")" TOOL_CHOICE

case "$TOOL_CHOICE" in
    1) SKILLS_DIR="$HOME/.claude/skills"; TOOL_NAME="Claude Code" ;;
    2) SKILLS_DIR="$HOME/.codex/skills"; TOOL_NAME="Codex" ;;
    3) SKILLS_DIR="$HOME/.qwen/skills"; TOOL_NAME="Qwen" ;;
    4) SKILLS_DIR="$HOME/.opencode/skills"; TOOL_NAME="Opencode" ;;
    *) print_msg "Invalid choice. Defaulting to Claude Code. / 选择无效，默认使用 Claude Code。" "选择无效，默认使用 Claude Code。"; SKILLS_DIR="$HOME/.claude/skills"; TOOL_NAME="Claude Code" ;;
esac

# Configure Skill
mkdir -p "$SKILLS_DIR"

DEST_SKILL_FILE="$SKILLS_DIR/life-coach.md"

print_msg "Configuring $TOOL_NAME Skill..." "正在配置 $TOOL_NAME Skill..."

# Create a temporary file
TMP_FILE=$(mktemp)

# Replace the VAULT_ROOT line using awk globally
awk -v vault="$VAULT_PATH" '{
    if ($0 ~ /^VAULT_ROOT = /) {
        print "VAULT_ROOT = " vault
    } else {
        print $0
    }
}' "$SKILL_FILE" > "$TMP_FILE"

mv "$TMP_FILE" "$DEST_SKILL_FILE"

echo ""
print_msg "Installation complete! 🎉" "安装完成！🎉"
print_msg "Please ensure $TOOL_NAME is running and use '/life-coach morning' to start." "请确保正在运行 $TOOL_NAME，并使用 '/life-coach morning' 开始。"
echo ""
