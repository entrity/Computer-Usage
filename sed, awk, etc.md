# sed, awk, &c

## Sed

```bash
######
# Delete lines
######
sed "${i}d" # Delete ith line
sed "${i},${j}d" # Delete lines i - j
sed "${i},\$d" # Delete lines i - EOF
```

## Awk

```bash
awk '{print $1}' # Print col 1
```
