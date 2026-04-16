# Changelog: Skill-Engineer

This document tracks the structured version history of the Skill-Engineer based on commits since development scaled via Agent-First IDEs (specifically Antigravity).

---

### [Latest] April 16, 2026
**Version 4.1 — "Ecosystem-Mapper" Update**

* `tbd` - **feat**: **Mode M (Mapping)** — Introduced a new mode that recursively scans all skills in the workspace and maps their relationships, delegations, and conflicts into a Mermaid.js diagram (`ECOSYSTEM.md`). Logically groups skills into subgraphs based on their parent directories.
* `tbd` - **docs**: Anonymized examples for the public open-source version.

---

### April 13, 2026
**Version 4.0 — "Ecosystem-Aware" Update**

Seven practice-derived improvements based on real-world observations during the creation of the `google-ads-manager` skill. The Skill-Engineer now understands skill ecosystems, not just individual skills.

* `5e5ffdc` - **feat**: **Mode E (Regeneration)** — Transform existing planning documents, SOPs, process documents, or knowledge bases into production-ready SKILL.md packages. Key difference from Mode B: Mode E handles *unstructured domain knowledge*, not skill drafts.
* `5e5ffdc` - **feat**: **Ecosystem Mapping** in Phase 0 — The agent now scans ALL existing skills in the workspace to identify delegation partners, trigger conflicts, and neutral relationships before creating a new skill.
* `5e5ffdc` - **feat**: **Benchmark Scan** (Phase 0.5, optional) — For complex skills, the agent can research external solutions (SaaS tools, open-source skills, prompt templates) to identify must-have features and USPs.
* `5e5ffdc` - **feat**: **Cross-Skill Delegation Pattern** in Phase 3 — When a skill delegates sub-tasks to another skill, the Engineer now injects a standardized briefing/return-format pattern into the generated `<operational_rules>`.
* `5e5ffdc` - **feat**: **Interview expanded to 10 metrics** (from 8) — Metric 8 split into Static (8a) vs. Dynamic References (8b) with distinct design rules. New Metric 9: Delegation. New Metric 10: Benchmark Gaps.
* `5e5ffdc` - **feat**: **Quality Gate extended** with 3 new checks: Ecosystem Integration, Reference Quality (max 200 lines, Mermaid for decision trees ≥3 branches), and Diagram Quality.
* `5e5ffdc` - **docs**: New reference file `references/reference-templates.md` with 5 scaffolding patterns (Decision Tree/Mermaid, Dynamic Inventory, Checklist, Workflow, Static Reference).
* `5e5ffdc` - **feat**: **Evaluation Schema** expanded to 13 points (from 10) with new Kategorie D: Ecosystem Integration & Maintainability. 4th regression test added for Mode E.

---

### March 27, 2026
**Commits: Claude's Feedback & Final Polish**
* `tbd` - **feat**: Fine-tuning of the Quality Gate (re-integration of triggering and reference checks), clearer definition of the C-Audit/C-Edit separation, and the introduction of an external `anti-hallucination-checklist.md` while adhering to the Progressive Disclosure principle.

**Commits: Internationalization & Workflow Automation**
* `212a6f3` - **feat**: Translation of `README.md` and `SKILL.md` to English for the global open-source community. The original German versions remain available as `*.de.md` and are linked via badges.
* `212a6f3` - **feat**: Introduction of the `.agents/workflows/publish.md` Antigravity workflow. This automates the release process by safely resetting locally modified `<configuration>` blocks back to `UNCONFIGURED` (factory defaults) before every push.

---

### March 26, 2026
**Commits: The "Productization" Update**
* `dcab64d` - **docs**: Addition of the *Hetzner OpenClaw* audit example. Demonstrates in practice how the agent performs a ruthless gap analysis on legacy skills.
* `b992a06` - **docs**: Productization of the repository. The project was transitioned from a raw script into a structured product repository – including clear evaluation schemas and best-practice examples for prompt design.

---

### March 25, 2026
**Commits: Open-Source Release & Platform Synthesis**
* `66969d6` - **docs**: Native integration of the README output directly into the `SKILL.md` system. The agent is forced to manage its own documentation.
* `49d8fd2` - **Initial commit**: The official Open-Source release on GitHub. The Skill-Engineer is now ready for deployment in Antigravity, Cursor, and Claude Code.
* `2ff6b3c` - **docs**: Publication of the detailed development history. Documentation of the conceptual transition phase from isolated chat prompts to a networked, state-based meta-agent.
