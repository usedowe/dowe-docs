# Dowe Project Agents

This project uses Dowe Agent Harnesses.

## Required Reading

1. Read the project-root `AGENTS.md`.
2. Read this file.
3. Read `.agents/manifest.json`.
4. Read the relevant installed skill under `.agents/skills`.
5. Read the applicable harness under `.agents/harnesses`.
6. Read the selected project spec before implementation.
7. Follow Spec -> Contract -> Tests -> Implementation -> Validation -> Documentation.

## Modes

- Project-specific agent support lives under `.agents`.
- Generated validation evidence lives under `.dowe/agent-harnesses`.
- Dowe framework agent instructions live in Dowe's `/agents` directory and must not be edited from project harness commands.

## TDD

TDD means Test-Driven Development.

Implementation work must start from a spec, derive tests before implementation, record the expected failure when practical, implement the smallest behavior that satisfies the tests, then validate, update documentation, and review applicable skills before closing.

Native Dowe literal tests can live in any project directory. Run `dowe test [path ...]` for the selected test file or directory when the contract is covered by `test` and `assert` declarations.
