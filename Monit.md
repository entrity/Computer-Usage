# Monit

Manage and monitor Unix systems; automatic maintenance & repair. Take actions in error situations. Open source.

_See also systemctl, which can automatically restart services._ Monit uses cron; `systemctl` has less power but can respond faster (immediately). Monit can monitor processes, systems, hosts, files/dirs, disks.

## Web interface
Monit has a web interface

## CLI
```bash
monit # Start monit daemon
monit quit # Stop monit
monit reload # Reload monit config files
monit -g www stop # Graceful shutdown of services belonging to group `www`
```

## Config
### Defining actions (stop, start, etc)
```
check process apache with pidfile /var/run/httpd.pid
  start program = "/etc/init.d/apache2 start"
  stop  program = "/etc/init.d/apache2 stop"
```
_NB: We add a `stop` program so that we can tell monit to stop a program if we want. If we stop the program in a normal way instead of by telling monit to stop it, then monit will just attempt to restart it the next time its cron job triggers._

```
check process apache with pidfile /var/run/httpd.pid
  restart program = "/etc/init.d/apache2 restart"
  if failed port 80 protocol http then restart
```
_NB: If `stop` and `start` are already defined, you don't need to define `restart` because monit can fall back to calling `stop` then `start`._

```
  if failed port 80 protocol http for 2 cycles then restart
```
_NB: Avoid false positives by requiring that a problem must persist before taking an action._

### Checks
#### Check website
```
check host foo.com with address foo.com
  if failed port 80 protocol http then alert
  if failed port 443 protocol https then alert

check host foo.com with address foo.com
  if failed
    port 80 protocol http
    and status = 200
    and request /login.html with content "Welcome to Login v[0-9.]+"
  then alert
```
#### Check smtp
```
check host smtp.foo.com with address smtp.foo.com
  if failed port 25 with protocol smtp then alert

check host smtp.foo.com with address smtp.foo.com
  if failed port 25 and
    expect "^220.*"
    send "HELO localhost.localdomain\r\n"
    expect "^250.*"
    send "QUIT\r\n"
  then alert
```
#### Check mysql
```
check host localhost with address 127.0.0.1
  if failed ping then alert
  if failed port 3306 protocol mysql then alert
```
#### Check SSL certificate
```
check host foo.com with address foo.com
  if failed
    port 443
    with protocol https
    and certificate valid > 30 days
    use ssl options {verify: enable}
  then alert
```
#### Check process
```
check process apache with pidfile /var/run/httpd.pid
```
#### Check resource usage
```
check process apache with pidfile /var/run/httpd.pid
  ...
  if cpu > 95% for 2 cycles then alert
  if total cpu > 99% for 10 cycles then restart
  if memory > 50 MB then alert
  if total memory > 5000 MB then restart
  if disk read > 10 MB/s for 2 cycles then alert
```
#### Check files
```
check file access.log with path /var/log/apache2/access_log
  if size > 250 MB then exec "/usr/sbin/logrotate -f apache"
  if failed checksum then alert
  if failed uid root then alert
  if failed gid root then alert
  if failed permission 755 then alert
```
#### Check directories
```
check directory certificates with path /etc/ssl/certs
  if changed timestamp then alert

check directory incoming with path /var/data/ftp
  if timestamp > 1 hour then alert
```
#### Check filesystem
```
check filesystem disk2 with path /dev/disk2
  if space usage > 95% then alert
  if service time > 300 milliseconds for 5 cycles then alert
```
#### Check network
```
check network eth0 with interface eth0
  if failed link then alert
  if changed link then alert
  if saturation > 80% then alert
  if total upload > 10 GB in last hour then exec "/usr/local/bin/script.sh"

check network eth0 with address 10.0.1.3
  start program = '/sbin/ifup eth0'
  stop  program = '/sbin/ifdown eth0'
  if failed link then restart
```
#### Check program
```
check program salesreport with path /var/monit/programs/sales.sh
  every "* 8 * * 1-5"
  if status != 0 then alert
```
