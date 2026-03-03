[English](README.md) | [中文](README_zh.md)

# Life Coach - Your Hardcore AI Life Coach

**Stop lying to yourself. Stop using tactical diligence to cover up strategic laziness.**

This is a No-BS goal management system run by a custom AI CLI Skill. It doesn't just break down your long-term vision; it uses harsh numbers and "Anti-Vision" to tear through your procrastination excuses, ensuring every minute you spend pushes you toward your ideal 2028 self.

**It won't tell you "You can do it". It will tell you "Go do it."**

---

## 📖 System Logic & Flywheel

Life Coach combines **top-down goal breakdown** with **negative motivation (Pain-driven)**:

```mermaid
graph TD
    A[3-Year Vision 2028] -->|Top-Down Breakdown| B(1-Year Goal 2026)
    B -->|Guides Daily Actions| C{Daily Journal}
    C -->|Morning: Plan & Align| D[AI CLI Skill]
    C -->|Check: Status Correct| D
    C -->|Night/Weekly: Review| D
    E[Anti-Vision Nightmare] -.->|Pain-driven| D
    F[NAV Tracker] -.->|Data Validation| D
    D -->|8 Diagnostic Lenses| C
```

### 1. Three-Tier Goal System
- **3-Year Vision (plan.md)**: Define who you want to be in 2028 - career, finance, health, relationships.
- **1-Year Plan (goal.md)**: Break down the 3-year vision into specific annual goals, quarterly targets, and daily habits.
- **Daily Journal (daily/*.md)**: Record daily intentions, happenings, gratitudes, action items, and feelings.

### 2. Anti-Vision Mechanism
Beyond positive goals, the system uses an **anti-vision** for "pain-driven" motivation:
- When procrastination, avoidance, or inefficiency is detected, the system quotes your anti-vision to remind you of the very future you're terrified of.
- This "negative reinforcement (loss aversion)" is often far more impactful than purely positive goals.

<details>
<summary>👀 View Anti-Vision (Nightmare Scenario) Template</summary>

*One morning in 2028, I wake up.*
*I am still living in this small, messy apartment. My phone is lighting up with bills I still cannot pay.*
*I look at my out-of-shape body and thinning hair in the mirror. I'm still working that easily-replaced-by-AI job, wasting my life in meaningless meetings and alignment syncs.*
*I see my peers achieving the goals I originally set for myself, and I can only comfort my incompetence by calling myself "ordinary but precious."*
</details>

> Inspired by: [How to fix your entire life in 1 day](https://x.com/thedankoe/status/2010751592346030461) by @thedankoe

### 3. 8 Precision Diagnostic Lenses
The system runs 8 harsh diagnostic lenses to automatically check and slap you back to reality during each interaction:

1. **🎯 Goal Alignment (Hierarchy Check)**: Checks if daily tasks align with annual goals.
   > *"You spent 3 hours on this task today, and it has absolutely nothing to do with your 2026 goals. Are you using busyness to mask ineffectiveness again? Delete it immediately."*
2. **🪞 Identity Audit**: Checks if your behavior matches the identity of your vision.
3. **🚧 Action Verification**: Checks for actual output, not just feeling productive.
4. **🛡️ Nightmare Wake-up (Anti-Vision Reality)**: Uses anti-vision to alert you when severe avoidance is detected.
   > *"Look at your Anti-vision: 'Still working a job you don't care about...' Every excuse you make today is pushing you into that mediocre abyss."*
5. **📉 NAV Alert**: Compares asset changes against action investment.
   > *"Your net worth is shrinking, yet you wrote 7 journals this week. Tactical diligence cannot cover up strategic incompetence."*
6. **⏳ Time Black Hole**: Detects if you're doing "fake work" (like over-optimizing tools).
7. **🔄 Weekly Review**: Generates a weekly report and provides strategic advice.
8. **📊 Data Speaks**: Verifies your effectiveness using objective numbers.

---

## 🚀 Why Life Coach?

🔐 **Local-First Data Privacy (Obsidian)**  
Your deepest desires, anxieties, financials, and diary details remain in your local Obsidian vault. During command runtime, relevant content is sent to your configured AI model API for analysis, while files stay in your local vault.

### Safety by Default
- Installer uses non-destructive copy mode by default (`existing files are not overwritten`).
- If `journal/vision_2028/2026/goal.md` is missing, installer creates it from language-specific template.
- Installer creates a clean journal structure and does not import sample daily/weekly history.
- Existing journal history in your vault is preserved.

---

## 📦 How to Install

### Prerequisites
- One of the following AI CLI tools:
  - [Claude Code](https://github.com/anthropics/claude-code)
  - Codex
  - Qwen
  - Opencode
- Obsidian (For the ultimate local Markdown note management experience)

### Setup Steps

1. **Clone the Project**
```bash
git clone https://github.com/y2hhbw/life_coach.git ~/projects/life-coach
cd ~/projects/life-coach
```

2. **Run the Interactive Installation Script**
The easiest way to install and configure the system is to run the interactive setup script. This will copy the necessary templates and journal folders to your Obsidian vault in non-destructive mode, and link the Skill to your preferred AI Assistant.

- **Mac / Linux:**
  ```bash
  chmod +x install.sh
  ./install.sh
  ```
- **Windows (PowerShell):**
  ```powershell
  .\install.ps1
  ```

*Follow the on-screen prompts to select your language, choose your AI Assistant, and provide the absolute path to your Obsidian vault.*

3. **Initialize Core Files**
Open Obsidian and fill in these files:
- `journal/vision_2028/plan.md` - Define your 2028 vision
- `journal/vision_2028/anti-vision.md` - The nightmare future to avoid
- `journal/vision_2028/2026/goal.md` - 2026 annual goals (created from template by installer if missing)

4. **Confirm Vault Structure**
After installation, your vault should include:
```text
journal/
  vision_2028/
    plan.md
    anti-vision.md
    2026/
      goal.md
  daily/
    YYYY/MM/YYYY-MM-DD.md
  weekly/
templates/
  daily_template.md
  weekly_template.md
  goal_template.md
```

---

## ⚡ Quick Start

1. **Morning Planning**
   When starting your day, open a terminal with your chosen AI Assistant loaded and run:
   ```bash
   /life-coach morning
   ```
   The system will generate today's journal based on the template and give you planning advice based on yesterday.

2. **Daytime Filling & Checking**
   - Continuously update your daily journal in Obsidian (intentions, happenings, gratitudes, action items, feelings).
   - Anytime you want AI to spot-check your status, run:
     ```bash
     /life-coach check
     ```

3. **Evening & Weekly Review**
   ```bash
   /life-coach night     # Deep daily feedback
   /life-coach weekly    # Strategic weekly report
   ```

## 🧭 Command Invocation (Multi-Assistant)

- Preferred: call the skill directly with mode, e.g. `/life-coach morning`
- If your assistant does not support slash command + args in one line:
  - Invoke skill first: `/life-coach`
  - Then send mode keyword in next message: `morning` / `check` / `night` / `weekly`

---

## 🛠️ Troubleshooting

- **`Core file missing: goal.md`**  
  Ensure `journal/vision_2028/2026/goal.md` exists in your Obsidian vault.

- **`No journal created today`**  
  Run `/life-coach morning` first, then use `/life-coach check` or `/life-coach night`.

- **Skill not found in your AI CLI**  
  Re-run installer and verify you selected the correct assistant (`Claude Code` / `Codex` / `Qwen` / `Opencode`).

- **Slash command behavior differs across assistants**  
  Invoke `/life-coach` first, then send `morning` / `check` / `night` / `weekly` as a follow-up message.

- **Template not applied as expected**  
  Re-run installer using an absolute script path and verify your selected language.

---

## 💡 Support & Donation

If you feel this hardcore Life Coach system is altering the trajectory of your life, support the development:

<a href="https://nowpayments.io/payment/?iid=5525026308&source=button" target="_blank" rel="noreferrer noopener">
   <img src="https://nowpayments.io/images/embeds/payment-button-black.svg" alt="Crypto payment button by NOWPayments">
</a>
<a href="https://www.buymeacoffee.com/hallidayyy" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" >
</a>

---

## 📄 License

[MIT](LICENSE)
