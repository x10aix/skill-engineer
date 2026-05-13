# Skill-Engineer: Architecture & Core Mechanics

**Version:** 4.0 (Ecosystem-Aware Design, Cross-Skill Delegation, Mermaid Decision Trees)

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

## 2. Ecosystem Mapping & Dedup Check *(New in v4.0)*
Before the agent starts generating, it performs a two-step analysis:
* **Dedup Scan:** Checks if a thematically similar skill already exists. If found, it pauses and asks whether to edit (Mode C), clone, or rebuild from scratch.
* **Ecosystem Mapping:** Scans ALL existing skills in the workspace and identifies: (a) **Delegation Partners** — skills the new skill should call for sub-tasks, (b) **Conflicts** — skills with overlapping triggers, (c) **Neutral** — no interaction. This prevents both redundancy and monolithic bloat.
* **Benchmark Scan (Optional):** For complex skills, the agent can research external solutions to identify must-have features and USPs.

---

## 3. The 5 Operating Modes (Input Routing)
If there is no duplication issue (or the user explicitly requests a rebuild), the intelligent routing takes over:

1. **Mode A (Blank Canvas):** The user only has a rough idea. The agent initiates the full 10-question interview.
2. **Mode B (Existing Draft):** The user provides a skill draft. The agent performs a hard **Gap Analysis**.
3. **Mode C (Audit / Edit):** For existing skills.
   * **C-Audit:** The agent evaluates a legacy skill against the 13-point Quality Gate and presents a report.
   * **C-Edit:** The agent executes a defined detail change immediately and validates only the modified section.
4. **Mode D (Quick Draft):** Trivial utility skills skip the interview — instant light template.
5. **Mode E (Regeneration):** *(New in v4.0)* An extensive planning document, strategy paper, process document, SOP, or knowledge base exists, but no SKILL.md. The agent reads the legacy document, extracts core functions, workflows, rules and taboos, and translates them into the SKILL.md architecture. Key difference from Mode B: Mode B has a *skill draft*. Mode E has *domain knowledge in unstructured form*.

---

## 4. Adversarial Validation (Self-Doubt)
The Skill-Engineer is programmed not to be easily satisfied.
Before yielding the final skill (strategy proposal) in Phase 3, it is strictly required to formulate a **counter-argument (Veto)** against its own approach. 
If no logical flaw exists, it must instead identify the most dangerous operational **Edge Case** where the future target skill is most likely to fail.

---

## 4b. Cross-Skill Delegation *(New in v4.0)*
When the Interview identifies that sub-tasks could be handled by existing skills, the Engineer injects a **Delegation Pattern** into the generated skill:
* A `NEVER ... delegate to [skill-name]` rule in `<operational_rules>` with a standardized briefing template.
* An expected return format specification.
* A corresponding step in `<process_workflow>` where the delegation occurs.

Example: The `google-ads-manager` skill delegates copywriting to `ad-expert` and brand checks to `brand-guidelines`.

---

## 5. The 13-Point Quality Gate *(Expanded in v4.0)*
Before the Skill-Engineer releases a target skill, it silently forces it through this checklist (13 maximum points across 4 categories):

### A. Architectural Purity (0–3 Points)
1. Native XML-Tags (no prose instructions)
2. Mechanics over Adjectives
3. Platform-agnostic format (YAML-Frontmatter)

### B. Anti-Hallucination & Security (0–4 Points)
4. Environment Check in Step 1
5. Self-Correction / Chain-of-Thought injected
6. Explicit Taboo list
7. Unconfirmed references marked with `<!-- UNCONFIRMED -->`

### C. Developer Experience (0–3 Points)
8. Zero-Shot Triggering precision
9. Few-Shot example included
10. Stateful/Stateless correctness

### D. Ecosystem Integration & Maintainability (0–3 Points) *(New in v4.0)*
11. **Cross-Skill Delegation:** Sub-tasks delegated to specialized neighbor skills with briefing + return format.
12. **Reference Quality:** Every reference file independently usable, under 200 lines, Mermaid for decision trees with ≥3 branches.
13. **Update Capability:** Dynamic reference files (inventories, lists) contain date, maintenance rules, and status tracking.

---

*(This document is an automatically generated system description of the agent)*
