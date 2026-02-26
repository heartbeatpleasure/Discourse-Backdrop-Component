# Side Backdrop (Margin) – Discourse Theme Component

This theme component shows a decorative “backdrop” **in the left/right page margins** (outside the main Discourse layout),
only when there is enough horizontal space (so it stays hidden on mobile / narrow screens).

## How it works (short)
- Two fixed panels are injected into the page:
  - `.tc-backdrop--left`
  - `.tc-backdrop--right`
- JavaScript measures the **visual site edge** using `#main-outlet-wrapper` (fallbacks included) and calculates how much free space
  exists on each side.
- If the viewport is wide enough and there is sufficient side space, the component sets CSS variables for the panel widths and
  adds `tc-backdrop-enabled` to `<html>`.

## Image modes
You can choose how the backdrops are sourced:

1. **Pattern mode (`pattern`)**
   - Uses a preset SVG pattern shipped with this component (`backdrop_preset`).

2. **Full mode (`full`)**
   - Upload **one** image and it will be used on **both** sides (`custom_backdrop_image`).

3. **Split mode (`split`)**
   - Upload a **left** image and a **right** image (`custom_backdrop_image_left/right`).
   - If you only upload one side, the other side will automatically fall back to it (to avoid an accidental blank side).

## Key settings
- `min_viewport_width`: below this width nothing is shown
- `min_side_space`: minimum free side space (per side) required to display a panel
- `max_side_width`: maximum panel width
- `gap_from_site_left/right`: optional “padding” (px) between the site edge and the artwork (set both to 0 for a flush look)
- Styling: `opacity`, `repeat`, `size`, `position_y`, `mirror_right`

## Adding new presets
1. Add a file under `assets/`
2. Add it to `about.json` under `assets`
3. Add the new choice to `settings.yml` (`backdrop_preset`)
4. Extend the mapping in `common/common.scss`
