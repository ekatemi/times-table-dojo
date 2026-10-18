# Times Table Dojo

Times tables practice for a 12-year-old: adaptive practice with hints, 60-second Blitz, a 12×12 mastery map, belts.

- Live PWA: https://mikhaylova.dev/dojo/
- No framework, no build tools. `app.html` is the page body (title, styles, script); `build.sh` wraps it in a full document, copies the manifest, service worker and icons into `dist/` and packs `dojo.tgz`.
- Hosted as static files on the VPS (nginx, `/var/www/mikhaylova.dev/dojo`) behind Cloudflare, like the Fuel app at `/fuel`. Upload `dojo.tgz` by hand.
- All paths are relative so the app works under `/dojo/`.
- Bump `CACHE` in `sw.js` on every release, or installed copies keep the old version.
- Progress is stored in `localStorage` (`tt-dojo-v1`) on the device only.
