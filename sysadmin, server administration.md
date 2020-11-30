# Sysadmin tools

## Overview

* `fail2ban` block IP's launching ssh brute-force attacks
* `iftop` examine network traffic (e.g. `iftop -P -N -f "not port 80"`)
* `iostat` examine "cpu steal" and others
* `ngrep` network grep
* `sar` see logs of cpu, ram, i/o for the day
* `ss` dump socket statistics (similar to `netstat`)
* `tcpdump`

### fail2ban
Block IP's launching ssh brute-force attacks
[ref](https://github.com/entrity/Computer-Usage/blob/master/Reference%2C%20fail2ban.md)

### iftop
Show io. Useful for debugging network traffic.

### iostat
Show cpu steal and others. [CPU steal](https://www.linode.com/community/questions/18168/what-is-cpu-steal-and-how-does-it-affect-my-linode) is the percentage of time that a virtual CPU has to wait for the physical CPU while the hypervisor is fulfilling processes from another virtual CPU. In short, CPU steal occurs when a VM's shared CPU core is delayed in processing a request. This typically occurs when there is resource contention occurring, but that is not always the case.

* `iostat 1 10` run `iostat` every `1` seconds for `10` iterations

NB: Linode considers spikes in CPU steal values less than 10-15% to be within an acceptable range in a virtualized environment.

### pstree
* `-p` show pids
* `-s` show parents/ancestors

### sar
See logs of cpu, ram, i/o for the day [ref](https://www.redhat.com/sysadmin/troubleshooting-slow-servers)

* `sar` show cpu
* `sar -r` show ram
* `sar -d` show disk i/o

## ss
Dump socket statistics (similar to `netstat`)

* `ss -a` show all (listening and receiving)
* `ss -l` show listening
* `ss -p` show the pid

### strace
Show system calls. (Use `dtruss` instead for MacOSX.)

* `-c` aggregate data for each type of syscall
* `-e ...` use an expression to filter traces or change how they are done
* `-f` include child processes
* `-o $OUT` write output to file
* `-p $PID` attach to a currently running process
* `-T` include a column showing the time for each syscall
* `-s $LEN` set length of output (default 32)

### tcpdump

E.g.
```bash
sudo tcpdump -i eth0 host 192.168.132.150 and port 80 or port 443 -A
```

#### Installation on CentOS 7

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

## Troubleshooting

> No route to host

Could be a firewall issue. Check `firewall-cmd` and `iptables`.
