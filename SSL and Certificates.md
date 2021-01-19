```bash
openssl s_client -showcerts -connect the-server:443
```

```bash
trust list
```


## Certbot & letsencrypt.org

Install

```bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
```

```bash
sudo apt-get install certbot python-certbot-apache
sudo certbot --apache
```
(If you only set up port 80 for a site, this will go ahead and create the 443 config, based on your port-80 config, and also give you the option of adding RewriteRules.)


## Getting Chrome/Chromium to trust your cert
You need to import a CA cert (not an SSL cert). You need to use that CA cert to sign your SSL cert (which you will then use in your HTTPS server).

```bash
NAME=reg.qa

######################
# Create config files for certs
######################

>$NAME.conf cat <<-EOF
[req]
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
C = US
ST = CA
O = My Jenkins Installation
OU = Web Test
CN = $NAME
EOF
# Create a config file for the extensions
>$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment, keyCertSign
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Yes, you actually have to specify this b/c browser don't care about CN anymore
IP.1 = 172.18.0.2
IP.2 = 172.18.0.4
EOF

######################
# Become a Certificate Authority
######################

# Generate private key
>&2 echo Generate CA private key
[[ -e myCA.key ]] || openssl genrsa -des3 -out myCA.key 2048 || exit 1
# Generate root certificate
>&2 echo Generate CA root cert
[[ -e myCA.pem ]] || openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem -config $NAME.conf || exit 2

######################
# Create CA-signed certs
######################

# Generate private key
>&2 echo Generate private key
[[ -e $NAME.key ]] || openssl genrsa -out $NAME.key 2048 || exit 4
# Create certificate-signing request
>&2 echo Generate cert-signing request
[[ -e $NAME.csr ]] || openssl req -new -key $NAME.key -out $NAME.csr -config $NAME.conf || exit 5

# Create the signed certificate
>&2 echo Generate signed cert
openssl x509 -req -in $NAME.csr \
-CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out $NAME.crt -days 1825 -sha256 -extfile $NAME.ext \
|| exit 6
```

### Checking that cert, key, and csr match
```bash
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum
```
