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
# Print range of lines BY PATTERN
######
sed -n "/START_PATTERN/,/END_PATTERN/p" # Use // for END_PATTERN to mean EOF
sed "/END_PATTERN/q"
sed -n '/BEGIN_PATTERN/,$p' # (inclusive)
sed -n '1,/BEGIN_PATTERN/d' # (exclusive)
######
# Print range of lines BY NUMBER
######
sed '2!d' # Print line 2
sed '2,6!d' # Print lines 2-6
sed '2-6d' # Print all lines EXCEPT 2-6
```

## Awk

```bash
awk '{print $1}' # Print col 1
######
# Print range of lines
######
awk '/START_PATTERN/,EOF' # Print lines after (inclusive)
```
