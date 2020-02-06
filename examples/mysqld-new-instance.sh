#!/bin/bash

# Start a new mysqld server, configured for faster db imports

D=$HOME/tmp

[[ -e err.log ]] && rm err.log

CMD=(mysqld \
--port=5001 \
--socket=$D/m.sock \
--datadir=$D/data \
--pid-file=$D/pid \
--log-error=$D/err.log \
--explicit_defaults_for_timestamp \
--innodb_buffer_pool_size=4G \
--innodb_log_buffer_size=256M \
--innodb_log_file_size=1G \
--innodb_write_io_threads=16 \
--innodb-doublewrite=OFF \
--innodb_flush_log_at_trx_commit=0)

if ! [[ -e $D/data ]]; then
	>&2 echo "Initializing instance for 'root' user with no password..."
	"${CMD[@]}" --initialize-insecure
	echo $?
	>my.cnf echo -e "[mysql]\nuser=root\nhost=127.0.0.1\nport=5001"
fi
>&2 echo "Connect with:"
>&2 echo "mysql --defaults-file=my.cnf"
>&2 echo "Starting server..."
"${CMD[@]}"

[[ -e err.log ]] && cat err.log
