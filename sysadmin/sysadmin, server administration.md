# Sysadmin tools

## Overview

* `fail2ban` block IP's launching ssh brute-force attacks
* `iftop` examine network traffic (e.g. `iftop -P -N -f "not port 80"`)
* `iostat` examine "cpu steal" and others
* `monit` manage, monitor unix systems; automate repair
* `ngrep` network grep
* `perf` multitool
* `pstree` show process tree
* `sar` see logs of cpu, ram, i/o for the day
* `ss` dump socket statistics (similar to `netstat`)
* `strace` show system calls for a process (or process tree)
* `systemctl`, `systemd` manage services
* `tcpdump` capture packets and read capture files

----
## fail2ban
Block IP's launching ssh brute-force attacks
[ref](https://github.com/entrity/Computer-Usage/blob/master/Reference%2C%20fail2ban.md)

----
## iftop
Show io. Useful for debugging network traffic.

----
## iostat
Show cpu steal and others. [CPU steal](https://www.linode.com/community/questions/18168/what-is-cpu-steal-and-how-does-it-affect-my-linode) is the percentage of time that a virtual CPU has to wait for the physical CPU while the hypervisor is fulfilling processes from another virtual CPU. In short, CPU steal occurs when a VM's shared CPU core is delayed in processing a request. This typically occurs when there is resource contention occurring, but that is not always the case.

* `iostat 1 10` run `iostat` every `1` seconds for `10` iterations

NB: Linode considers spikes in CPU steal values less than 10-15% to be within an acceptable range in a virtualized environment.

----
## monit
Manage and monitor Unix systems; automatic maintenance & repair. Take actions in error situations. Open source.

_See also systemctl, which can automatically restart services._ Monit uses cron; `systemctl` has less power but can respond faster (immediately). Monit can monitor processes, systems, hosts, files/dirs, disks.

See also `Monit.md`

----
## perf
https://jvns.ca/debugging-zine.pdf
* `perf record ...` - shows you C/nodejs/java functions in a process
* `perf report` - look at results of `perf record ...`
* `perf top`

----
## pstree
* `-p` show pids
* `-s` show parents/ancestors

----
## sar
See logs of cpu, ram, i/o for the day [ref](https://www.redhat.com/sysadmin/troubleshooting-slow-servers) [ref2](https://www.tothenew.com/blog/install-and-configure-sar-on-ubuntu/)

`sudo apt install sysstat # Then edit /etc/default/sysstat`

* `sar` show cpu
* `sar -r` show ram
* `sar -d` show disk i/o

----
## ss
Dump socket statistics (similar to `netstat`)

* `ss -a` show all (listening and receiving)
* `ss -l` show listening
* `ss -p` show the pid

----
## strace
Show system calls. (Use `dtruss` instead for MacOSX.)

* `-c` aggregate data for each type of syscall
* `-e ...` use an expression to filter traces or change how they are done
* `-f` include child processes
* `-o $OUT` write output to file
* `-p $PID` attach to a currently running process
* `-T` include a column showing the time for each syscall
* `-s $LEN` set length of output (default 32)

----
## systemctl, systemd
Start/stop/reload services.
### Configure service for automatic restart after a crash
[cf. ]()
```bash
systemctl edit httpd
# ...Make edits
systemctl daemon-reload
```
The edits should add lines to the file, saved at a location like `/etc/systemd/system/httpd.service.d/override.conf`:
```
[Service]
Restart=always
RestartSecs=30 # Optional delay, but what's the benefit to a delay?
```
Test the config:
```bash
systemctl start httpd
ps -A | grep httpd
killall httpd
ps -A | grep httpd
```

----
## tcpdump
E.g.
```bash
sudo tcpdump -i eth0 host 192.168.132.150 and port 80 or port 443 -A
```

### Installation on CentOS 7
```bash
# First install epel repository
yum install epel-release
# Then modify /etc/yum.repos.d/epel.repo and /etc/yum.repos.d/epel-testing.repo
# uncommenting `baseurl=` lines and commenting `metalink=` lines
...
yum update
# Then install iftop
yum install iftop
```
