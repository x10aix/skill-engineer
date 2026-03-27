# Changelog: Skill-Engineer

This document tracks the structured version history of the Skill-Engineer based on commits since development scaled via Agent-First IDEs (specifically Antigravity).

---

### [Latest] March 27, 2026
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
