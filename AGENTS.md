# Dowe Project Agent

This project uses Dowe Source Format. Dowe compiles declarative `.dowe` source through Rust-owned
compiler and runtime contracts.

## Start

1. Read `main.dowe` and the imported files that own the requested surface.
2. Read one focused installed skill from `.agents/skills`: `dowe-core`, `dowe-server`, `dowe-views`,
   or `dowe-theme`.
3. Load only that skill's focused references.
4. Read `theme.dowe` before changing repeated visual props.
5. Treat compiler diagnostics as the final syntax and prop authority.

## Spec-Driven Development

For behavior changes, follow Spec -> Contract -> Tests -> Implementation -> Validation ->
Documentation. Select a project spec, derive tests first, record the expected failure when practical,
then implement the smallest compliant change.

The Agent Harness under `.agents` owns plans and TDD state. Use its commands when a change needs a
plan, status, check, or validation evidence. Do not require Harness ceremony for a simple source edit
that does not change behavior.

## CodeGraph And Validation

- Use CodeGraph for ownership, modularity, dependencies, and duplication checks.
- Persist CodeGraph or Harness evidence only when declared validation requires it.
- Keep native Dowe tests in any project directory and run `dowe test [path ...]` for supported
  literal assertions.
- Treat compiler diagnostics and shared Rust contracts as authoritative.
- Keep server, views, desktop, Android, and iOS behavior unified through Dowe source.

## Boundaries

- Do not edit generated `.dowe` artifacts as source.
- Do not read or expose `.env` values, credentials, or private workspace instructions.
- Do not add Node.js, `node_modules`, Tailwind, React, or browser-only runtime assumptions.
- Do not use private Dowe implementation skills when authoring this project.
- Keep server-only bindings and secrets out of views and generated client data.
