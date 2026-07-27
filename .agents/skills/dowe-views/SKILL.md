---
name: dowe-views
description: Author Dowe route graphs, Scaffold layouts, Section pages, init hooks, Splash boundaries, components, View Stores, signals, view functions, requests, responsive UI, forms, navigation, Canvas, web, desktop, Android, and iOS.
---

# Dowe views authoring

Dowe views are target-neutral source compiled to web, desktop, Android, and iOS outputs. Reuse one route graph and one source behavior model across targets.
Keep every new frontend module under `views/`; only root `main.dowe` and `theme.dowe` sit outside it.

## Workflow

1. Find the imported `views` binding connected by `main.dowe`.
2. Put exactly one normal `Scaffold` root in every layout; add one direct `Splash` sibling only when startup replacement content is required.
3. Start every page with `Section` and use ordered sibling Sections for major page bands.
4. Use `Grid` for tracks, `Flex` for one-axis flow, `Card` for grouped content, and `Box` only for a special neutral wrapper.
5. Prefer component defaults from `theme.dowe`; add local visual props only for intentional exceptions.
6. Use Signals and View Stores for state, `fn` for event workflows, and one `init` for ordered mount-time work.
7. Write static visible text as `"Blog title"` and dynamic visible text as one complete braced
   binding such as `"{blog.title}"`.
8. Keep route groups one level: every `group` contains direct `route` declarations, never another
   `group`.
9. Use `store name:` with one indented prop per line when Store props would make one long line.
10. Validate bindings, component props, text children, routes, and target support with Dowe diagnostics.

Read `references/views.md` for route, layout, page, state, function, request, and UI/UX contracts.
Read `references/components.md` when selecting a built-in component or checking its essential data,
binding, child, interaction, and portability contract.
