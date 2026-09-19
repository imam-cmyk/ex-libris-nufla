# The Spine Index

A catalogue of a personal book collection, as a single self-contained HTML page.

**Live:** https://imam-cmyk.github.io/spine-index/

## What it does

- **Four views** — Shelf (generated covers), Spines (books standing on shelf boards, width following page count), Catalogue (sortable table), Insights (genre donut, status, ratings, top authors, books finished per month, shelf fill).
- **Full record per book** — title, author, series and number, genre, status, rating, pages, page read to, format, language, year, publisher, ISBN, shelf location, tags, lent-to, a favourite line, notes, spine colour.
- **Find things** — search across every field, filter by genre, status, language, shelf, format, tag, rating, favourites, lent-out and series, nine sort orders.
- **Reading** — progress slider that promotes a book to Reading and then to Read, a yearly reading goal, a lending tracker, a "surprise me" picker.
- **Housekeeping** — bulk select with bulk status/tag/delete, duplicate finder, CSV import, CSV and JSON export, undo on delete.
- Light and dark themes, keyboard shortcuts (`/`, `n`, `r`, `1`–`4`, `t`), and `prefers-reduced-motion` respected.

## Where the data lives

The starting catalogue of 117 books is embedded in `index.html`. Everything you change after that is saved in your browser's `localStorage`, under that browser and that device only.

To move a library between machines: **Library tools → Export CSV**, then **Import CSV** on the other one. **Library tools → Restore the original catalogue** puts back the embedded 117.

No accounts, no server, no network calls except the Google Fonts stylesheet.

## Editing

`index.html` is the whole site — markup, styles and script in one file. Open it in a browser to work on it; there is no build step.

The embedded catalogue is the `SEED` array in the script: one row per book, columns `[title, author, genre, shelf, series, seriesNo, tags, language]`. Genre ids are `crime`, `romance`, `fantasy`, `mystery`, `sinhala`, `children`, `ya`, `nonfic`, `other`.

## Deploying

GitHub Pages serves `main` from the repository root. Push to `main` and the site updates.
