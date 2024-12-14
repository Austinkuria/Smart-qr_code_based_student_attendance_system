self.addEventListener('install', (event) => {
    event.waitUntil(
      caches.open('flutter-cache').then((cache) => {
        // Add files to cache
        return cache.addAll([
          '/',
          'index.html',
          'favicon.png',
          'manifest.json',
          'icons/Icon-192.png',
          'icons/Icon-512.png',
          'flutter_bootstrap.js',
          'styles.css',
          'scripts.js',
        ]);
      })
    );
  });
  
  self.addEventListener('activate', (event) => {
    const cacheWhitelist = ['flutter-cache']; // Update this if you change the cache name
    event.waitUntil(
      caches.keys().then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            if (!cacheWhitelist.includes(cacheName)) {
              return caches.delete(cacheName); // Delete old caches
            }
          })
        );
      })
    );
  });
  
  self.addEventListener('fetch', (event) => {
    if (event.request.url.includes('/api/')) {
      // Network-first for API requests
      event.respondWith(
        fetch(event.request).catch(() => caches.match(event.request))
      );
    } else {
      // Cache-first for static assets
      event.respondWith(
        caches.match(event.request).then((cachedResponse) => {
          if (cachedResponse) {
            return cachedResponse;
          }
          return fetch(event.request).then((response) => {
            return caches.open('flutter-cache').then((cache) => {
              cache.put(event.request, response.clone());
              return response;
            });
          });
        })
      );
    }
  });
  