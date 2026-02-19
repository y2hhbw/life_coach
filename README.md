# Life Coach - AI 驱动的人生教练系统

一个基于 Claude Code Skill 的人生目标管理和日常指导系统，帮助你将长期愿景分解为可执行的日常行动。

## 📖 系统逻辑

### 核心方法论

Life Coach 采用**自上而下的目标分解**和**反向激励**相结合的方法论：

#### 1. 三层目标体系

```
3年愿景 (vision_2028/plan.md)
    ↓ 分解
1年计划 (vision_2028/2026/goal.md)
    ↓ 指导
每日行动 (daily/*.md)
```

**工作原理：**
- **3年愿景 (plan.md)**：定义你在2028年想成为什么样的人，包括事业、财务、健康、关系等各方面的理想状态
- **1年计划 (goal.md)**：将3年愿景分解为当年的具体目标，包括季度目标、月度指标、每日习惯
- **每日日报 (daily/*.md)**：记录每天的意图(intentions)、发生的事(happenings)、感恩(grateful for)、行动项(action items)、感受(feelings)

**Skill 的作用：**
- 每天早上/晚上运行时，读取你的3年愿景和1年计划
- 分析你的日报内容，检查是否与目标对齐
- 通过8个诊断工具(Diagnostic Lenses)提供针对性的教练建议

#### 2. 反愿景机制 (Anti-Vision)

除了正向的目标激励，系统还使用**反愿景**来提供"痛感驱动"：

- **anti-vision.md** 描述了如果你今天选择逃避和低效，未来会变成什么样子
- 当检测到拖延、逃避、低效行为时，Skill 会引用反愿景内容，提醒你不想要的未来
- 这种"负面激励"比单纯的正向目标更有冲击力

> 灵感来源：[How to fix your entire life in 1 day](https://x.com/thedankoe/status/2010751592346030461) by @thedankoe

#### 3. 8个诊断工具

Skill 内置了8个精准诊断工具，在每次交互时自动检查：

1. **目标连线** - 检查日常任务是否与年度目标对齐
2. **身份拷问** - 检查行为是否配得上你的愿景身份
3. **行动验证** - 检查是否有实际产出，而非自我感动
4. **噩梦唤醒** - 在检测到逃避时，用反愿景警醒你
5. **净值对照** - 对比资产变化与行动投入
6. **时间黑洞** - 检测是否在做"伪工作"
7. **周复盘** - 每周生成周报并提供战略建议
8. **数据说话** - 用客观数据验证你的成效

---

## 🚀 如何使用

### 前置要求

- [Claude Code](https://github.com/anthropics/claude-code) CLI 工具
- Obsidian（可选，用于更好的笔记管理体验）

### 安装步骤

#### 1. Clone 项目到本地

```bash
# Clone 到你的项目目录
git clone https://github.com/y2hhbw/life_coach.git ~/projects/life-coach
```

#### 2. 整合到 Obsidian 库

有两种方式将 Life Coach 整合到你的 Obsidian 库：

**方式一：符号链接（推荐）**

```bash
# 假设你的 Obsidian 库路径是 ~/Documents/obsidian/my-vault
cd ~/Documents/obsidian/my-vault

# 创建符号链接
ln -s ~/projects/life-coach/journal ./journal
ln -s ~/projects/life-coach/templates ./templates
```

**方式二：直接复制**

```bash
# 将文件复制到 Obsidian 库
cp -r ~/projects/life-coach/journal ~/Documents/obsidian/my-vault/
cp -r ~/projects/life-coach/templates ~/Documents/obsidian/my-vault/
```

#### 3. 安装 Skill

```bash
# 复制 skill 到 Claude Code skills 目录
cp ~/projects/life-coach/SKILL.md ~/.claude/skills/life-coach.md
```

#### 4. 配置环境变量

编辑 Skill 文件，设置你的 Obsidian 库路径：

```bash
# 打开 skill 文件
nano ~/.claude/skills/life-coach.md

# 修改 VAULT_ROOT 变量为你的 Obsidian 库路径
VAULT_ROOT = /path/to/your/obsidian/vault
```

#### 5. 初始化核心文件

根据模板创建你自己的愿景和目标文件：

- `journal/vision_2028/plan.md` - 定义你的 2028 年愿景
- `journal/vision_2028/anti-vision.md` - 描述你想避免的未来
- `journal/vision_2028/2026/goal.md` - 设定 2026 年度目标
- `journal/nav_tracker.md` - 开始追踪你的净资产

---

## 📁 文件结构

```
life-coach/
├── SKILL.md                          # Skill 定义文件
├── README.md                         # 项目说明
├── templates/                        # 模板目录
│   ├── daily_template.md            # 日报模板
│   └── weekly_template.md           # 周报模板
└── journal/                          # 日志目录
    ├── vision_2028/                 # 3年愿景
    │   ├── plan.md                  # 2028愿景规划
    │   ├── anti-vision.md           # 反愿景（噩梦场景）
    │   └── 2026/
    │       └── goal.md              # 2026年度目标
    ├── nav_tracker.md               # 净资产追踪表
    ├── daily/                       # 日报目录
    │   └── {YYYY}/{MM}/
    │       └── {YYYY-MM-DD}.md     # 每日日报
    └── weekly/                      # 周报目录
        └── {start_date}_{end_date}.md  # 每周复盘
```

---

## ⚡ 快速开始

### 第一次使用

1. **创建你的愿景文件**
   - 编辑 `journal/vision_2028/plan.md`，描述你 2028 年的理想状态
   - 编辑 `journal/vision_2028/anti-vision.md`，描述你想避免的未来
   - 编辑 `journal/vision_2028/2026/goal.md`，设定今年的具体目标

2. **开始第一天**
   ```bash
   # 在 Claude Code 中运行
   /life-coach morning
   ```
   系统会自动创建今日日报，并提供规划建议

3. **填写日报**
   - 在 Obsidian 中打开今日日报
   - 填写 intentions（今日意图）
   - 记录 happenings（发生的事）
   - 记录 grateful for（感恩的事）
   - 更新 action items（行动清单）
   - 写下 feelings（感受和反思）

4. **晚间复盘**
   ```bash
   /life-coach night
   ```
   系统会分析你的日报，运行 8 个诊断工具，提供教练建议

---

## 📝 使用指南

### 可用命令

#### `morning` - 早间规划
```bash
/life-coach morning
```
- 读取昨日日报并进行诊断
- 提供今日规划建议
- 自动创建今日日报文件

#### `check` - 日间检查
```bash
/life-coach check
```
- 读取今日日报内容
- 检查 Top 1 任务进度
- 运行诊断工具，提供实时反馈
- 可选：记录当前进展到日报

#### `night` - 晚间复盘
```bash
/life-coach night
```
- 分析今日日报完整内容
- 运行全部 8 个诊断工具
- 提供改进建议和明日方向

#### `weekly` - 周复盘
```bash
/life-coach weekly
```
- 汇总本周所有日报
- 生成周报文件
- 分析净值变化
- 提供战略级建议

---

## 🎯 核心理念

Life Coach 不是一个温和的助手，而是一个严格的教练。它会：

- ❌ 不会说"加油"，而是说"去做"
- ❌ 不会安慰你的情绪，而是用数据和事实说话
- ❌ 不会接受模糊的计划，而是强制你做出选择
- ✅ 直接指出你的拖延和逃避
- ✅ 用反愿景提醒你不想要的未来
- ✅ 用净值和产出验证你的行动价值

**记住：每一分钟都在推动你成为 2028 年理想的自己，或者推向你想避免的平庸生活。**

---

## 📄 License

MIT

