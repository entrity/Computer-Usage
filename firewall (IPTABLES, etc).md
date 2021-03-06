## IPTBALES

#### Quick: unblock everything

```bash
sudo iptables-save > /tmp/iptables.txt # save existing config in case a restore is needed
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X
```

#### Configure

```bash
# Save existing rules
iptables-save > iptables-`date -I`.txt
# Restore rules from dump file (with flush)
iptables-restore iptables.txt
# Parse the dump file but do not commit it
iptables-restore -t iptables.txt
```

```bash
# List existing rules
iptables -L
```

```bash
# Drop/reject connections by default
iptables --policy INPUT DROP # Don't send back an error s.t. the source doesn't see the system exists
iptables --policy OUTPUT REJECT # No need to occlude with DROP if the user is already inside the system
iptables --policy FORWARD DROP # Forwarding is a chain for routing (not INPUT or OUTPUT)

# Open a port for any connection
iptables -A INPUT -p tcp --dport 8000 -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
# Open all ports for source IP
iptables -A INPUT -p tcp -s 10.0.0.1 -j ACCEPT

# Insert a rule (because matches are searched in list order)
iptables -I INPUT 3 -p tcp --dport 8000 -j ACCEPT # Set the number after the chain name

# Flush changes
iptables -F [CHAIN]
```

```bash
# Delete by chain and line number
iptables -L --line-numbers
iptables -D INPUT 3
# Delete by specification
iptables -D INPUT -m conntrack --ctstate INVALID -j DROP

# Flush changes
iptables -F [CHAIN]
```

The changes that you make to your iptables rules will be scrapped the next time that the iptables service gets restarted unless you execute a command to save the changes.  This command can differ depending on your distribution:

```bash
# Ubuntu:
sudo /sbin/iptables-save
# Red Hat / CentOS:
/sbin/service iptables save
# Or
/etc/init.d/iptables save
```
