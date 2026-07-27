---
name: dowe-server
description: Author Dowe APIs, endpoint groups, handlers, middleware, server functions, providers, services, repositories, tasks, spawn, HTTP, crypto, Database, Cache, Vector, and responses.
---

# Dowe server authoring

Server source is compiled into Rust-owned runtime behavior. Keep routes, input validation, data access and responses explicit.
Keep every new backend module under `server/`; only root `main.dowe` connects it to the application.

## Workflow

1. Inspect the `server` block and imported `endpoints` binding.
2. Keep HTTP boundaries in handlers and middleware. Write `handler <name>` without `async`; request
   context and asynchronous execution are implicit.
3. Put reusable `fn` declarations under the matching `server` responsibility folder and use folder
   names to express provider, service, repository, task, or utility ownership. When the same
   domain spans layers, include the responsibility in the filename, such as
   `blogs-handler.dowe`, `blogs-service.dowe`, and `blogs-repository.dowe`.
4. Put Database, Cache, and Vector work in repository functions and reuse imported config connection declarations.
5. Keep external providers, secrets, process handles, and persistence server-only.
6. Prefer opaque ULID sessions with Cache-aside validation and Database fallback when the application needs immediate revocation; Bearer does not imply JWT.
7. Return only explicit JSON, text, bytes, proxy, or Agent responses. Handlers and
   middleware use `return <props>` directly; static routes use `response <props>`.
8. Keep endpoint groups one level; put middleware on the group, HTTP method, or WebSocket instead
   of nesting a group.
9. Validate the complete import chain with the compiler.

Read `references/server.md` for declarations, binding rules, accepted props, scope restrictions,
Database, Cache, Vector, and their operation utilities, plus the canonical layer boundaries.
