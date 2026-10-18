# Times Table Dojo

A times tables practice app (PWA) for 1–12. Adaptive practice, a 60-second Blitz, a mastery map and belts to earn.

Live at https://mikhaylova.dev/dojo/

- Source: `app.html` (page body), `manifest.webmanifest`, `sw.js`, icons
- `./build.sh` writes the deployable site to `dist/`
- `.github/workflows/deploy.yml` builds and copies `dist/` to the server over SSH on every push to `main`.
  Repository secrets: `SSH_USER`, `SSH_KEY` (private key), optional `SSH_PORT` (default 22) and `DEPLOY_PATH` (default `/var/www/dojo`).

## nginx

```nginx
location = /dojo { return 301 /dojo/; }
location /dojo/ {
    alias /var/www/dojo/;
    index index.html;
}
location = /dojo/sw.js {
    alias /var/www/dojo/sw.js;
    add_header Cache-Control "no-cache";
}
```
