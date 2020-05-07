# Internet

## openssl

### Test requests against HTTPS endpoints
```bash
cat $REQUEST_FILE | openssl s_client -connect $DOMAIN:$PORT -ign_eof
```

Without the `-ign_eof` (ignore EOF) param, `s_client` would terminate as soon as the input closes.

## nc

### View a raw curl request
```bash
# start a netcat server listening on localhost
nc -l 8080 &
# make the curl connection actually go to localhost
curl -q --data-binary $BODY --connect-to ::localhost:8080 http://example.com/path
```
