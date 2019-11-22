// Unregister service worker.
// When we were on GatsbyJS, it added a ServiceWorker that interfered with page reloads.
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.ready.then(registration => {
    registration.unregister();
  });
}