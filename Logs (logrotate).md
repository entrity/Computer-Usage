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
