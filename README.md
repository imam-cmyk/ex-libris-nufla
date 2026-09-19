# Ex Libris Nufla

Nufla's book collection, catalogued — a single self-contained HTML page.

**Live:** https://imam-cmyk.github.io/ex-libris-nufla/

An *ex libris* is the bookplate a reader pastes inside a front cover: *from the books of…*. This is hers, for a whole shelf at once.

## What it does

- **Four views** — Shelf (generated covers), Spines (books standing on shelf boards, width following page count), Catalogue (sortable table), Insights (genre donut, status, ratings, top authors, books finished per month, shelf fill).
- **Full record per book** — title, author, series and number, genre, status, rating, pages, page read to, format, language, year, publisher, ISBN, shelf location, tags, lent-to, a favourite line, notes, spine colour.
- **Find things** — search across every field, filter by genre, status, language, shelf, format, tag, rating, favourites, lent-out and series, nine sort orders.
- **Reading** — progress slider that promotes a book to Reading and then to Read, a yearly reading goal, a lending tracker, a "surprise me" picker.
- **Housekeeping** — bulk select with bulk status/tag/delete, duplicate finder, CSV import, CSV and JSON export, undo on delete.
- **The bookplate** — greets her by name and by time of day; the dedication under her name is editable (click it).
- **Opening a book** — the cover lifts off the shelf and flies into place, the panel arrives behind it and the details settle in one after another; closing sends it back to the slot it came from. Works from the cover grid and from a spine, where a narrow spine widening into a jacket reads as the book turning to face you.
- **Needs checking** — titles read off a blurry spine are marked, collected under one sidebar shortcut, and can be confirmed or corrected in a click.
- Light and dark themes, keyboard shortcuts (`/`, `n`, `r`, `1`–`4`, `t`), and `prefers-reduced-motion` respected.

## Where the data lives

The starting catalogue of 117 books is embedded in `index.html`. Everything changed after that is saved in the browser's `localStorage`, on that browser and that device only.

To move a library between machines: **Library tools → Export CSV**, then **Import CSV** on the other one. **Library tools → Restore the original catalogue** puts back the embedded 117.

No accounts, no server, no network calls except the Google Fonts stylesheet.

## Covers

100 of the 117 books have their real jacket in `covers/`, resized to 400px wide and committed to the repo so the site stays self-contained — no hotlinking, nothing to go stale.

They came from three places, because no single catalogue has them all:

- **Open Library** for most of the English books, matched on title *and* author. Its Nancy Drew records are filed under Leslie McFarlane rather than Carolyn Keene, so those are matched on title alone, with omnibus editions rejected — their jacket shows the wrong book.
- **kbooks.lk and grantha.lk** for the Sinhala books, which Open Library does not carry at all. The shop listings also settled what several of them are actually called.
- **Image search** for three stragglers no catalogue had.

Each of those books takes its **spine colour from its own jacket**: the artwork is reduced to 8×8, the most frequent chromatic bucket wins, and that colour is nudged into a lightness band where white spine lettering stays readable. So the Spines view is close to the real shelf.

The remaining 17 are books no source could confirm, plus the spines that were simply unreadable in the photographs. They fall back to a drawn cover in their genre colour. The page always builds the drawn cover first and fades a real jacket in over it, so a missing or slow image is never an empty rectangle.

Cover matching also filled in real publication years and page counts, which is what gives the Spines view its varying widths.

## Editing

`src/page.html` is the source: markup, styles and script in one file. `index.html` is generated from it.

```sh
sh build.sh src/page.html   # wraps src/page.html in the document head and writes index.html
```

- The catalogue is the `SEED` array in the script: one row per book, columns `[title, author, genre, shelf, series, seriesNo, tags, language, cover, color, year, pages]`. `cover` is a filename stem in `covers/`; `color` is the spine hex, and an empty one falls back to the genre colour. Genre ids are `crime`, `romance`, `fantasy`, `mystery`, `sinhala`, `children`, `ya`, `nonfic`, `other`.
- The name on the plate is `OWNER`, and the default dedication is `DEFAULT_DED`, both near the top of the render section.
- A saved library lives in each visitor's `localStorage` and will not pick up new `SEED` facts by itself. **Bump `SEED_VERSION` whenever `SEED` gains fields**: `migrateSeed()` then fills only empty fields on books whose id and title still match. Corrections to facts that were previously *wrong* go in the `FIXES` table as `[id, field, oldValue, newValue]` — `applyFixes()` writes them only where the saved value is still the old one, so nothing she has edited herself is overwritten.
- Genre colours are the `--c1`–`--c9` tokens, defined for light and dark and checked for colour-blind separation.

## Deploying

GitHub Pages serves `main` from the repository root. Push to `main` and the site updates in about half a minute.
