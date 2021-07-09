# MySQL

## Handy commands

```sql
# Troubleshooting
show full processlist;
show variables like '%buffer%';
# User commands
select user,host from mysql.user;
create user 'foo'@'host' identified by 'pw';
grant all on *.* to 'foo'@'host';
# Outfile
select * from table into outfile 'file.tmp';
# Table commands
SELECT table_schema AS "Database", ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS "Size (GB)" FROM information_schema.tables;
show table status from dataraptor_production;
select table_name, data_length, index_length from information_schema.tables where table_schema = 'dataraptor_production' order by data_length;
# Index commands
show indexes from tasks;
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

## InnoDB storage size
Varchar and Char storage size v memory size
https://dba.stackexchange.com/a/109226/46446
Null vs present varchar
https://dba.stackexchange.com/a/109237/46446

## Troubleshooting 

### Sleeping connections

#### Kill the connections

```bash
"${MYSQL_CMD[@]}" -e 'show full processlist' | while read -r Id User Host db Command Time State Info Progress; do
	if [[ $Command == Sleep ]] && [[ $Time -gt 150 ]]; then # $Time is in seconds
		"${MYSQL_CMD[@]}" -e "kill $Id"
		echo -e "$Id\t$User\t$Host\t$db\t$Command\t$Time\t$State\t$Info\t$Progress"
	fi
done
```

### `MySQL : Error Dropping Database (Can’t rmdir ‘.test\’, errno: 17)`

Root Cause: The `DROP DATABASE` statement will remove all table files and then remove the directory that represented the database. It will not, however, remove non-table files, whereby making it not possible to remove the directory. So you need to remove those manually.


## Master - Slave Replication

```sql
-- on master
show master status;
```
On slave:
```sql
-- Start the replica, using the --skip-slave-start option so that replication does not start.
CHANGE MASTER TO
    ->     MASTER_HOST='source_host_name',
    ->     MASTER_USER='replication_user_name',
    ->     MASTER_PASSWORD='replication_password',
    ->     MASTER_LOG_FILE='recorded_log_file_name',
    ->     MASTER_LOG_POS=recorded_log_position;
show slave status;
START SLAVE;
```

On slave config:
```
Replicate_do_db = <db name>
```
if you want to replicate multiple databases, you will have to specify the above option multiple times.
- https://dev.mysql.com/doc/refman/5.7/en/replication-options-replica.html#option_mysqld_replicate-wild-do-table

### Getting initial dump from master
https://dev.mysql.com/doc/refman/5.6/en/replication-howto-existingdata.html

```bash
# See ~/deploy/db-dump.sh on the slave server
HOST=dataraptor-db
USER=copy
DBPASS=
ROOTPW=
TIMESTAMP=`date +%Y-%m-%d`
DUMPFILE=$HOME/dump-$TIMESTAMP.sql
# Check permissions on master
mysql -h $HOST -P 5000 -u $USER -p$DBPASS -e 'show grants for "copy"' || exit 1
mysql -h $HOST -P 5000 -u $USER -p$DBPASS -e 'show grants for "copy"' | grep -P 'INSERT|CREATE|UPDATE|DELETE|DROP|RELOAD|SHUTDOWN|FILE|ALTER|INDEX|EXECUTE|SUPER|GRANT' || exit 2
# Create the dump file
mysqldump -h $HOST -P 5000 -u $USER -p$DBPASS \
  --master-data=1 --compact --compress --create-options --extended-insert \
  --quick --single-transaction \
  --databases dataraptor_production > "$DUMPFILE" || exit 1
# Drop previous databases (if any)
<<-SQL_EOF | mysql -h 127.0.0.1 -P 5000 -u root -p$ROOTPW
  DROP DATABASE dataraptor_production;
  DROP DATABASE dataraptor_copy;
  DROP DATABASE clone_dr_prod;
SQL_EOF
# Load the dump file
mysql -h 127.0.0.1 -P 5000 -u root -p$ROOTPW < "$DUMPFILE"
```

## Performance Tuning

https://www.mysql.com/why-mysql/presentations/mysql-performance-tuning101/
