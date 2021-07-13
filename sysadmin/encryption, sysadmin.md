# Sysadmin: encryption

```bash
# Get list of ciphers supported by HTTPS server
sudo nmap --script ssl-enum-ciphers -p $PORT $HOST
# Get list of ciphers supported by SSH server
sudo nmap --script ssh2-enum-algos -sV -p $PORT $HOST
# Get list of ciphers supported by IMAP server
sudo nmap --script ssl-enum-ciphers -p $PORT $HOST
```