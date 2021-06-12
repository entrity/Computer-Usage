# opendkim
An open source implementation of the DomainKeys Identified Mail (DKIM) sender authentication system.

The following instructions come from Digitalocean's [How To Install and Configure DKIM with Postfix on Debian Wheezy](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy)

## Install
```bash
sudo apt-get install opendkim opendkim-tools
```

## Configure
Append the following lines to the end of the conf file `/etc/opendkim.conf`:
```
AutoRestart             Yes
AutoRestartRate         10/1h
UMask                   002
Syslog                  yes
SyslogSuccess           Yes
LogWhy                  Yes

Canonicalization        relaxed/simple

ExternalIgnoreList      refile:/etc/opendkim/TrustedHosts
InternalHosts           refile:/etc/opendkim/TrustedHosts
KeyTable                refile:/etc/opendkim/KeyTable
SigningTable            refile:/etc/opendkim/SigningTable

Mode                    sv
PidFile                 /var/run/opendkim/opendkim.pid
SignatureAlgorithm      rsa-sha256

UserID                  opendkim:opendkim

Socket                  inet:12301@localhost
```

Append the following line to `/etc/default/opendkim` to connect the milter to postfix.
```
SOCKET="inet:12301@localhost"
```


Make sure that these two lines are present in the Postfix config file `/etc/postfix/main.cf` and are not commented out:
```
milter_protocol = 2
milter_default_action = accept
```
It is likely that a filter (SpamAssasin, Clamav etc.) is already used by Postfix; if the following parameters are present, just append the opendkim milter to them (milters are separated by a comma), the port number should be the same as in opendkim.conf:
```
smtpd_milters = unix:/spamass/spamass.sock, inet:localhost:12301
non_smtpd_milters = unix:/spamass/spamass.sock, inet:localhost:12301
```
If the parameters are missing, define them as follows:
```
smtpd_milters = inet:localhost:12301
non_smtpd_milters = inet:localhost:12301
```
Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys:
```
mkdir /etc/opendkim
mkdir /etc/opendkim/keys
```
Specify trusted hosts in `/etc/opendkim/TrustedHosts`. Customize and add the following lines to the newly created file. Multiple domains can be specified, do not edit the first three lines:
```
127.0.0.1
localhost
192.168.0.1/24

*.example.com

#*.example.net
#*.example.org
```
Create a key table at `/etc/opendkim/KeyTable`:
```
mail._domainkey.example.com example.com:mail:/etc/opendkim/keys/example.com/mail.private
```

Create a signing table at `/etc/opendkim/SigningTable`. This file is used for declaring the domains/email addresses and their selectors.
```
*@example.com mail._domainkey.example.com
```

Generate the public and private keys

```bash
cd /etc/opendkim/keys
mkdir example.com # Create a separate folder for the domain to hold the keys
cd example.com
opendkim-genkey -s mail -d example.com # Generate the keys
chown opendkim:opendkim mail.private # Change the owner of the private key to opendkim
```
`-s` specifies the selector and `-d` the domain, this command will create two files, mail.private is our private key and mail.txt contains the public key.

## Add the public key to the domain’s DNS records
Open `mail.txt`. The public key is defined under the `p` parameter. Do not use the example key below, it’s only an illustration and will not work on your server.
```
mail._domainkey IN TXT "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5N3lnvvrYgPCRSoqn+awTpE+iGYcKBPpo8HHbcFfCIIV10Hwo4PhCoGZSaKVHOjDm4yefKXhQjM7iKzEPuBatE7O47hAx1CJpNuIdLxhILSbEmbMxJrJAG0HZVn8z6EAoOHZNaPHmK2h4UUrjOG8zA5BHfzJf7tGwI+K619fFUwIDAQAB" ; ----- DKIM key mail for example.com
```
Copy that key and add a TXT record to your domain’s DNS entries:
```
Name: mail._domainkey.example.com.

Text: "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5N3lnvvrYgPCRSoqn+awTpE+iGYcKBPpo8HHbcFfCIIV10Hwo4PhCoGZSaKVHOjDm4yefKXhQjM7iKzEPuBatE7O47hAx1CJpNuIdLxhILSbEmbMxJrJAG0HZVn8z6EAoOHZNaPHmK2h4UUrjOG8zA5BHfzJf7tGwI+K619fFUwIDAQAB"
```

## Restart services and test
```bash
service postfix restart
service opendkim restart
```

The configuration can be tested by sending an empty email to `check-auth@verifier.port25.com` and a reply will be received. If everything works correctly you should see DKIM check: pass under Summary of Results.
