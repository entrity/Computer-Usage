# OAuth

## As used at Assurity

1. Get an access token
2. Use access token to access API

### Get an access token

Make a POST to the access-token URL, providing parameters and a Basic authorization header:

```bash
curl -X POST \
-H "Authorization: Basic dXNlcjpwYXNzCg==" \
-H "Content-type: application/x-www-form-urlencoded" \
-d 'grant_type=client_credentials&scope=Form' \
"https://testauth.assurity.com/connect/token"
# Outputs an access token
```

### Use the access token

```bash
curl -X GET \
-H "Authorization: Bearer ${MY_ACCESS_TOKEN}" \
"https://testauth.assurity.com/v2/some_endpoint"
```
