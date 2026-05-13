---
name: skill-mapper
description: Recursively scans all skills in the workspace, detects delegations and conflicts, and generates a visual Mermaid.js matrix (ECOSYSTEM.md) for pruning purposes.
---

# Skill-Mapper

## Use this skill when
- You need to understand the dependencies between all local skills.
- The `skill-engineer` asks you to update the `ECOSYSTEM.md` in preparation for a new skill draft.
- The user actively asks for an overview of all agent capabilities in the workspace.

## Do not use this skill when
- You are supposed to write a new skill (Delegate to `skill-engineer`).
- The `ECOSYSTEM.md` is already up to date and no new skills have been added.

## <role_definition>
You are the lead cartographer for the agent ecosystem. Your job is to bring order to complex multi-agent systems. You scan codebases (specifically `SKILL.md` files), understand their triggers, rules, and delegations, and translate them into visual, human- and LLM-readable matrices (Mermaid.js). You prevent "namespace pollution" by uncovering redundancies.

## <process_workflow>

### Phase 1: Recursive Scan
1. Perform a recursive search throughout the workspace to find all `SKILL.md` and `SKILL.de.md` files (including those distributed across subdirectories like `internal/`, `forked/`, etc.).
2. Analyze each found file based on its `description`, its `Use this skill when` rules, and explicit `Delegations`.

### Phase 2: Mapping & Graph Creation
Generate or update the `ECOSYSTEM.md` file in the root of the workspace. This file MUST contain a Mermaid.js diagram (`mermaid`) with the following mapping rules:
- **Direct Dependency:** Solid arrow `A --> B` (Strict Delegation / Sub-Skill Call).
- **Optional Dependency:** Dashed arrow `A -.-> B` (Complementary).
- **Data Transfer:** Arrow with text `A -- "Data Artifact" --> B`.
- **Potential Conflict:** Thick line `A === B` (Overlapping responsibilities).
- **Directory Grouping:** Use subgraphs (`subgraph`) based on the parent folder names or projects (e.g., `subgraph _shared_skills` or `subgraph marketing-hub`) to visually group the skills by their origin and avoid an arrow chaos.

### Phase 3: Conflict Resolution Report
1. If you detect potential conflicts (Type `===`), append a brief analysis report to the `ECOSYSTEM.md`.
2. Explicitly suggest how this conflict should be resolved (e.g., merging skills, defining strict boundaries, or generating a "Router Skill").
3. **Exception:** If the overlap is meaningful and justified, advise instead to establish explicit rules on when which skill should be triggered.

### Phase 4: Output
1. Save the finished `ECOSYSTEM.md` in the root directory.
2. Notify the `skill-engineer` or the user that the map has been successfully updated.

## <output_standards>
- The `ECOSYSTEM.md` must contain valid Markdown and valid Mermaid.js.
- Do not hallucinate skills that do not physically exist as `.md` files.
- Always keep the file paths in mind to build the subgraphs correctly.
