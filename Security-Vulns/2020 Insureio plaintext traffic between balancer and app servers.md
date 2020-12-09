# Non-encrypted traffic between the load balancer and the app servers

[github issue #1569](https://github.com/pic-development/Insureio/issues/1569)

## Testing / verifying

This can be verified by running the following on dataraptor-app-1:

```bash
sudo tcpdump -i eth0 host dataraptor-app-1 and port 80 -S -A -G 60 -w /tmp/packets.ma-%Y-%m-%d_%H:%M
tcpdump -A -r /tmp/packets.ma* | grep html -A 5
```

Update the Linode node balancer config to use TCP instead of HTTP, then try the same capture, and you'll get nothing on port 80, but you will on port 443, and the packet bodies will be encrypted.

Also:

```bash
# For incoming http requests (on app-2)
sudo tcpdump -i eth0 host dataraptor-app-2 -S -A -c 10
# For master/slave database
sudo tcpdump -i eth0 host dataraptor-db -S -A -c 10
```

## Use SSL between db master and slave

### Update config file to use ssl
Update `/etc/my.cnf.d/mysql-clients.cnf` or some other mysql cnf file to reference the ssl CA, cert, and key on the slave machine:
```
[client]
ssl-ca=/var/lib/mysql/ssl/ca-cert.pem
ssl-cert=/var/lib/mysql/ssl/server-cert.pem
ssl-key=/var/lib/mysql/ssl/server-key.pem
```

### Start MariaDB without slave running
```bash
sudo service mysql stop
sudo /etc/init.d/mysql start --skip-slave-start # This seems to not work
```

### Change the slave's "MASTER" settings
```sql
STOP SLAVE;
CHANGE MASTER TO
MASTER_HOST='dataraptor-db',
MASTER_USER='replicant',
MASTER_PASSWORD=@masterpass,
MASTER_SSL=1;
START SLAVE;
```
