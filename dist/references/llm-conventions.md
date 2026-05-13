# Prompting Guidelines & LLM Conventions

This document acts as the definitive guide to Model-Agnostic Prompting.
When writing mechanics, operational rules, or workflows for any target skill, **you must use model-agnostic wording** so the skill performs optimally on Standard Models (e.g., GPT-4o, Claude 3.5) AND Reasoning Models (e.g., Claude Opus 4.7, OpenAI o1/o3).

**Do NOT branch logic based on LLM identity (No `If Target LLM == Reasoning`).** Treat the target LLM as an adaptive reasoning engine and use the following three pillars:

## 1. Literal Framing (Definition of Done)
Modern models (especially Opus 4.7) do not silently generalize. If it is not explicitly required, the model assumes it is not needed.
*   **Avoid Fluff:** Never write things like "Do an excellent job" or "Avoid mistakes".
*   **Positive Boundaries over Negative Taboos:** Instead of telling the model what NOT to do ("Do NOT include a summary"), define the absolute boundary of what MUST be done ("Your output must end immediately after the table. Only output the table").
*   **Exact Criteria:** "Deliver exactly {X} in format {Y}".

## 2. Depth Signals instead of Explicit CoT-Scaffolding
Never instruct models to "think step by step" or to write out a `<scratchpad>`.
*   Standard models don't necessarily need it for most tasks, and Reasoning models actively suffer from it because you are creating a redundant, slow feedback loop that bypasses their internal cognitive engine.
*   **The Model-Agnostic Solution:** Trigger deep thinking via linguistic "Depth-Signals".
    *   *Bad:* "Before completing the code, use a `<scratchpad>` to think step-by-step how to resolve the dependency loop."
    *   *Good (Depth-Signal):* "Analyze the dependency patterns systematically and evaluate edge cases before implementing the solution." -> This allows standard models to write a plan, and reasoning models to adaptively scale up their internal token allocation.

## 3. Constraint-Checks instead of Recursive Loops
Self-correction remains a valid pattern, but it must be formatted as an explicit validation gate at the very end of a workflow, rather than a muddy "re-evaluate your thoughts" loop.
*   *Bad (Thought-Loop):* "Double check if you missed a taboo, then re-think your approach."
*   *Good (Constraint-Check):* "Step 5: Prior to output, strictly validate your final artifact against Constraint X. If it violates the constraint, discard and regenerate." 
