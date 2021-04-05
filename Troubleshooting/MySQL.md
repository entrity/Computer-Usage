# Troubleshooting: MySQL

------
> ERROR 1201 (HY000): Could not initialize master info structure for ''; more error messages can be found in the MariaDB error log

This can happen after moving/copying InnoDB files then attempting to start up replication. Performing a `reset slave;` should fix it.
