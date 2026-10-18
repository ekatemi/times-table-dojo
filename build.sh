#!/bin/sh
# Builds dist/ for https://mikhaylova.dev/dojo/ and packs it as dojo.tgz.
# app.html is a page body as the Claude artifact viewer expects it: everything before
# <div class="wrap"> (title, metas, manifest, styles) goes into <head>, the rest into <body>.
set -e
cd "$(dirname "$0")"
rm -rf dist && mkdir -p dist
# A new sw.js URL on every release, so Cloudflare's cache never serves an old service worker.
BUILD=$(git rev-parse --short HEAD 2>/dev/null || date +%s)
SPLIT='<div class="wrap" id="app">'
grep -q "$SPLIT" app.html
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  sed "/$SPLIT/,\$d" app.html
  printf '</head>\n<body>\n'
  sed -n "/$SPLIT/,\$p" app.html | sed "s/__BUILD__/$BUILD/"
  printf '</body>\n</html>\n'; } > dist/index.html
cp manifest.json sw.js icon.svg icon-192.png icon-512.png icon-maskable-512.png dist/
tar -czf dojo.tgz -C dist .
echo "Built dist/ and dojo.tgz"
