#!/bin/sh
# Assemble index.html from the page source. Run from the repo root:  sh build.sh path/to/spine-index.html
set -e
SRC="${1:-src/page.html}"
{
cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="description" content="Ex Libris Nufla — a catalogue of Nufla's book collection: cover shelf, spines, filters, reading progress and reading stats.">
<meta name="theme-color" content="#121020" media="(prefers-color-scheme: dark)">
<meta name="theme-color" content="#EFEDF4" media="(prefers-color-scheme: light)">
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='7' fill='%235B2BD6'/%3E%3Ctext x='16' y='23' font-family='Georgia,serif' font-style='italic' font-weight='700' font-size='21' fill='%23fff' text-anchor='middle'%3EN%3C/text%3E%3C/svg%3E">
<style>
:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]){color-scheme:dark}}
:root[data-theme="dark"]{color-scheme:dark}
:root[data-theme="light"]{color-scheme:light}
body{margin:0;font:14px -apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;background:#faf9f7}
img{max-width:100%}
[hidden]{display:none!important}
</style>
HEAD
cat "$SRC"
printf '</head>\n<body></body>\n</html>\n'
} > index.html
echo "built index.html ($(wc -c < index.html | tr -d ' ') bytes)"
