# Logs

## logrotate

Install as a package (e.g. apt or yum). Configure at `/etc/logrotate.d/`. See also `/etc/logrotate.conf`, which should include `include /etc/logrotate.d`.

e.g.
```
/var/www/railsapp/shared/nodejslog/*.log /var/www/railsapp/shared/log/*.log {
  su deploy deploy
  weekly
  maxsize 2000k
  rotate 9
  missingok
  notifempty
  sharedscripts
  copytruncate
  dateext
  dateformat .%Y%m%d
}
```

Commands:
```bash
# Dry run (verbose)
logrotate -d $config_file
# Manually run (verbose)
logrotate -v $config_file
```

### Negative match

A nice hack for a negative match is to include a script in the config, which will run in `sh` and exit with an error status for the conditions of your choosing. The first argument to the script is the absolute path of the logfile. E.g.:

```
...
nosharedscripts
prerotate
  ! grep -q pattern <<< "$1"
endscript
...
```

