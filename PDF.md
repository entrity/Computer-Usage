# PDF

## Decompress
```bash
# Decompress
qpdf --qdf --object-streams=disable orig.pdf uncompressed-orig.pdf
pdftk orig.pdf output uncompressed-orig.pdf uncompress
mutool clean -d -a orig.pdf uncompressed-orig.pdf
# Compress
qpdf --qdf --compress-streams=y decompressed.pdf compressed.pdf
```

## Combine pages
```bash
pdftk *pdf cat output out.pdf
qpdf --empty --pages *.pdf -- out.pdf # Destroys form inputs (at least before version 10.2)
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=out.pdf *.pdf # Destroys form inputs
```
