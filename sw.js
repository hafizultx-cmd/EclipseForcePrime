/* Eclipse Force Prime OS: minimal service worker so the site can be installed. It caches nothing, so you always get the live version. */
self.addEventListener('install',()=>self.skipWaiting());
self.addEventListener('activate',e=>e.waitUntil(self.clients.claim()));
self.addEventListener('fetch',()=>{});
