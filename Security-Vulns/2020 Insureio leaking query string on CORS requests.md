# The password-reset form page leaks the perishable token in the Referer header 

[github issue #1603](https://github.com/pic-development/Insureio/issues/1603)

Looks an easy fix: adding a Referrer-Policy header to that particular endpoint. (But I think it's reasonable to add it to the whole site, using the policy origin-when-cross-origin.)

cf. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy

Explaination: If someone were to add a link from that page to an external site, the Referer header would carry the current URL, which contains the perishable token. Not a huge risk and very unlikely to be an issue.

One option is to set the header `Referrer-Policy: origin-when-cross-origin`. Another is this meta tag in html documents: `<meta name="referrer" content="origin-when-cross-origin">`.
