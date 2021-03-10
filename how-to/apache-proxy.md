# Apache Proxy

## Setting up a forward proxy on Apache
```
  Listen 3443

  <VirtualHost *:3443>
    ProxyRequests on
    <Proxy *>
      Require ip X.X.X.X # Optionally restrict usage to requests from these IPs
      Require ip Y.Y.Y.Y
    </Proxy>
  </VirtualHost>
```

## Using the proxy

When using the proxy, treat it as an `https_proxy` if connecting to an `https` site or an `http_proxy` if connecting to an `http` site

...**BUT** regardless of what scheme the target site uses, specify the proxy using the `http` scheme. E.g.:

```bash
curl https_proxy=http://myserver.com:3443/ https://targetsite.com
```

## Restrict proxy to credentials
```
<Proxy *>
  Allow from all
  AuthType Basic
  AuthName "Password Required"
  AuthUserFile .proxypasswd
  Require valid-user
</Proxy>
```

### Setting up credentials for proxy

```bash
# Choose whatever filename/path you like. I used .proxypasswd
htpasswd -c .proxypasswd markham # Will create file and prompt for passwd
htpasswd .proxypasswd matt # Will prompt for passwd
```
