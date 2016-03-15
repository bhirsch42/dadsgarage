Package.describe({
  name: "bhirsch:camera",
  summary: "Photos with one function call on desktop and mobile.",
  version: "1.0.0",
});

Cordova.depends({
  "cordova-plugin-camera": "2.1.0"
});

Package.onUse(function(api) {
  api.export('MeteorCamera');
  api.use(["templating", "session", "ui", "blaze", "less@1.0.0||2.0.0", "reactive-var"]);
  api.versionsFrom("METEOR@1.2");
  api.use("isobuild:cordova@5.2.0");
  api.use('coffeescript');

  api.addFiles('photo.html');
  api.addFiles('photo.js');
  api.addFiles("camera.less", ["web.browser"]);
  api.addFiles('photo-browser.coffee', ['web.browser']);
  api.addFiles('photo-cordova.coffee', ['web.cordova']);
});
