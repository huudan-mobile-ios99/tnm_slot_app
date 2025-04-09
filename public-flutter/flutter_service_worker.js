'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "5e1c71506621745632096b358829463d",
"index.html": "59708de8b2e3ff0b5e8defbcb3ee695f",
"/": "59708de8b2e3ff0b5e8defbcb3ee695f",
"main.dart.js": "aad0e90f5418fe6098c418ff86e56bfa",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "fbc8f9eb4c79f6cc31d2fc1d5ce93d48",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "881d08734865b181d3fadcd2c094f4ff",
"assets/asset/no_image.png": "d01e7fe7078bd8f8c7500413f68dfe60",
"assets/asset/one.gif": "580828d15e1e26e731b17e139d94eda4",
"assets/asset/winner.png": "b6ac1354194d6e4a182ef8f60582e0df",
"assets/asset/meteor-rain.gif": "e0f68f9f01a64c07edb33ba9b61b222d",
"assets/asset/video_final.mp4": "9f63816ecbfa17a1358c99e549da9343",
"assets/asset/image/background4.jpg": "99261d1ab5c38e9e0f7aedbee52d871f",
"assets/asset/image/logo_renew.png": "51456b9f214904eefe8394293e885900",
"assets/asset/image/background3.jpg": "1805845476998552bbd959f83c7fe49b",
"assets/asset/image/background.png": "86719dd4137da2090c67917ff8b59ca8",
"assets/asset/image/210912_rotate.jpeg": "e0c2ea5ebcf41ae5edf80f1ca8803fab",
"assets/asset/image/logo_new.png": "8b3e6515bdc352ff9052294184f41451",
"assets/asset/image/210912.jpg": "f4fbb48a1a12dea12522cf198c15dbc9",
"assets/asset/image/210912_rotate2.jpeg": "aeaa5bdc244da3ffc4de959fa2e23e33",
"assets/asset/lottie3.json": "9e50cc029e16e8b5ebf21c9e50c79ea3",
"assets/asset/video_full.mp4": "357790b3dd33df7df48154794e4807c1",
"assets/asset/bg4.jpg": "784d16ab16d1b6498d5ca8d671bfb5c8",
"assets/asset/silver.png": "7826b1f373fde95dac6254e271d689cd",
"assets/asset/three.gif": "8dad11ccba76f3adcf9654ff55b7e88c",
"assets/asset/bg1.png": "400772ecc77b6dbbcb7a474cbce3702b",
"assets/asset/medal.png": "af7c6b1d31a13b27d64b5f35a94adbfc",
"assets/asset/bg1.jpg": "d15debc7499ccf0554915dcc5c655236",
"assets/asset/bg3.jpg": "ddbf163f65647ac6458926d0f6af6624",
"assets/asset/lottie2.json": "3d62df47b04891455cdf7dc30ed5e5b9",
"assets/asset/bg2.jpg": "e72d4aa66f297d8df8eddecaa792be85",
"assets/asset/video_fixed.mp4": "37486ba9e4838569dfaa8f187a1ae788",
"assets/asset/video_fixed_short.mp4": "61a46621c1ef889ecc8aabde7be0ea0b",
"assets/asset/font/BebasNeue-Regular.ttf": "b2b293064f557c41411aac04d6f6710d",
"assets/asset/font/OpenSans-VariableFont_wdth,wght.ttf": "95393d9faf957406807a05d8fba3f4fc",
"assets/asset/bg_video.mp4": "bc7d43ede3f7199677d03468e8069cec",
"assets/asset/two.gif": "aeb4b14dfe85fb13a7c9e3680fd1d6c5",
"assets/asset/lottie4.json": "979a4fb854c810b202c6f9034ca3cb07",
"assets/asset/lottie.json": "0b8c6e9a287752b21b19890da9bc324e",
"assets/asset/bg.png": "4733dddbe9de3e10badd9684c9fe6c56",
"assets/asset/bg.jpg": "969cd90cf2de981db08a05647bde57a8",
"assets/AssetManifest.json": "a6622f26f8839b94dfb9f67e5f6ca554",
"assets/NOTICES": "97ef8075b8eab266092208c8375adf22",
"assets/FontManifest.json": "397422ec0b6c30b9e6b6871216d2f5e1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "6309aef6f25d1530ec45b8ba778263de",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
