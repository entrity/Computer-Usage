# Javascript testing frameworks

## Protractor

### Errors

#### WebDriverError: element not interactable

It may be that you want to click or select or send keys to an element which is currently outside the viewable window.

Try changing your window size in your protractor config file?

```javascript
chromeOptions: { args: [ "--headless", "--disable-gpu", "--window-size=1920,1080"] },
```

Maybe add a `browser.sleep(100)` before or after your `click()` call?

Maybe try to scroll the element into view?

```javascript
browser.actions().mouseMove(element).perform()
```
#### Failed: javascript error: Failed to execute 'elementsFromPoint' on 'Document': The provided double value is non-finite.

You might be trying to run a scroll operation (as shown above) on a matcher that matches more than one element.

#### DevToolsActivePort file doesn't exist

Add args `--disable-dev-shm-usage','--no-sandbox'` in browser capabilities in config.

#### E/launcher - session not created: Chrome version must be between 71 and 75

You version of ChromeDriver is incompatible with your version of Chrome. You can install a new version of Chrome:

```bash
node_modules/protractor/bin/webdriver-manager update --versions.chrome 80.0.3987.106
```

(You can uninstall all installed drivers and Chromes with `node_modules/protractor/bin/webdriver-manager clean`.)
