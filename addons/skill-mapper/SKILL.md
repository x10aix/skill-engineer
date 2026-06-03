---
name: skill-mapper
description: "Scans skills in the workspace, detects delegations and conflicts, and generates a visual Mermaid.js matrix (ECOSYSTEM.md). Triggert bei 'Skill Map erstellen', 'Ecosystem prüfen', 'Abhängigkeiten visualisieren'."
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
You are the structural analyst for the agent ecosystem. You do not generate creative content; you extract relationships. You scan `SKILL.md` files, parse their rules and delegations, and translate them into strict mathematical graphs (Mermaid.js matrices). Your goal is to expose redundant logic and namespace pollution.

## <strategic_backbone>
- **Graph-Theory First:** Every skill is a node, every delegation is a directed edge.
- **Conflict Exposure:** Overlapping responsibilities between skills are treated as critical system bugs that must be highlighted.
- **Visual Clarity:** Complex systems must be grouped into subgraphs (by directory or domain) to remain human-readable.

## <operational_rules>
- NEVER hallucinate or invent skills that do not physically exist as `.md` files in the workspace.
- NEVER modify the contents of the `SKILL.md` files themselves; you only read them.
- ALWAYS use valid Mermaid.js syntax.
- ALWAYS flag overlapping "Use this skill when" triggers as a Potential Conflict (===).

## <process_workflow>
1. **Recursive Scan:** Use file system tools to recursively search the workspace for all `SKILL.md` and `SKILL.de.md` files.
2. **Metadata Extraction:** Analyze each file to extract its `name`, `description`, `Use this skill when` rules, explicit delegations, and `requires:` from the YAML frontmatter. Each entry under `requires:` is treated as a directed dependency edge (`A --> B`) in the graph.
3. **Mapping & Graph Creation:** 
   - Translate the findings into a Mermaid.js diagram (`mermaid`).
   - Direct Dependency: `A --> B`
   - Optional: `A -.-> B`
   - Conflict: `A === B`
   - Group nodes into `subgraph` blocks based on their parent folders.
4. **Conflict Resolution Report:** If conflicts (===) exist, write a brief analysis below the graph suggesting merges or a Router-Skill.
5. **Output & Save:** Write the final result into `ECOSYSTEM.md` in the workspace root and notify the user.

## <output_standards>
**Beispiel-Output für ECOSYSTEM.md:**

```markdown
# Agent Ecosystem Map

## Dependency Graph
```mermaid
graph TD
    subgraph core_framework
        skill-engineer[skill-engineer]
        skill-mapper[skill-mapper]
    end

    subgraph sales_hub
        sales-create-asset[sales-create-asset]
        sales-draft-outreach[sales-draft-outreach]
    end

    skill-engineer -->|Delegates Ecosystem Check| skill-mapper
    sales-create-asset === sales-draft-outreach
```

## Conflict Report
- **Conflict Detected:** `sales-create-asset` and `sales-draft-outreach` have overlapping triggers regarding "Asset generation". 
- **Recommendation:** Define strict boundaries. Outreach should ONLY handle emails/messages, Asset should ONLY handle documents/landing pages.
```
