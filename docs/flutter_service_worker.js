'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"flutter_bootstrap.js": "907b8002e133f4833cc1a68d00050fbc",
"assets/NOTICES": "86070fc7b4c740e5d75797dd6de29c5a",
"assets/AssetManifest.bin": "ab8d47494b4c9e6adb49e87b81bf1a3e",
"assets/assets/background.jpg": "11e588b8ba005c99e05695365d943d61",
"assets/assets/images/background.jpg": "11e588b8ba005c99e05695365d943d61",
"assets/assets/images/product_05.png": "8383c6bb7eb9708009062b152797002e",
"assets/assets/images/product_01.png": "61439efc2a3c354e49dd22351c2e20d7",
"assets/assets/images/product_03.png": "de98361a6f8539a6fd45b8ab38841b83",
"assets/assets/images/avatar_2.png": "a42066f868ff7a14bf3c59690c0fbed3",
"assets/assets/images/product_8.png": "0376f3a4d26135decedf37135915f1e0",
"assets/assets/images/product_04.png": "8d0e65f54f85fc25ed64d976fa286965",
"assets/assets/images/product_10.png": "38f00ba98d4a29dfd1567b667ada1c01",
"assets/assets/images/avatar_1.png": "242a909d594d94e9ab4fd8a854efda7c",
"assets/assets/images/product_9.png": "f4c7b416cdcb6824bfee728f34e0f90c",
"assets/assets/images/horse_rider.png": "41f211c1b720f8acddb47b2895a400c1",
"assets/assets/images/product_02.png": "b35a5a0ec1d7c1a5180c44b3dacefd3e",
"assets/assets/images/avatar_3.png": "1ef1907894d3c1c7891c2b160a40eda9",
"assets/assets/images/avatar_4.png": "524aed78017a0a02fd4dce91d9083ebc",
"assets/assets/images/avatar_5.png": "b60e122cd0345f220a662f93fc6290b1",
"assets/assets/images/product_06.png": "f52932cbf99b3eb34f012ed892554dc9",
"assets/assets/images/product_07.png": "a527e4942a073e9e96fea3ecfe17e483",
"assets/assets/product_05.png": "8383c6bb7eb9708009062b152797002e",
"assets/assets/product_01.png": "61439efc2a3c354e49dd22351c2e20d7",
"assets/assets/product_03.png": "de98361a6f8539a6fd45b8ab38841b83",
"assets/assets/product_04.png": "8d0e65f54f85fc25ed64d976fa286965",
"assets/assets/logo_eqqu.svg": "d71f46c793c85c3e311b3c73cce09947",
"assets/assets/icons/nastaveni.svg": "7107fa9204bf822e54f77428aac1a10d",
"assets/assets/icons/Tag.svg": "c1a5c4abd8f3e8d90fa28fa2602f0a27",
"assets/assets/icons/erapeuticke_pristroje.svg": "06b6193b558034af1ef6de203724dc9a",
"assets/assets/icons/jak_funguje.svg": "9b0c4214b5a59b135e1752fc5f99befc",
"assets/assets/icons/shield-check.svg": "2d9e6b60e0304fc798b855d591e8746e",
"assets/assets/icons/Kniha_hracky_darky.svg": "68a0c553d2010ee5ba94a59a9a5c3727",
"assets/assets/icons/Jezdci.svg": "59056bf5594bd7ebcc71646192e204bd",
"assets/assets/icons/Add.svg": "65780e070ed5e953ddaa04decfa6fc5b",
"assets/assets/icons/Heart.svg": "f17abb16ca572328dc07d2b6ba60769d",
"assets/assets/icons/penezenka.svg": "92230b7f85da90660b857375021a9337",
"assets/assets/icons/Measuring_tape.svg": "2d81c854688180cb13e54d83344d9e1a",
"assets/assets/icons/Kone.svg": "098a442502e75782be0de0a98b8882d9",
"assets/assets/icons/moje_prodeje.svg": "2bcb7fd24b4c560078bf9a61d370ba49",
"assets/assets/icons/HeartEmpty.svg": "da12e5fdde6de34af14414d00020f5d8",
"assets/assets/icons/Fabric.svg": "7e896d2fa21378cf049f62d92c4ea098",
"assets/assets/icons/moje_nakupy.svg": "78f229f2ffc864b2fc2b43976ae36ead",
"assets/assets/icons/mimo_staj.svg": "68f0cf909902d16ef4fdd4de5c56cb07",
"assets/assets/icons/eqqu_platforma.svg": "48e88979dac4faefc5e8d5f6720e45ed",
"assets/assets/icons/zpetna_vazba.svg": "0f09458d8372409ed787b883a5deb5e3",
"assets/assets/icons/Color.svg": "79cca173e5c04d917b25e40c5ea419bc",
"assets/assets/icons/oblibene_predmety.svg": "99cb00787ee3ba75e6af00968d8e6e46",
"assets/assets/icons/ClockUser.svg": "38a2ed9e833939881bc9fd342941d0a9",
"assets/assets/icons/Veterinarni_produkty.svg": "833e9a169c7339b193616bdbee19d89a",
"assets/assets/icons/pozvat.svg": "bdb80185e9d695887f710664df95b2f5",
"assets/assets/icons/moje_inzeraty.svg": "1587102e38031e4c6d692953dc3ea53f",
"assets/assets/icons/o_nas.svg": "bd920966d8cef7ff19e9104c2058b92a",
"assets/assets/icons/Psi.svg": "3158cf4266206ae131cd39da91bdcdc0",
"assets/assets/icons/Umeni.svg": "fee259154cb89643730869b340661d57",
"assets/assets/icons/napoveda.svg": "8cb2c2d3cfc6e1ef1e9c0f4c5ba6eb3f",
"assets/assets/icons/Staj.svg": "fabdf6b26da8d1a51966a7b2c4b32bbb",
"assets/assets/icons/MapPinArea.svg": "27f2d5a4e8ec496b14c7a120f2537866",
"assets/assets/icons/Krmivo.svg": "ba2bf9146710f1dc13a5d3d7c9dc346d",
"assets/assets/menu/Heart.svg": "215a1eb84e2245eaa108d853ecf0c565",
"assets/assets/menu/User.svg": "6e0ead6412d5b06e25035315191838a6",
"assets/assets/menu/Chat.svg": "8ef87c393101db034f2ec91e4a6d3bf1",
"assets/assets/menu/Plus_symbol_button.svg": "57044fa32e9ed26ad291f1a89243afab",
"assets/assets/menu/Home.svg": "6bec84626524c95562f4291dc37c417e",
"assets/assets/product_02.png": "b35a5a0ec1d7c1a5180c44b3dacefd3e",
"assets/assets/fonts/Poppins-SemiBold.ttf": "2c63e05091c7d89f6149c274971c7c23",
"assets/assets/fonts/Poppins-Bold.ttf": "92934d92f57e49fc6f61075c2aeb7689",
"assets/assets/fonts/Outfit.ttf": "e31a3aa5fce3366bcadb8e9027f26178",
"assets/assets/fonts/Poppins-Regular.ttf": "09acac7457bdcf80af5cc3d1116208c5",
"assets/assets/fonts/Poppins-Medium.ttf": "20aaac2ef92cddeb0f12e67a443b0b9f",
"assets/assets/product_06.png": "f52932cbf99b3eb34f012ed892554dc9",
"assets/FontManifest.json": "7b8a180df89fa5b645b7ba5169981413",
"assets/AssetManifest.json": "7fbb04b33e6771d3366c7d0dcee4767f",
"assets/fonts/MaterialIcons-Regular.otf": "fe5f7b22a69262a94f508d092104682c",
"assets/AssetManifest.bin.json": "e179c5e9396764d41aad1cf9d419b258",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"index.html": "8fe9ff8d116493ad7bf2970e6a0e9c35",
"/": "8fe9ff8d116493ad7bf2970e6a0e9c35",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"main.dart.js": "37d1eb21369f142eb864d0d44f5898f1",
"manifest.json": "fd491a92bb55b168eb575d1edee5ccb4",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"version.json": "5caa6cc41b6749a9a8420a8ea2377e18"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
