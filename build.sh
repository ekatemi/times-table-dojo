#!/bin/sh
# Wraps app.html in a full HTML document, copies the PWA files into dist/
# and packs them as dojo.tgz for https://mikhaylova.dev/dojo/.
set -e
cd "$(dirname "$0")"
rm -rf dist && mkdir -p dist
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat app.html
  printf '\n</body>\n</html>\n'; } > dist/index.html
cp manifest.webmanifest sw.js icon.svg icon-192.png icon-512.png icon-maskable-512.png dist/
tar -czf dojo.tgz -C dist .
echo "Built dist/ and dojo.tgz"
