# Project workflow

## Small source changes

1. Inspect the owning declaration and every imported binding it uses.
2. Make the smallest source edit with current Dowe syntax.
3. Run the narrowest compiler or target validation.
4. Fix source from the diagnostic; never patch generated `.dowe` output.

## Behavior changes

Use Spec -> Contract -> Tests -> Implementation -> Validation -> Documentation. The project Agent
Harness stores editable plans under `.agents` and generated evidence under
`.dowe/agent-harnesses`. Use its plan, check, status, and validation commands only when the change
needs that workflow.

CodeGraph explains ownership, size, dependencies, and duplication. Use compact context for
orientation and `dowe codegraph check` for declared structural validation. CodeGraph output under
`.dowe/codegraph` is generated evidence; it cannot override a spec or compiler contract.

## Validation choices

| Need | Command family |
| --- | --- |
| Compile or run the project | `dowe dev` or the requested build command |
| Literal source assertions | `dowe test [path ...]` |
| Validate project agent state | Use the Agent Harness check configured under `.agents` |
| Validate a planned feature | Use the selected Harness plan and its declared validation |
| Validate structure | `dowe codegraph check` |

Do not start watchers unless the task needs an active development session. Do not read `.env`
values, serialize server-only bindings into views, or expose Database, KV, HTTP provider, crypto, or
spawn handles to client targets.
