# Sysadmin tools

## Overview

* [`fail2ban`](https://github.com/entrity/Computer-Usage/blob/master/Reference%2C%20fail2ban.md) - Block IP's launching ssh brute-force attacks
* `iftop` examine network traffic (e.g. `iftop -P -N -f "not port 80"`)
* `sar` see logs of cpu, ram, i/o for the day [ref](https://www.redhat.com/sysadmin/troubleshooting-slow-servers)
    * `sar` show cpu
    * `sar -r` show ram
    * `sar -d` show disk i/o 
* `ss` dump socket statistics (similar to `netstat`)
    * `ss -a` show all (listening and receiving)
    * `ss -l` show listening
    * `ss -p` show the pid


### iftop

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
