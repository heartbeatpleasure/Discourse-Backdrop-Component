import { apiInitializer } from "discourse/lib/api";

function clamp(value, min, max) {
  return Math.min(max, Math.max(min, value));
}

function debounce(fn, wait = 100) {
  let t;
  return (...args) => {
    clearTimeout(t);
    t = setTimeout(() => fn(...args), wait);
  };
}

export default apiInitializer((api) => {
  const root = document.documentElement;

  const clear = () => {
    root.classList.remove("tc-backdrop-enabled");
    root.style.removeProperty("--tc-backdrop-left-width");
    root.style.removeProperty("--tc-backdrop-right-width");
  };

  const hasImage =
    settings.backdrop_preset !== "none" || Boolean(settings.custom_backdrop_image);

  if (!settings.enabled || !hasImage) {
    clear();
    return;
  }

  const minViewportWidth = parseInt(settings.min_viewport_width, 10) || 0;
  const minSideSpace = parseInt(settings.min_side_space, 10) || 0;
  const maxSideWidth = parseInt(settings.max_side_width, 10) || 99999;
  const gapLeft = parseInt(settings.gap_from_site_left, 10) || 0;
  const gapRight = parseInt(settings.gap_from_site_right, 10) || 0;

  const measure = () => {
    // Most accurate for your theme (from your DevTools screenshot)
    const preferred =
      document.querySelector("#main-outlet-wrapper") ||
      document.querySelector("#main-outlet");

    // Fallbacks
    const fallback =
      document.querySelector(".d-header-wrap .wrap") ||
      document.querySelector(".wrap");

    return (preferred || fallback);
  };

  const update = () => {
    if (window.innerWidth < minViewportWidth) {
      clear();
      return;
    }

    const el = measure();
    if (!el) {
      clear();
      return;
    }

    const rect = el.getBoundingClientRect();
    const vw = window.innerWidth;

    const leftGap = rect.left - gapLeft;
    const rightGap = (vw - rect.right) - gapRight;

    let leftW = clamp(leftGap, 0, maxSideWidth);
    let rightW = clamp(rightGap, 0, maxSideWidth);

    if (leftW < minSideSpace) leftW = 0;
    if (rightW < minSideSpace) rightW = 0;

    if (leftW === 0 && rightW === 0) {
      clear();
      return;
    }

    // Avoid sub-pixel jitter on very large screens / zoom factors
    leftW = Math.floor(leftW);
    rightW = Math.floor(rightW);

    root.classList.add("tc-backdrop-enabled");
    root.style.setProperty("--tc-backdrop-left-width", `${leftW}px`);
    root.style.setProperty("--tc-backdrop-right-width", `${rightW}px`);
  };

  const debouncedUpdate = debounce(update, 100);

  requestAnimationFrame(update);
  api.onPageChange(() => requestAnimationFrame(update));
  window.addEventListener("resize", debouncedUpdate, { passive: true });
});
