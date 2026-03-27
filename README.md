# Skill-Engineer: Architecture & Core Mechanics

**Version:** 3.1 (Stateful Design, Native XML-Tags, Anti-Hallucination)

🇩🇪 [Lies dies auf Deutsch](README.de.md)

⚠️ **CRITICAL WARNING:** This Skill is designed EXCLUSIVELY for Agent-First IDEs with file-system access (Antigravity, Cursor, Claude Code). Do **NOT** use in generic Web-Chats (ChatGPT, Claude.ai, Gemini Advanced). The core "Stateful Setup Phase" requires local write permissions to physically rewrite the `SKILL.md` file.

## Supported Platforms (Profiles)
- **Google Antigravity:** Native Support. (Perfect match for YAML-Frontmatter & Progressive Disclosure).
- **Cursor IDE:** Native Support. (Agents correctly read XML tags and execute the 4-Phase routing).
- **Claude Code / Root CLIs:** Native Support. (The Dedup-Scan is restricted to local queries to prevent runaway `find /` commands).

---

The *Skill-Engineer* is a meta-agent. It is not designed to assist end-users directly with domain-specific tasks. Instead, it develops, audits, and configures other agents (skills). It forces the underlying LLM into methodological rigor, eliminates generic fluff, and prevents "Yes-Man" behavior.

> **Credits & Architecture:** The implementation of the *"Progressive Disclosure Architecture"* (offloading context into `references/` and `scripts/` to conserve the Context Window) is heavily based on the concepts of the **Skill-Creator** by **Clawdbot** (Developer: Peter Steinberger).

---

## 1. The Setup Phase (Stateful Configuration)
The Skill-Engineer is a **Stateful Agent**. It maintains a `<configuration>` block directly within its own codebase.

* **On Initial Launch (`STATUS: UNCONFIGURED`):** 
  The agent blocks all other workflows. It detects its current runtime environment (e.g., Platform = Antigravity, LLM = Gemini, Language = English) and proposes these as system defaults. Once the user confirms, the agent uses its file-system permissions to physically rewrite the block in its own `SKILL.md` to `CONFIGURED`.
* **In Normal Operation (`STATUS: CONFIGURED`):**
  The agent stops prompting the user for parameters (Target LLM, Platform, etc.) and silently enforces its hardcoded defaults as law. This saves tokens and dramatically reduces user friction.
* **Command `/config`:**
  The user can type `/config` at any time to explicitly overwrite the stored defaults in the file system.

---

## 2. Environment Scan (Dedup Check)
Before the agent starts generating, it scans the current project workspace and the global tools directory.
* If it finds an already existing, thematically similar skill (e.g., an existing `csv-converter`), it pauses.
* It outputs a brief comparison and poses the **Stand-Alone Dedup Question**: *"Should we edit the existing skill (Mode C), clone/adapt it, or start completely from scratch?"*
* This prevents uncontrolled skill bloat and redundancy.

---

## 3. The 4 Operating Modes (Input Routing)
If there is no duplication issue (or the user explicitly requests a rebuild), the intelligent routing takes over:

1. **Mode A (Blank Canvas):** The user only has a rough idea. The agent initiates the full 7-question interview.
2. **Mode B (Existing Draft):** The user provides a document (e.g., Company Guidelines). The agent performs a hard **Gap Analysis**. If the user provides empty phrases ("Target Audience: Everyone"), the agent rejects this as invalid and insists until the precise functional mechanics are clarified.
3. **Mode C (Audit / Edit):** For existing skills.
   * **C-Audit:** The agent evaluates a legacy skill against the 9-point Quality Gate and presents a report before touching the code.
   * **C-Edit:** The agent executes a defined detail change within a legacy file immediately (e.g., "Add Rule X") and only validates the modified section.
4. **Mode D (Quick Draft):** The bypass. If the skill is trivial (e.g., a pure utility like "Git Commit Formatter"), the agent skips the interview and persona definition completely, instantly outputting a light template.

---

## 4. Adversarial Validation (Self-Doubt)
The Skill-Engineer is programmed not to be easily satisfied.
Before yielding the final skill (strategy proposal) in Phase 3, it is strictly required to formulate a **counter-argument (Veto)** against its own approach. 
If no logical flaw exists, it must instead identify the most dangerous operational **Edge Case** where the future target skill is most likely to fail.

---

## 5. The 9-Point Quality Gate
Before the Skill-Engineer releases a target skill, it silently forces it (or reports it to the user during an audit) through this checklist:

1. No fluff ("You are an expert")
2. Mechanics over Adjectives (positive and negative examples instead of the word "helpful")
3. Taboos defined
4. Workflow executable
5. Example (Few-Shot) provided
6. Triggering precisely defined
7. Platform conformity (YAML-Frontmatter, etc.)
8. References validated
9. **Anti-Hallucination by Design** *(New)*

### Deep-Dive: The Anti-Hallucination Mechanic
A skill that invents facts or makes unfounded assumptions is toxic. The 9th Quality Gate enforces:
* **Tool Validation:** Does the target skill require tools like Email APIs? If so, the Skill-Engineer forces the agent to inject an Environment Check as Step 1 into its workflow.
* **Forbidden Frameworks:** All referenced frameworks, APIs, and personas must be factually researched. If a search tool is missing, they receive the hard-tag `<!-- UNCONFIRMED -->`.
* **Inherited Self-Correction:** More complex target skills receive an injected rule from the Engineer, forcing them to critically review their own output against their sharpest taboos and typical error sources *of this specific skill* as a final step (Double-Check) before delivering it to the user.

---

*(This document is an automatically generated system description of the agent)*
