[English](README.md) | [中文](README_zh.md)

# Life Coach - AI-Powered Life Coaching System

A goal management and daily guidance system based on Claude Code Skill, helping you break down long-term vision into executable daily actions.

## 📖 System Logic

### Core Methodology

Life Coach combines **top-down goal decomposition** with **negative motivation**:

#### 1. Three-Tier Goal System

```
3-Year Vision (vision_2028/plan.md)
    ↓ breakdown
1-Year Plan (vision_2028/2026/goal.md)
    ↓ guides
Daily Actions (daily/*.md)
```

**How it works:**
- **3-Year Vision (plan.md)**: Define who you want to be in 2028 - career, finance, health, relationships
- **1-Year Plan (goal.md)**: Break down 3-year vision into specific annual goals with quarterly targets and daily habits
- **Daily Journal (daily/*.md)**: Record daily intentions, happenings, gratitude, action items, and feelings

**Skill's Role:**
- Reads your 3-year vision and 1-year plan every morning/evening
- Analyzes your journal content to check alignment with goals
- Provides targeted coaching through 8 diagnostic lenses

#### 2. Anti-Vision Mechanism

Beyond positive goal motivation, the system uses **anti-vision** for "pain-driven" motivation:

- **anti-vision.md** describes what your future becomes if you choose avoidance and inefficiency today
- When procrastination or avoidance is detected, the Skill references anti-vision content to remind you of the future you don't want
- This "negative motivation" has more impact than purely positive goals

> Inspired by: [How to fix your entire life in 1 day](https://x.com/thedankoe/status/2010751592346030461) by @thedankoe

#### 3. 8 Diagnostic Tools

The Skill has 8 built-in diagnostic lenses that automatically check during each interaction:

1. **Goal Alignment** - Check if daily tasks align with annual goals
2. **Identity Audit** - Check if behavior matches your vision identity
3. **Action Verification** - Check for actual output, not just busy work
4. **Nightmare Wake-up** - Use anti-vision to alert you when avoidance is detected
5. **NAV Check** - Compare asset changes with action investment
6. **Time Black Hole** - Detect if you're doing "fake work"
7. **Weekly Review** - Generate weekly report with strategic advice
8. **Data Speaks** - Verify effectiveness with objective data

---

## 🚀 How to Use

### Prerequisites

- [Claude Code](https://github.com/anthropics/claude-code) CLI tool
- Obsidian (optional, for better note management experience)

### Installation

#### 1. Clone the Project

```bash
# Clone to your projects directory
git clone https://github.com/y2hhbw/life_coach.git ~/projects/life-coach
```

#### 2. Integrate with Obsidian

**Option 1: Symbolic Links (Recommended)**

```bash
# Assuming your Obsidian vault is at ~/Documents/obsidian/my-vault
cd ~/Documents/obsidian/my-vault

# Create symbolic links
ln -s ~/projects/life-coach/journal ./journal
ln -s ~/projects/life-coach/templates ./templates
```

**Option 2: Direct Copy**

```bash
# Copy files to Obsidian vault
cp -r ~/projects/life-coach/journal ~/Documents/obsidian/my-vault/
cp -r ~/projects/life-coach/templates ~/Documents/obsidian/my-vault/
```

#### 3. Install Skill

```bash
# Copy skill to Claude Code skills directory
cp ~/projects/life-coach/SKILL.md ~/.claude/skills/life-coach.md
```

#### 4. Configure Environment

Edit the Skill file to set your Obsidian vault path:

```bash
# Open skill file
nano ~/.claude/skills/life-coach.md

# Modify VAULT_ROOT variable to your Obsidian vault path
VAULT_ROOT = /path/to/your/obsidian/vault
```

#### 5. Initialize Core Files

Create your own vision and goal files based on templates:

- `journal/vision_2028/plan.md` - Define your 2028 vision
- `journal/vision_2028/anti-vision.md` - Describe the future you want to avoid
- `journal/vision_2028/2026/goal.md` - Set 2026 annual goals
- `journal/nav_tracker.md` - Start tracking your net worth

---

## 📁 File Structure

```
life-coach/
├── SKILL.md                          # Skill definition
├── README.md                         # Documentation (English)
├── README_zh.md                      # Documentation (Chinese)
├── templates/                        # Templates
│   ├── daily_template.md            # Daily journal template
│   └── weekly_template.md           # Weekly report template
└── journal/                          # Journal directory
    ├── vision_2028/                 # 3-year vision
    │   ├── plan.md                  # 2028 vision plan
    │   ├── anti-vision.md           # Anti-vision (nightmare scenario)
    │   └── 2026/
    │       └── goal.md              # 2026 annual goals
    ├── nav_tracker.md               # Net worth tracker
    ├── daily/                       # Daily journals
    │   └── {YYYY}/{MM}/
    │       └── {YYYY-MM-DD}.md     # Daily journal
    └── weekly/                      # Weekly reviews
        └── {start_date}_{end_date}.md  # Weekly review
```

---

## ⚡ Quick Start

### First Time Use

1. **Create Your Vision Files**
   - Edit `journal/vision_2028/plan.md` to describe your ideal state in 2028
   - Edit `journal/vision_2028/anti-vision.md` to describe the future you want to avoid
   - Edit `journal/vision_2028/2026/goal.md` to set this year's specific goals

2. **Start Your First Day**
   ```bash
   # Run in Claude Code
   /life-coach morning
   ```
   The system will automatically create today's journal and provide planning advice

3. **Fill in Your Journal**
   - Open today's journal in Obsidian
   - Fill in intentions (today's intentions)
   - Record happenings (what happened)
   - Record grateful for (things you're grateful for)
   - Update action items (action checklist)
   - Write feelings (reflections and insights)

4. **Evening Review**
   ```bash
   /life-coach night
   ```
   The system will analyze your journal, run 8 diagnostic tools, and provide coaching advice

---

## 📝 Usage Guide

### Available Commands

#### `morning` - Morning Planning
```bash
/life-coach morning
```
- Read yesterday's journal and run diagnostics
- Provide today's planning advice
- Automatically create today's journal file

#### `check` - Daytime Check
```bash
/life-coach check
```
- Read today's journal content
- Check Top 1 task progress
- Run diagnostic tools and provide real-time feedback
- Optional: Record current progress to journal

#### `night` - Evening Review
```bash
/life-coach night
```
- Analyze today's complete journal content
- Run all 8 diagnostic tools
- Provide improvement suggestions and tomorrow's direction

#### `weekly` - Weekly Review
```bash
/life-coach weekly
```
- Summarize all journals from this week
- Generate weekly report file
- Analyze net worth changes
- Provide strategic-level advice

---

## 🎯 Core Philosophy

Life Coach is not a gentle assistant, but a strict coach. It will:

- ❌ Not say "you can do it", but "go do it"
- ❌ Not comfort your emotions, but speak with data and facts
- ❌ Not accept vague plans, but force you to make choices
- ✅ Directly point out your procrastination and avoidance
- ✅ Use anti-vision to remind you of the future you don't want
- ✅ Verify your action value with net worth and output

**Remember: Every minute is either pushing you toward your ideal 2028 self, or toward the mediocre life you want to avoid.**

---

## 📄 License

MIT
