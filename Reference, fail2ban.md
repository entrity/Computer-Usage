# Fail2ban

Install as a service to block attackers trying to hit your ssh server.

```bash
# Centos 7
yum install epel-release
yum install fail2ban fail2ban-systemd
yum update selinux-policy*
systemctl start fail2ban
systemctl enable fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Then modify `/etc/fail2ban/jail.local`: Look for `[sshd]` and set `enabled`
```
[sshd]
enabled = true
```

You can also set the jailing parameters in this file. Optionally, you might even whitelist certain IPs:

```
[DEFAULT]
# "ignoreip" can be an IP address, a CIDR mask or a DNS host. Fail2ban will not
# ban a host which matches an address in this list. Several addresses can be
# defined using space separator.
ignoreip = 127.0.0.1/8 123.45.67.89
```

If `fail2ban` locks yourself out of your own server, use an alternate means of access, then check your iptables: `iptables -n -L`. Find your IP address in the output and see if the relevant chain name begins with `f2b` or `fail2ban`. If so, it is indeed `fail2ban` that is blocking you. Then:
```bash
fail2ban-client set jailname unbanip $MY_IP
```
