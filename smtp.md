# SMTP

## Test with openssl s_client
### Usual back-and-forth
```bash
echo -ne "\0$USER\0$PASS" | base64 | xsel -i -b
openssl s_client -starttls smtp -connect smtp.sendgrid.com:587
```
```
# 250 AUTH=PLAIN LOGIN
EHLO
# 250 AUTH=PLAIN LOGIN
AUTH PLAIN <B64-USER-PASS>
```

### Gmail
```bash	
openssl s_client -starttls smtp -connect smtp.gmail.com:587
```
```
# 250 SMTPUTF8
AUTH LOGIN
# 334 VXNlcm5hbWU6
<B64-USER>
# 334 UGFzc3dvcmQ6
<B64-PASS>
```

## Troubleshooting Gmail
---
> <https://accounts.google.com/signin/continue?sarp=1&scc=1&plt=AKgnsbu
v59rhsru16xuz7TtTQtLZ4nHOsBYh4DycU7I-LLD7cJh6LvLMjzYud1wVzR3EQI71x8d3
7tfvDiNuaUHtrdp_t8zuyiw2LN7VTpE2yueAsQffJhVr9mB4h14HGmsVw8cs1dYf>
Please log in via your web browser and then try again.
 Learn more at
 https://support.google.com/mail/answer/78754 f132sm7704618qke.104 - gsmtp

The link above will take you to a page that you can click to 'enable account access'. This allowed my signin to work from a new server.
