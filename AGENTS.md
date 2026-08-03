# Dowe Project Agent

This project uses Dowe Source Format. Dowe compiles declarative `.dowe` source through its shared
Rust compiler and runtime contracts.

## Start

1. Read `main.dowe` and the imported files that own the requested surface.
2. Select one installed skill under `.agents/skills`: `dowe-core` for root structure,
   `dowe-server` for server modules, `dowe-views` for view modules, or `dowe-theme` for `theme.dowe`.
3. Open its `SKILL.md`, then only the reference named for the current task.
4. Add a second skill or reference only when the request crosses that ownership boundary.
5. Treat compiler diagnostics as the final syntax and prop authority.

## Spec-Driven Development

When the task selects or changes a project behavior contract, follow Spec -> Contract -> Tests ->
Implementation -> Validation -> Documentation. Copy, local styling, and structure-preserving source
edits do not require a Harness plan unless the project declares one.

The Agent Harness under `.agents` owns plans and TDD state. Use its commands when a change needs a
plan, status, check, or validation evidence.

## CodeGraph And Validation

- Use CodeGraph when ownership, dependencies, modularity, or duplication are part of the change.
- Persist CodeGraph or Harness evidence only when declared validation requires it.
- Keep native Dowe tests in any project directory and run `dowe test [path ...]` for supported
  literal assertions.
- Keep server, views, desktop, Android, and iOS behavior unified through Dowe source.

## Boundaries

- Do not edit generated `.dowe` artifacts as source.
- Do not read or expose `.env` values, credentials, or private workspace instructions.
- Do not use private Dowe implementation skills when authoring this project.
- Keep server-only bindings and secrets out of views and generated client data.
