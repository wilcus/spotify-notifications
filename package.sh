#!/bin/sh
rm -rf bin/
mkdir -p bin/
zip -r bin/spotify-notifications-chrome.zip *.* src icons -x .git \*.md \*.sh
cd bin
cp spotify-notifications-chrome.zip spotify-notifications-firefox.zip
unzip spotify-notifications-firefox.zip manifest.json
script="var fs = require('fs');
var file = './manifest.json';
var manifest = require(file);
manifest.applications = {
  gecko: {
    id: '{d3c9958d-fd04-454b-9151-49a2bdb9af63}'
  }
}
manifest.commands['_execute_browser_action'].suggested_key.default = 'Alt+Shift+S'
manifest.commands['spotify-notifications-play-pause'].suggested_key.default = 'Ctrl+Shift+Z'
fs.writeFile(file, JSON.stringify(manifest, null, 2));"
node -e "$script"
zip -u spotify-notifications-firefox.zip manifest.json
rm manifest.json
cd -
