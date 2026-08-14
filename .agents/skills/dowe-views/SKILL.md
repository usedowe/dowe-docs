---
name: dowe-views
description: Use for Dowe view modules, routes, layouts, pages, UI composition, components, state, requests, responsive styles, Canvas, view targets, modern product or marketing visual direction, layered scenes, or exact and adapted reconstruction from an attached screenshot, mockup, template, or UI reference, including semantic component selection, shell/page ownership, reusable static fragments, and repeated collections rendered with each; skip for server-only work.
---

# Dowe views authoring

Dowe views are target-neutral source compiled to web, desktop, Android, and iOS outputs. Reuse one route graph and one source behavior model across targets.
Keep every new frontend module under `views/`; only root `main.dowe` and `theme.dowe` sit outside it.

## Workflow

1. Find the imported `views` binding connected by `main.dowe`, inspect the route graph, and read
   `theme.dowe`.
2. For reference-driven work, follow `references/reference-ui.md`: initialize the required
   `.dowe/visual-qa/<screen>/blueprint.json`, then inventory the reference viewport and record a
   composition map with ordered bands, region ownership, exact built-ins, collection owners,
   responsive evidence, states, accessibility, theme decisions, assets, and reusable-component
   candidates before authoring source.
   For block-driven work based on Dowe's documented UI patterns, read
   `references/blocks/index.json` first. Select at most five candidates, then combine one primary
   block with at most one supporting pattern; use the family composition rules and variant tags as
   design guidance, not as permission to copy documentation gallery wrappers.
3. Before writing source, state one visual-direction sentence and choose at most three recurring
   motifs from the evidence: for example orbital geometry, luminous data surfaces, editorial
   typography, translucent panels, or technical linework. Map each retained band to a distinct
   composition and visual payload; do not let the implementation default to repeated headings over
   uniform Card grids.
4. Decide whether the request is an exact reconstruction or a directed adaptation. Exact work
   preserves every visible band and measured relationship. Adaptation may change copy or omit
   content only as requested, while preserving the reference's visual density, depth, focal
   hierarchy, asset intent, and characteristic details in every retained band.
5. Keep reference evidence distinct from inference. Preserve visible copy, geometry, hierarchy,
   density, layered depth, and media intent; infer only behavior the supplied viewport cannot show.
   When the reference shows a scene made from background, focal media, floating proof, ornament,
   and foreground, record and rebuild those as separate Dowe layers rather than collapsing them to
   one Image or Card.
6. Resolve UI roles against `references/components.md`. Prefer the semantic built-in that owns the
   behavior, use contextual children only under their declared owner, and never invent a component
   name from a label in the reference.
7. Rebuild every UI-shaped region with Dowe components. Never use the reference image or crops
   derived from it as assets. Use `Image` only for independently obtained photographs,
   illustrations, textures, or authentic screenshots explicitly supplied or requested by the user.
8. Create or reuse a layout whenever the reference has shared chrome. AppBar and Footer never
   belong in a page, and a one-page site still uses a layout-backed route group.
9. Put exactly one normal `Scaffold` root in every layout; add one direct `Splash` sibling only when
   startup replacement content is required.
10. Start every page with `Section` and use ordered sibling Sections for major page bands. Give
   every landing-page band one job, and make the hero establish the primary promise, support,
   action, and proof before later Sections add detail. Preserve visible copy, band order, actions,
   density, and media intent instead of inventing generic replacements.
11. Use `Grid` for tracks, `Flex` for one-axis flow, `Card` for grouped content, and `Box` only for
   a special neutral wrapper; when unsure, composing a hero or landing page, or working from a
   reference design, follow the decision tree and dedicated patterns in
   `references/composition.md`.
12. Give every substantial marketing band a visual payload beyond title and body copy: original
    media, a data visual, product UI, icon composition, logo field, testimonial, process diagram,
    or layered proof surface. Add a restrained detail pass with supported covers, overlays,
    positioning, transforms, shadows, borders, motion, and tonal contrast from
    `references/styles.md`; decoration must reinforce the concept rather than fill empty space.
13. Model repeated same-shape UI once: use a `const` for immutable reference-defined content, a
    typed `signal` for a page collection refreshed or replaced by requests or local workflows, and
    an imported View Store only for state shared across routes. Render one unit with
    `each in:<collection> as:<item> key:<item-path>`; never copy sibling Cards or list units.
14. Extract a static fragment reused in two or more places, such as a logo or a navigation tree
    mounted in both Sidebar and Drawer, into a `component` under `views/components`; keep signals,
    functions, caller bindings, and data-bound `each` templates in the owning layout or page because
    reusable components are static and accept no invented props or slots.
15. Prefer component defaults from `theme.dowe`; add local visual props only for intentional
    exceptions.
16. Generate the smallest valid component declaration. Omit built-in and theme-resolved visual
    defaults instead of serializing them: `Button "Log in"` is preferred to
    `Button variant:"solid" scheme:"primary" size:"md"`, and `Input bind:email label:"Email"`
    is preferred to repeating `variant:"outlined" scheme:"primary"`. Keep a prop only when it is
    a non-default design decision, a reactive binding, required content or accessibility metadata,
    layout or behavior, or the example is explicitly comparing that prop. This rule applies to
    generated source, documentation examples, and reusable view fragments; use `theme.dowe` for
    repeated visual policy rather than copying the same values into every instance. See
    `references/styles.md` for the current default matrix and minimal-prop examples.
17. Use Signals and View Stores for state, `fn` for event workflows, and one `init` for ordered
    mount-time work.
18. Write static visible text as `"Blog title"` and dynamic visible text as one complete braced
   binding such as `"{blog.title}"`.
19. Keep route groups one level: every `group` contains direct `route` declarations, never another
   `group`.
20. Use `store name:` with one indented prop per line when Store props would make one long line.
21. Validate bindings, component props, text children, routes, and target support with Dowe
    diagnostics.
22. Review the rendered page at `xs`, `md`, and the reference viewport. Audit focal hierarchy,
    section-to-section rhythm, visible layering, Card variety, text measure, asset quality, and
    interaction states before accepting a technically valid layout.
23. For reference-driven work, run the installed `scripts/visual_qa.py` entrypoint at the exact
    viewport. Inspect its band report and diff, then iterate on geometry, line wrapping, spacing,
    density, states, layers, and assets before finishing. For directed adaptations, use the report
    to inspect retained bands and document intentional structural deviations instead of weakening
    thresholds or claiming pixel parity. It imports `scripts/visual_qa_blueprint.py` and
    `scripts/visual_qa_png.py`; do not run the helpers directly.

## Resource routing

Open the primary resource first. Load another only when the task crosses its contract.

| Task | Primary resource |
| --- | --- |
| Routes, layouts, pages, state, functions, requests, repeated views, or i18n | `references/views.md` |
| Exact screenshot, mockup, or UI-reference reconstruction | `references/reference-ui.md` |
| Dowe documentation block patterns and variant selection | `references/blocks/index.json` |
| New screen, shell ownership, reusable fragments, container choice, hero, or landing composition | `references/composition.md` |
| Built-in component selection, children, bindings, interaction, or portability | `references/components.md` |
| Colors, variants, responsive props, typography, sizing, visibility, overlay, or motion | `references/styles.md` |
| Canvas drawing, input, animation, dynamic scenes, or limits | `references/canvas.md` |
| Deterministic reference capture and comparison | `scripts/visual_qa.py`, `scripts/visual_qa_blueprint.py`, `scripts/visual_qa_png.py` |
