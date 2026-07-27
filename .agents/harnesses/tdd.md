# TDD Harness

## Purpose

This harness guides implementation work through Test-Driven Development.

## Flow

1. Select a spec.
2. Identify contracts.
3. Derive acceptance criteria.
4. Write or update tests before implementation.
5. Record the expected initial failure when practical.
6. Implement the behavior.
7. Run relevant tests, including `dowe test [path ...]` for native Dowe literal tests.
8. Run declared validation.
9. Update documentation when behavior changes.
10. Review and update applicable skills when the implementation changes a reusable workflow.
11. Keep validation evidence under `.dowe/agent-harnesses`.

## Blocking Rules

- Do not implement without a selected spec.
- Do not implement without a test plan.
- Do not close an implementation at `validated` when documentation is still required.
- Do not skip skill review when the change modifies a reusable workflow.
- Do not treat post-implementation validation as TDD.
- Do not write project harness support outside `.agents`.
