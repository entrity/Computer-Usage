# Troubleshooting LaTeX

----
## Package xkeyval Error: `name' undefined in families `Gin'
cf. https://tex.stackexchange.com/questions/502079/package-xkeyval-error-frame-undefined-in-families-gin

Check occurences of `\includegraphics[...]{...}` for the key `name`, which is illegal.

----
## Misaligned images or form fields
_Solution:_
Render the pdf twice (withouth removing the `*.aux` and `*.out` files)
