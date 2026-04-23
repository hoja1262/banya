// MUSE - 최소 Service Worker
// PWA로 설치 가능하게 하려면 sw가 등록돼 있어야 함
// 오프라인 캐싱은 하지 않음 (데이터가 항상 최신이어야 하므로)

self.addEventListener('install', (e) => {
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(self.clients.claim());
});

// fetch 이벤트는 그냥 네트워크로 패스스루
self.addEventListener('fetch', (e) => {
  // 아무것도 안 함 - 브라우저 기본 동작
});
