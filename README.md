# Times Table Dojo

A times tables practice app (PWA) for 1–12. Adaptive practice, a 60-second Blitz, a mastery map and belts to earn.

Live at https://mikhaylova.dev/dojo/

```sh
./build.sh   # writes dist/ and packs it as dojo.tgz
```

Every push to `main` deploys automatically (`.github/workflows/deploy.yml`): GitHub Actions builds `dojo.tgz` and sends it over SSH.
The deploy key on the server is restricted to one command that unpacks the archive into `/var/www/mikhaylova.dev/dojo`.
Repository secrets: `SSH_HOST`, `SSH_PORT`, `SSH_USER`, `SSH_KEY`, `SSH_KNOWN_HOSTS`.

Manual fallback: upload `dojo.tgz` and unpack it into `/var/www/mikhaylova.dev/dojo`.
