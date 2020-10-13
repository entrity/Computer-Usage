# Pandora

## Ads

Pandora detects adblock. Add this to Advanced > My Filter List:
```
@@||pandora.com/web-version/*/ads.json
```

## Are you still listening?

Pandora stops playing (even in the middle of a song) to ask if you're still listening. To automatically shut these down. Use a user script, installed as an extension at chrome://extensions:

```js
window.stillListeningInterval = setInterval(function () {
  let keepListeningButton = document.querySelector(['[data-qa="keep_listening_button"]']);
  if (keepListeningButton) keepListeningButton.click();

  let firstModalButton = document.querySelector('.Modal__container__buttons button');
  if (firstModalButton && firstModalButton.textContent == 'Refresh') firstModalButton.click();
}, 3000);
console.log('Loaded Pandora UserScript');
```

Here's a `manifest.json`:
```js
{
    "manifest_version": 2,
    "content_scripts": [ {
        "exclude_globs":    [  ],
        "include_globs":    [ "*" ],
        "js":               [ "pandora.user.js" ],
        "matches":          [ "https://*.pandora.com/*","https://pandora.com/*" ],
        "run_at": "document_end"
    } ],
    "converted_from_user_script": true,
    "description":  "When Pandora stops playing and opens interactive modals which wait for your response, this script automatically clicks them.",
    "name":         "Keep Playing, Pandora!",
    "version":      "1.1"
}
```
