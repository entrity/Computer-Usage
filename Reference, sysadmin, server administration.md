# Sysadmin tools

## Overview

* [`fail2ban`](https://github.com/entrity/Computer-Usage/blob/master/Reference%2C%20fail2ban.md) - Block IP's launching ssh brute-force attacks
* `iftop` examine network traffic (e.g. `iftop -P -N -f "not port 80"`)
* `ss` dump socket statistics (similar to `netstat`)
    * `ss -a` show all (listening and receiving)
    * `ss -l` show listening
    * `ss -p` show the pid
