# sed, awk, &c

## Sed

```bash
######
# Delete lines
######
sed "${i}d" # Delete ith line
sed "${i},${j}d" # Delete lines i - j
sed "${i},\$d" # Delete lines i - EOF
######
# Print range of lines
######
sed -n "/START_PATTERN/,/END_PATTERN/p" # Use // for END_PATTERN to mean EOF
sed "/END_PATTERN/q"
sed -n '/BEGIN_PATTERN/,$p' # (inclusive)
sed -n '1,/BEGIN_PATTERN/d' # (exclusive)
```

## Awk

```bash
awk '{print $1}' # Print col 1
######
# Print range of lines
######
awk '/START_PATTERN/,EOF' # Print lines after (inclusive)
```
