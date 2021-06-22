# Security Vulnerabilities

## XSS
Cross-site scripting (or XSS) allows an attacker to execute arbitrary JavaScript within the browser of a victim user.

### Reflected XSS
An application receives data in an HTTP request and includes that data within the immediate response in an unsafe way.

E.g. attacker puts a `<script>` tag in the XSS request, gets a response with that script embedded, allowing it to execute in the victim's browser.

### Stored XSS
An application receives data from an untrusted source and includes that data within its later HTTP responses in an unsafe way.

E.g. `<script>` tag in a comment on a blog post.

### DOM-based XSS
An application contains some client-side JavaScript that processes data from an untrusted source in an unsafe way, usually by writing the data back to the DOM.

E.g. a script reads value of a form field, then writes that value to the DOM. If the attacker can control the value of the input field (e.g. if the value is populated from a param in a query string which the attacker crafts to open in the victim's browser), they can easily construct a malicious value that causes their own script to execute.

## CSRF
Cross-site request forgery (or CSRF) allows an attacker to induce a victim user to perform actions that they do not intend to.

* CSRF often only applies to a subset of actions that a user is able to perform. Many applications implement CSRF defenses in general but overlook one or two actions that are left exposed. Conversely, a successful XSS exploit can normally induce a user to perform any action that the user is able to perform, regardless of the functionality in which the vulnerability arises.
* CSRF can be described as a "one-way" vulnerability, in that while an attacker can induce the victim to issue an HTTP request, they cannot retrieve the response from that request. Conversely, XSS is "two-way", in that the attacker's injected script can issue arbitrary requests, read the responses, and exfiltrate data to an external domain of the attacker's choosing.

## Header injection (& response splitting)
https://guides.rubyonrails.org/v5.1/security.html#header-injection
