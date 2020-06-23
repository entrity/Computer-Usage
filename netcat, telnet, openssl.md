# Internet

## openssl

### Test requests against HTTPS endpoints
```bash
cat $REQUEST_FILE | openssl s_client -connect $DOMAIN:$PORT -ign_eof
```

Without the `-ign_eof` (ignore EOF) param, `s_client` would terminate as soon as the input closes.

### Test SMTP

```bash
openssl s_client -quiet -connect smtp.office365.com:587 -crlf -starttls smtp
# Some output, ending with something like:
# 250 SMTPUTF8
EHLO insureio.com
# Some output, ending with a repeat of:
# 250 SMTPUTF8
AUTH LOGIN # or AUTH PLAIN
# 334 VXNlcm5hbWU6 (requesting Username:)
# Enter output of `echo -n $USER | base64`
# 334 UGFzc3dvcmQ6 (requesting Password:)
# Enter output of `echo -n $PASS | base64`
# 235 2.7.0 Authentication successful
```

## nc

### View a raw curl request
```bash
# start a netcat server listening on localhost
nc -l 8080 &
# make the curl connection actually go to localhost
curl -q --data-binary $BODY --connect-to ::localhost:8080 http://example.com/path
```
