# MySQL

## Start a new server instance, configured for faster db import

See [example](https://github.com/entrity/Computer-Usage/blob/master/examples/mysqld-new-instance.sh)

## Faster import

Importing sql dumps is super slow.

1. Don't do an ordinary mysqldump. Do a dump of the structure only.
2. For dumping data, do `SELECT * FROM table INTO OUTFILE 'fpath'` for each table.
3. `mysql < structure-only.sql`
4. For each table, `LOAD DATA LOCAL INFILE 'fpath' INTO TABLE table`

## Smaller, faster indices

For other sql DBMS (PostgreSQL, SQL, etc) but not this (MySQL, MariaDB), you can create a partial index, which eliminates some data from the index, having it be implied because all rows in the partial index already match a `WHERE ...` clause.
