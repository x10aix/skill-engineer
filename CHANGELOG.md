# Changelog: Skill-Engineer

This document tracks the structured version history of the Skill-Engineer based on commits since development scaled via Agent-First IDEs (specifically Antigravity).

---

### [Latest] June 21, 2026
**Version 1.3.0 — "Skill Benchmarker & Quality Gate 2.0" Release**

* `tbd` - **feat**: **New Skill: `skill-benchmarker`** — Standalone evaluation agent using a 17-point scoring schema to benchmark any SKILL.md objectively. Generates structured `BENCHMARK.md` output reports with per-criterion scores, qualitative remarks, and final verdict.
* `tbd` - **feat**: **`skill-engineer` v5.0** — Quality Gate upgraded to 12 mandatory criteria, adding two new dimensions: Discoverability (trigger precision, boundary clarity) and Security (secret handling, privilege escalation prevention).
* `tbd` - **feat**: **`skill-mapper` v2.0** — Domain-Awareness introduced. Mapper now reads `skill-mapper-config.json` for domain grouping rules and generates separate domain-specific maps alongside the central `ECOSYSTEM.md`.
* `tbd` - **feat**: **Scoring Schema v2.0** — 17-point evaluation schema (expanded from 13). Includes a Retrofit Guidance section for incrementally upgrading legacy skills, and a precise redefinition of criterion B.4 (Statelessness vs. Statefulness).
* `tbd` - **docs**: **README.md v5.0** — Fully updated to reflect the new skill trio (skill-engineer, skill-mapper, skill-benchmarker) and the v2.0 scoring framework.

---

### June 3, 2026
**Version 4.5 — "Dependency-Aware Quality Gate" Update**

* `tbd` - **feat**: **Dependency System** — Skills can now declare `requires:` in the YAML frontmatter. The Skill-Engineer emits a WARNING when a dependency is missing — no hard abort, as skills can remain useful without their optional sub-skills.
* `tbd` - **feat**: **Quality Gate Criterion #10 (Dependency-Check)** — New mandatory criterion: checks whether external file or skill references are declared in `requires:`, and whether `<process_workflow>` Step 1 includes an environment check with WARNING (not abort).
* `tbd` - **feat**: **Path Portability as Blocker (Anti-Hall #6)** — New rule in the Anti-Hallucination Checklist: absolute paths (`C:\...`) and workspace-specific paths (`.agents/...`) inside skill instructions are a blocker and must be replaced with relative paths plus a `requires:` declaration.
* `tbd` - **fix**: **Criterion #2 bullet-proof** — The "Mechanic over Adjectives" rule now defines the class of forbidden words ("any word that could be removed without changing the agent's actual behavior") instead of listing specific example words.
* `tbd` - **fix**: **Framework Verification clarified** — Well-established models (AIDA, SWOT, OKR, MECE) are considered pre-verified. Only niche or person-specific frameworks require research and user confirmation.
* `tbd` - **fix**: **Filesystem Conditional** — `write_to_file` in Step 0 now has an explicit fallback for platforms without filesystem access: output configuration as a code block for manual creation.
* `tbd` - **fix**: **Stale Criterion Count** — Reference to "8 criteria" in Step C1 corrected to 10.
* `tbd` - **docs**: **External Example** — Added `examples/example-skill-creation.md`: a complete Mode B session from user request to finished SKILL.md including Quality Gate results. Additional examples can be added.
* `tbd` - **fix**: **brand-enforcement** — Replaced hardcoded `.agents/brand/guidelines.md` path with relative `../brand-guidelines/references/` paths. Declared `requires: [brand-guidelines]` in frontmatter.

---

### [Latest] May 13, 2026
**Version 4.4 — „Agent Economy 2026" Update**

* `tbd` - **feat**: **Stateful Ecosystem Pruning** — The Skill-Engineer now reads only the `ECOSYSTEM.md` map in Phase 0 (statefully tracking via `.skill-config.json`), preventing token bloat and context inflation.
* `tbd` - **feat**: **Skill-Mapper Extraction** — The recursive mapping logic (formerly Modus M) has been extracted into a separate `skill-mapper` agent for better separation of concerns.
* `tbd` - **feat**: **Conflict-Router** — When overlapping skills are detected, the agent proactively suggests generating a "Router-Skill" rather than just issuing a warning.
* `tbd` - **feat**: **Toxic Inputs & TSD** — Phase 3 (Test-Driven Skill Development) now explicitly requires the design of "Toxic Inputs" (e.g., excessively long strings, race conditions) for edge-case testing.
* `tbd` - **feat**: **Dialectical Validation (Red Teaming)** — Introduced Phase 2.5: The agent must attack its own skill draft in an "Adversarial Build" mode (logic flaws, statelessness checks, IDE constraints).


### [Latest] April 29, 2026
**Version 4.3 — "Stateless Architecture" Update**

* `tbd` - **feat**: **Stateless Design** — Full transition from inline configuration blocks (`<!-- CONFIGURATION_START -->`) to strict local `.skill-config.json` files. Prevents git conflicts during updates and separates skill logic from user state.
* `tbd` - **feat**: **Monorepo Ready** — Cleaned up architecture for seamless integration into centralized skill libraries (x10aix-skills).

---

### [Latest] April 20, 2026
**Version 4.2 — "Model-Agnostic Prompting" Update**

* `tbd` - **feat**: **llm-conventions.md** — Introduced a centralized reference for model-agnostic prompting, preventing IF/ELSE branching by `Target LLM`.
* `tbd` - **feat**: **Constraint-Checks** — Replaced recursive "Self-Correction" CoT-loops with strict final Constraint-Checks, optimizing performance for Reasoning Models (e.g., Opus 4.7, o1).
* `tbd` - **feat**: **Depth-Signals** — The Skill-Engineer now generates deep contextual constraints instead of forcing a `<scratchpad>` for thoughts.
* `tbd` - **docs**: Added example `04-model-agnostic-refactoring.md` showing how legacy skills like `google-ads-manager` are audited to fit the new conventions.

---

### April 16, 2026
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
