/* =============================================================================
   Tokgoez Dialogues — front-end behaviour (no dependencies)
   Modules self-activate only when their markup is present.
   ========================================================================== */
(() => {
  "use strict";
  const TD = window.TD || {};
  const $  = (s, r = document) => r.querySelector(s);
  const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
  let clearTagFilters = null; // wired up by the tag-filter module, used by the `clear` command

  /* ── Theme toggle ──────────────────────────────────────────────────────── */
  // (Initial theme is applied pre-paint by an inline script in <head>.)
  const Theme = {
    get() {
      return document.documentElement.dataset.theme ||
        (matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark");
    },
    set(t) {
      document.documentElement.dataset.theme = t;
      try { localStorage.setItem("td-theme", t); } catch (_) {}
      const btn = $("#theme-toggle");
      if (btn) {
        btn.querySelector(".txt") && (btn.querySelector(".txt").textContent = t === "dark" ? "dark" : "light");
        btn.setAttribute("aria-label", `Switch to ${t === "dark" ? "light" : "dark"} theme`);
      }
    },
    toggle() { this.set(this.get() === "dark" ? "light" : "dark"); },
  };
  const themeBtn = $("#theme-toggle");
  if (themeBtn) {
    Theme.set(Theme.get());
    themeBtn.addEventListener("click", () => Theme.toggle());
  }

  /* ── Reading progress (posts only) ─────────────────────────────────────── */
  const bar = $(".progress");
  const article = $("[data-article]");
  if (bar && article) {
    const update = () => {
      const start = article.offsetTop;
      const total = article.offsetHeight - innerHeight;
      const seen = Math.min(Math.max(scrollY - start, 0), Math.max(total, 1));
      bar.style.width = (total > 0 ? (seen / total) * 100 : 0) + "%";
    };
    addEventListener("scroll", update, { passive: true });
    addEventListener("resize", update, { passive: true });
    update();
  }

  /* ── Provenance tabs (posts) ───────────────────────────────────────────── */
  const tablist = $(".tablist");
  if (tablist) {
    const tabs = $$(".tab", tablist);
    const panels = tabs.map((t) => document.getElementById(t.getAttribute("aria-controls")));
    const select = (i, focus = true) => {
      tabs.forEach((t, j) => {
        const on = i === j;
        t.setAttribute("aria-selected", on);
        t.tabIndex = on ? 0 : -1;
        if (panels[j]) { panels[j].classList.toggle("active", on); panels[j].hidden = !on; }
        if (on && focus) t.focus();
      });
      const kind = tabs[i].dataset.kind;
      if (kind) history.replaceState(null, "", "#" + kind);
    };
    tabs.forEach((t, i) => {
      t.addEventListener("click", () => select(i, false));
      t.addEventListener("keydown", (e) => {
        const last = tabs.length - 1;
        let n = null;
        if (e.key === "ArrowRight" || e.key === "ArrowDown") n = i === last ? 0 : i + 1;
        else if (e.key === "ArrowLeft" || e.key === "ArrowUp") n = i === 0 ? last : i - 1;
        else if (e.key === "Home") n = 0;
        else if (e.key === "End") n = last;
        if (n !== null) { e.preventDefault(); select(n); }
      });
    });
    // Deep-link: #prompt / #walk / #output
    const want = location.hash.replace("#", "");
    const idx = tabs.findIndex((t) => t.dataset.kind === want);
    select(idx >= 0 ? idx : 0, false);
  }

  /* ── Tag filter (home) ─────────────────────────────────────────────────── */
  const tagbar = $("#tag-filter");
  const listing = $("#listing");
  if (tagbar && listing) {
    const entries = $$(".entry", listing);
    const status = $("#filter-status");
    const empty = $("#listing-empty");
    const active = new Set();

    const apply = () => {
      let shown = 0;
      entries.forEach((el) => {
        const tags = (el.dataset.tags || "").split("|").filter(Boolean);
        const ok = active.size === 0 || [...active].every((t) => tags.includes(t));
        el.style.display = ok ? "" : "none";
        if (ok) shown++;
      });
      empty && empty.classList.toggle("show", shown === 0);
      if (status) {
        if (active.size === 0) {
          status.textContent = `${entries.length} ${entries.length === 1 ? "entry" : "entries"}`;
        } else {
          status.innerHTML =
            `grep <span style="color:var(--magenta)">${[...active].map((t) => "#" + t).join(" ")}</span> → ` +
            `${shown} match${shown === 1 ? "" : "es"} · ` +
            `<a id="clear-tags" tabindex="0" role="button">clear</a>`;
          $("#clear-tags").addEventListener("click", clearAll);
        }
      }
    };
    const clearAll = () => {
      active.clear();
      $$(".tag", tagbar).forEach((b) => b.setAttribute("aria-pressed", "false"));
      apply();
    };
    clearTagFilters = clearAll; // expose to the `clear` palette command
    $$(".tag", tagbar).forEach((btn) => {
      btn.addEventListener("click", () => {
        const t = btn.dataset.tag;
        if (active.has(t)) { active.delete(t); btn.setAttribute("aria-pressed", "false"); }
        else { active.add(t); btn.setAttribute("aria-pressed", "true"); }
        apply();
      });
    });
    apply();
  }

  /* ── Command palette (Ctrl+K) ──────────────────────────────────────────── */
  const backdrop = $("#palette");
  if (backdrop) {
    const input = $(".palette-input input", backdrop);
    const results = $(".palette-results", backdrop);
    const status = $("#palette-status", backdrop);
    let posts = null;     // lazy-loaded
    let items = [];       // current filtered list
    let cursor = 0;
    let loaded = false;
    let priorFocus = null; // element focus returns to on close

    // A small but real shell. `keys` feeds fuzzy matching (aliases); `run`
    // returns truthy to keep the palette open, falsy/undefined to close it.
    const commands = [
      { name: "help",   ico: "?", desc: "list available commands",     keys: "help man commands ?",          run: showHelp },
      { name: "ls",     ico: "›", desc: "list all entries (home)",     keys: "ls list home posts cd ~",      run: () => go(TD.home || "/") },
      { name: "about",  ico: "i", desc: "who I am / the method",       keys: "about whoami me",              run: () => go(TD.about) },
      { name: "theme",  ico: "◐", desc: "toggle dark / light",         keys: "theme dark light mode",        run: () => { Theme.toggle(); return true; } },
      { name: "feed",   ico: "⤓", desc: "subscribe (Atom feed)",       keys: "feed rss atom subscribe",      run: () => go(TD.feed) },
      { name: "random", ico: "⚄", desc: "open a random entry",         keys: "random lucky shuf",            run: randomPost },
      { name: "clear",  ico: "⌫", desc: "clear tag filters",           keys: "clear reset cls",              run: () => { if (clearTagFilters) clearTagFilters(); } },
      { name: "top",    ico: "↑", desc: "scroll to top",               keys: "top gg scroll",                run: () => { scrollTo({ top: 0, behavior: "smooth" }); } },
      { name: "source", ico: "", desc: "view the source on GitHub",   keys: "source src github repo code",  run: () => go(TD.repo) },
    ];

    function go(url) {
      if (!url) return;
      // allow only relative paths or http(s) URLs (blocks javascript:/data: schemes)
      if (/^https?:\/\//i.test(url) || url.startsWith("/") || url.startsWith("#")) location.href = url;
    }
    function randomPost() {
      if (!posts || !posts.length) return true;
      const p = posts[Math.floor(Math.random() * posts.length)];
      go(p.url);
    }
    function showHelp() {
      items = []; cursor = 0;
      const cmds = commands.map((c) =>
        `<div class="help-row"><span class="help-cmd">${esc(c.name)}</span><span class="help-desc">${esc(c.desc)}</span></div>`).join("");
      results.innerHTML =
        `<div class="palette-group">commands</div>${cmds}` +
        `<div class="palette-group">keys</div>` +
        `<div class="help-row"><span class="help-cmd">Ctrl K&nbsp;/&nbsp;&#47;</span><span class="help-desc">open or close this palette</span></div>` +
        `<div class="help-row"><span class="help-cmd">↑ ↓</span><span class="help-desc">move selection</span></div>` +
        `<div class="help-row"><span class="help-cmd">↵</span><span class="help-desc">run the selected item</span></div>` +
        `<div class="help-row"><span class="help-cmd">← →</span><span class="help-desc">switch tabs on a post (output / prompt / walk)</span></div>` +
        `<div class="help-row"><span class="help-cmd">esc</span><span class="help-desc">close</span></div>` +
        `<div class="palette-empty" style="text-align:left;padding:0.8rem 0.7rem 0.2rem">…or just type to search every entry by title or tag.</div>`;
      if (status) status.textContent = "showing help";
      input.setAttribute("aria-activedescendant", "");
      return true; // keep palette open
    }

    async function ensurePosts() {
      if (loaded || !TD.searchUrl) return;
      loaded = true;
      try {
        const r = await fetch(TD.searchUrl);
        posts = await r.json();
      } catch (_) { posts = []; }
    }

    // subsequence fuzzy score: lower is better, null = no match
    function score(q, text) {
      if (!q) return 0;
      text = text.toLowerCase();
      let ti = 0, last = -1, gaps = 0;
      for (const ch of q) {
        const found = text.indexOf(ch, ti);
        if (found === -1) return null;
        if (last >= 0) gaps += found - last - 1;
        last = found; ti = found + 1;
      }
      return gaps + last * 0.05;
    }

    function render(q) {
      const query = q.trim().toLowerCase();
      const cmdHits = commands
        .map((c) => ({ c, s: score(query, c.name + " " + c.desc + " " + c.keys) }))
        .filter((x) => x.s !== null)
        .sort((a, b) => a.s - b.s)
        .map((x) => x.c);

      const postHits = (posts || [])
        .map((p) => ({ p, s: score(query, p.title + " " + (p.tags || []).join(" ")) }))
        .filter((x) => x.s !== null)
        .sort((a, b) => a.s - b.s)
        .slice(0, 8)
        .map((x) => x.p);

      items = [];
      let html = "";
      if (cmdHits.length) {
        html += `<div class="palette-group">commands</div>`;
        cmdHits.forEach((c) => {
          const i = items.push({ kind: "cmd", data: c }) - 1;
          html += row(i, c.ico, c.name + " — " + c.desc, c.name);
        });
      }
      if (postHits.length) {
        html += `<div class="palette-group">entries</div>`;
        postHits.forEach((p) => {
          const i = items.push({ kind: "post", data: p }) - 1;
          html += row(i, "▸", p.title, p.date || "");
        });
      }
      results.innerHTML = items.length
        ? html
        : `<div class="palette-empty">no matches for “${esc(q)}”. try <b>help</b>, <b>theme</b>, <b>random</b>.</div>`;
      if (status) status.textContent = items.length
        ? `${items.length} result${items.length === 1 ? "" : "s"}`
        : "no matches";
      cursor = 0;
      paint();
      $$(".palette-item", results).forEach((el, i) => {
        el.addEventListener("click", () => activate(i));
        el.addEventListener("mousemove", () => { cursor = i; paint(); });
      });
    }
    function row(i, ico, label, hint) {
      return `<div class="palette-item" id="palette-item-${i}" role="option" data-i="${i}">
        <span class="ico" aria-hidden="true">${esc(ico)}</span><span class="label">${esc(label)}</span><span class="hint">${esc(hint)}</span></div>`;
    }
    function esc(s) { return String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c])); }
    function paint() {
      $$(".palette-item", results).forEach((el, i) =>
        el.setAttribute("aria-selected", i === cursor));
      const el = results.querySelector(`[data-i="${cursor}"]`);
      input.setAttribute("aria-activedescendant", el ? `palette-item-${cursor}` : "");
      el && el.scrollIntoView({ block: "nearest" });
    }
    function activate(i) {
      const it = items[i];
      if (!it) return;
      if (it.kind === "cmd") { const keep = it.data.run(); if (keep) return; close(); }
      else go(it.data.url);
    }

    async function open() {
      priorFocus = document.activeElement;
      backdrop.classList.add("open");
      backdrop.setAttribute("aria-hidden", "false");
      input.setAttribute("aria-expanded", "true");
      input.value = "";
      await ensurePosts();
      render("");
      input.focus();
    }
    function close() {
      backdrop.classList.remove("open");
      backdrop.setAttribute("aria-hidden", "true");
      input.setAttribute("aria-expanded", "false");
      input.setAttribute("aria-activedescendant", "");
      if (priorFocus && typeof priorFocus.focus === "function") priorFocus.focus();
    }

    input.addEventListener("input", () => render(input.value));
    backdrop.addEventListener("mousedown", (e) => { if (e.target === backdrop) close(); });
    backdrop.addEventListener("keydown", (e) => {
      if (e.key === "Escape") { close(); }
      else if (e.key === "ArrowDown") { e.preventDefault(); cursor = Math.min(cursor + 1, items.length - 1); paint(); }
      else if (e.key === "ArrowUp")   { e.preventDefault(); cursor = Math.max(cursor - 1, 0); paint(); }
      else if (e.key === "Enter")     { e.preventDefault(); activate(cursor); }
      else if (e.key === "Tab")       { e.preventDefault(); input.focus(); } // trap focus (nav via arrows)
    });

    addEventListener("keydown", (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "k") { e.preventDefault(); backdrop.classList.contains("open") ? close() : open(); }
      else if (e.key === "/" && !/^(INPUT|TEXTAREA)$/.test(document.activeElement.tagName) && !backdrop.classList.contains("open")) {
        e.preventDefault(); open();
      }
    });
    $$("[data-open-palette]").forEach((b) => b.addEventListener("click", open));
  }
})();
