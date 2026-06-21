# Skill-Engineer: Architecture & Core Mechanics

**Version:** 5.0 (17-Point Benchmark Schema, Discoverability & Security Gate, skill-benchmarker)

ðŸ‡©ðŸ‡ª [Lies dies auf Deutsch](README.de.md)

âš ï¸ **CRITICAL WARNING:** This Skill is designed EXCLUSIVELY for Agent-First IDEs with file-system access (Antigravity, Cursor, Claude Code). Do **NOT** use in generic Web-Chats (ChatGPT, Claude.ai, Gemini Advanced). The core "Stateful Setup Phase" requires local write permissions to physically rewrite the `SKILL.md` file.

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

## 2. Ecosystem Mapping & Stateful Pruning *(New in v4.4)*
Before the agent starts generating, it performs a two-step analysis:
* **Stateful Skill-Map Check:** Checks via `.skill-config.json` whether an `ECOSYSTEM.md` map exists. If it is missing, the Engineer delegates to its specialized sub-agent (**skill-mapper**) to recursively map the workspace ecosystem. This architectural split (Separation of Concerns) offloads heavy scanning logic into a dedicated tool.
* **Pruning & Router-Check:** The Engineer reads *only* the `ECOSYSTEM.md` map (instead of blindly opening all 50 files in the folder), which saves tokens and prevents context inflation. If it detects direct conflicts through the map, it automatically suggests generating a "Router-Skill".
* **Benchmark Scan (Optional):** For complex skills, the agent can research external solutions to identify must-have features and USPs.

---

## 2b. Dependency System *(New in v4.5)*
Skills can declare other skills as dependencies:

```yaml
requires:
  - brand-guidelines
```

* **WARNING, not abort:** If a dependency is missing, the Skill-Engineer emits a warning. No hard stop â€” skills are often usable without their optional sub-skills.
* **Relative paths as standard:** Skill-to-skill references always use relative paths (`../skill-name/references/`). Absolute paths and workspace-specific paths (`.agents/...`) are a Quality Gate blocker.
* **Quality Gate Criterion #10:** Automatically checks whether declared dependencies are correctly listed in the frontmatter and whether an environment check with WARNING exists in the workflow.

---

## 3. The 5 Operating Modes (Input Routing)
If there is no duplication issue (or the user explicitly requests a rebuild), the intelligent routing takes over:

1. **Mode A (Blank Canvas):** The user only has a rough idea. The agent initiates the full 10-question interview.
2. **Mode B (Existing Draft):** The user provides a skill draft. The agent performs a hard **Gap Analysis**.
3. **Mode C (Audit / Edit):** For existing skills.
   * **C-Audit:** The agent evaluates a legacy skill against the 12-point Quality Gate and presents a report.
   * **C-Edit:** The agent executes a defined detail change immediately and validates only the modified section.
4. **Mode D (Quick Draft):** Trivial utility skills skip the interview â€” instant light template.
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

## 5. The 12-Point Quality Gate *(Expanded in v5.0)*
Before the Skill-Engineer releases a target skill, it checks it against 12 criteria:

### A. Architectural Purity (0â€“3 Points)
1. Native XML-Tags (no prose instructions)
2. Mechanics over Adjectives
3. Platform-agnostic format (YAML-Frontmatter)

### B. Anti-Hallucination & Factual Accuracy (0â€“4 Points)
4. Environment Check in Step 1
5. Self-Correction / Chain-of-Thought injected
6. Explicit Taboo list
7. Unconfirmed references marked with `<!-- UNCONFIRMED -->` *(persons, experimental methods, or obscure/proprietary tools â€” established OSS libraries exempt)*

### C. Developer Experience (0â€“3 Points)
8. Zero-Shot Triggering precision
9. Few-Shot example included
10. Stateful/Stateless correctness

### D. Ecosystem Integration & Maintainability (0â€“3 Points) *(New in v4.0)*
11. **Cross-Skill Delegation:** Sub-tasks delegated to specialized neighbor skills with briefing + return format.
12. **Reference Quality:** Every reference file independently usable, under 200 lines, Mermaid for decision trees with â‰¥3 branches.
13. **Update Capability:** Dynamic reference files (inventories, lists) contain date, maintenance rules, and status tracking.

### E. Discoverability (0â€“2 Points) *(New in v5.0)*
14. **Trigger Precision:** Description is specific enough to avoid false positives, broad enough to catch all relevant requests.
15. **Decoy Resistance:** `Do not use this skill when` block explicitly lists thematically similar but incorrect use cases.

### F. Security (0â€“2 Points, penalty possible) *(New in v5.0)*
16. **No dangerous instructions:** Skill does not instruct the agent to delete files without confirmation, expose secrets, or make unconfirmed network requests.
17. **State hygiene:** If stateful, `.gitignore` requirement for config/secret files is explicitly documented. *(Score: -1 if dangerous behavior is actively instructed â€” ðŸš¨ CRITICAL)*

---

## 6. Formal Benchmarking *(New in v5.0)*
When a skill is considered "done", use the companion **`skill-benchmarker`** to produce a formal `BENCHMARK.md` evaluation:
- Scores the skill against all 17 criteria (Aâ€“F dimensions)
- Flags zero-scoring dimensions with âš ï¸ WARNING
- Issues ðŸš¨ CRITICAL for Security = 0 or Security = -1
- Verdict: PASS (â‰¥14/17, no CRITICAL) / CONDITIONAL / FAIL / CRITICAL
- Required before `/publish`

---

*(This document is an automatically generated system description of the agent)*

