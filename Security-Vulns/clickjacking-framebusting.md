# Clickjacking

Clickjacking, also known as a "UI redress attack", is when an attacker uses
multiple transparent or opaque layers to trick a user into clicking on a
button or link on another page when they were intending to click on the
top level page. Thus, the attacker is "hijacking" clicks meant for their
page and routing them to another page, most likely owned by another
application, domain, or both.

Using a similar technique, keystrokes can also be hijacked. With a
carefully crafted combination of stylesheets, iframes, and text boxes, a
user can be led to believe they are typing in the password to their email
or bank account, but are instead typing into an invisible frame controlled
by the attacker.

## E.g.
```html
<html>
<body>
<iframe height="500" width="500" src=" https://pinney.insureio.com/signup" ></iframe>
</body>
</html>
```

## Fix
Frame busting technique is the better framing protection
technique. Sending the proper X-Frame-Options HTTP response headers
that instruct the browser to not allow framing from other
domains

https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
https://www.owasp.org/index.php/Clickjacking
https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Clickjacking_Defense_Cheat_Sheet.md
