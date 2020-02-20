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
