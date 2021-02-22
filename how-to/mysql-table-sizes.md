# How to get MySQL table sizes

## Get size of table data + index
```sql
SELECT
  TABLE_NAME AS `Table`,
  ROUND(DATA_LENGTH / 1024 / 1024) AS `Data Size (MB)`,
  ROUND(INDEX_LENGTH / 1024 / 1024) AS `Index Size (MB)`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Size (MB)`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = @SCHEMA_NAME
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;
```

## Get avg row size for table
```sql
SHOW TABLE STATUS WHERE name=@TABLE_NAME\G
```
