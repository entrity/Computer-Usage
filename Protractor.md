# Protractor

## Command line options

```bash
protractor config.js \
  --specs spec/my_spec.js \
  --capabilities.chromeOptions.args="window-size=1920,1080" \
  --capabilities.chromeOptions.args="headless" \
  --capabilities.chromeOptions.args="disable-gpu" \
  --capabilities.chromeOptions.args="host-resolver-rules='MAP * 192.168.0.115'" \
  --params.cookiesFile=myfile \
  --baseUrl="https://example.com"
```

It looks like the `=` is _not_ optional on at least some of the params.

You can specify `capabilities.chromeOptions.args` more than once in order to specify multiple args.

## Troubleshooting

### `browser.sleep(...)`

Use `browser.sleep(milliseconds)` to have the browser stop at a point so that you can open DevTools and fiddle around or click buttons. But this absolutely _WILL NOT_ pause if you put in a number that is _too large_. I find it works with `2**23` but not with `2**33`. (I hope the cutoff is `2**32-1` or `2**31-1` so that there is some logic at play.) You probably need to set `jasmine.DEFAULT_TIMEOUT_INTERVAL` likewise.

```js
jasmine.DEFAULT_TIMEOUT_INTERVAL = 2**22;
browser.sleep(2**22);
```

## Errors

* #### WebDriverError: element not interactable

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
* #### Failed: javascript error: Failed to execute 'elementsFromPoint' on 'Document': The provided double value is non-finite.

You might be trying to run a scroll operation (as shown above) on a matcher that matches more than one element.

* #### DevToolsActivePort file doesn't exist

Add args `--disable-dev-shm-usage','--no-sandbox'` in browser capabilities in config.

* #### E/launcher - session not created: Chrome version must be between 71 and 75

You version of ChromeDriver is incompatible with your version of Chrome. You can install a new version of Chrome:

```bash
node_modules/protractor/bin/webdriver-manager update --versions.chrome 80.0.3987.106
```

(You can uninstall all installed drivers and Chromes with `node_modules/protractor/bin/webdriver-manager clean`.)

* #### (Prints 'Started', then hangs for a long time before failing)

* You need to actually have a server serving an instance of your app. Run `rails s`.
* Or maybe your `baseUrl` in your config file is not pointing to the right place for your app server.

* #### WebMock (something...)
Run your rails server in development, not test environment. (Probably your Rails app is trying to submit a request to another application, as with `Net::HTTP`, and such requests have been stubbed out.)

* #### Quote requests always return nothing
Requests to Compulife might return nothing if your application is referencing Complife by a domain, such as `compulife.one`. We have to run Compulife as a web application on one of our own servers. You should make sure your `/etc/hosts` file supplies an IP address for that domain.


* #### Failed: Error while running testForAngular: script timeout

Increase the timeout in your project's protractor config file:
```js
exports.config = {
    // ... 
    getPageTimeout: 4*60*1000, // Increase default timeout
    allScriptsTimeout: 6*60*1000, // Increase default timeout
}
```
