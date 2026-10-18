const CACHE = 'tt-dojo-v6';
const SHELL = ['./', 'index.html', 'manifest.webmanifest', 'icon.svg', 'icon-192.png', 'icon-512.png'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL.map(u => new Request(u, { cache: 'reload' })))).then(() => self.skipWaiting()));
});
self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});
// Our own files: network first so a new release shows up right away; the cache is the offline fallback.
// Google Fonts: cache first, they never change.
self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const own = new URL(req.url).origin === self.location.origin;
  const put = res => { if (res.ok || res.type === 'opaque') { const copy = res.clone(); caches.open(CACHE).then(c => c.put(req, copy)); } return res; };
  if (own) {
    e.respondWith(fetch(req, { cache: 'no-cache' }).then(put).catch(() =>
      caches.match(req).then(hit => hit || (req.mode === 'navigate' ? caches.match('index.html') : Response.error()))));
  } else {
    e.respondWith(caches.match(req).then(hit => hit || fetch(req).then(put)));
  }
});
