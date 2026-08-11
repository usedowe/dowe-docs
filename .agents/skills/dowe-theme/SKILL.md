---
name: dowe-theme
description: Use only for root theme.dowe, semantic colors, tonal surface hierarchy, theme inheritance, fonts, project-wide component defaults, or extracting a repeated visual system for a modern interface from a screenshot, template, or UI reference; skip for one-off local view styling.
---

# Dowe theme authoring

Keep theme behavior in root `theme.dowe` and use semantic Dowe tokens from views. Preserve cross-platform meaning instead of targeting CSS-only behavior.

## Workflow

1. Inspect `theme.dowe` before changing component visual props in views.
2. Put repeated Card, Button, Avatar, Chip, control, Text font, and Title font defaults under `design`.
3. For reference-driven work, inventory recurring color families, foreground/background pairs,
   typography, radii, borders, shadows, glow usage, and surface hierarchy before choosing tokens or
   defaults. Do not turn every sampled or anti-aliased shade into a token.
4. Use semantic colors and complete the base theme before adding inherited themes.
5. Give modern dark interfaces distinct canvas, surface, quiet-surface, and accent roles. Do not
   assign nearly identical dark values to every family or make every Card use the brand color.
6. Choose defaults that establish a quiet baseline. Reserve stronger borders, shadows, glows,
   covers, transforms, and motion for intentional focal instances in views.
7. Keep local component visual props only when one instance intentionally differs.
8. Treat `design` as the source of repeated visual policy. View generation must omit component
   props already supplied by `design` or by the built-in component contract; emit only local
   exceptions, reactive bindings, layout/behavior props, and required content or accessibility.
9. Validate contrast, completeness, font tokens, surface separation, and target support.
10. Use Dowe semantic names and the closed Dowe font token catalog, matched by typographic
   character when the reference family is unavailable.

## Reference routing

Read `references/theme.md` only when the task changes `theme.dowe`, semantic colors, inheritance,
fonts, component-default precedence, or the repeated visual system extracted from a UI reference.
