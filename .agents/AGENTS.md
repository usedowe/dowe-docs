# Dowe Project Agents

This directory owns optional project Harness configuration and generated plans.

## When Working With A Harness

1. Read the project-root `AGENTS.md`.
2. Read `.agents/manifest.json` and the applicable file under `.agents/harnesses`.
3. Read the selected project spec and its contracts.
4. Follow Spec -> Contract -> Tests -> Implementation -> Validation -> Documentation.

Installed authoring skills live under `.agents/skills`. Open only the skill and focused reference
required by the source surface being changed.

Project-specific agent support stays under `.agents`. Generated validation evidence stays under
`.dowe/agent-harnesses`.
