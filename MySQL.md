# MySQL

## Handy commands

```sql
show full processlist;
select user,host from mysql.user;
grant all on *.* to user 'foo'@'host';
select * from table into outfile 'file.tmp';
```

## Binlogs

```sh
mysqlbinlog $logfile
```

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

## Troubleshoot sleeping connections

### Kill the connections

```bash
"${MYSQL_CMD[@]}" -e 'show full processlist' | while read -r Id User Host db Command Time State Info Progress; do
	if [[ $Command == Sleep ]] && [[ $Time -gt 150 ]]; then # $Time is in seconds
		"${MYSQL_CMD[@]}" -e "kill $Id"
		echo -e "$Id\t$User\t$Host\t$db\t$Command\t$Time\t$State\t$Info\t$Progress"
	fi
done
```
