# Times Table Dojo

Times tables practice for a 12-year-old: adaptive practice with hints, 60-second Blitz, a 12×12 mastery map, belts.

- Live PWA: https://mikhaylova.dev/dojo/
- No framework, no build tools. `app.html` is written as a page body for the Claude artifact viewer (title, styles, script); `build.sh` moves everything before `<div class="wrap" id="app">` into `<head>` (Chrome only reads the manifest link from `<head>`, otherwise the app cannot be installed) and the rest into `<body>`, copies the manifest, service worker and icons into `dist/` and packs `dojo.tgz`.
- Hosted as static files on the VPS (nginx, `/var/www/mikhaylova.dev/dojo`) behind Cloudflare, like the Fuel app at `/fuel`. Every push to `main` deploys via GitHub Actions (`.github/workflows/deploy.yml`) with a deploy key restricted on the server to unpacking the tarball into that folder. Server address, port, user and keys live only in repository secrets, never in the repo (it is public).
- All paths are relative so the app works under `/dojo/`. The manifest is `manifest.json`, not `.webmanifest`: nginx serves `.webmanifest` with the wrong content type, which breaks installing on Android (same as in Fuel).
- `build.sh` stamps the commit hash into the service worker URL (`sw.js?v=…`) because Cloudflare caches `.js` for 4 hours. The service worker is network first for our own files (cache only when offline), so releases show up on the next open. Bump `CACHE` in `sw.js` when its own code changes.
- Progress is stored in `localStorage` (`tt-dojo-v1`) on the device only.
- Languages: English, Spanish, Catalan, Russian (`I18N` in `app.html`). The first run picks the device language; Settings switches it. Every UI string and trick rule lives in `I18N`; add a key to all four languages. Bungee has no Cyrillic, so Russo One is the display fallback for Russian.
