```
# AddEncoding allows you to have certain browsers uncompress information on the fly.
AddEncoding gzip .gz

#Serve gzip compressed CSS files if they exist and the client accepts gzip.
RewriteCond %{HTTP:Accept-encoding} gzip
RewriteCond /var/www/dataraptor/current/public/%{REQUEST_URI}\.gz -s
RewriteRule ^(.*)\.css $1\.css\.gz [QSA]

# Serve gzip compressed JS files if they exist and the client accepts gzip.
RewriteCond %{HTTP:Accept-encoding} gzip
RewriteCond /var/www/dataraptor/current/public/%{REQUEST_URI}\.gz -s
RewriteRule ^(.*)\.js $1\.js\.gz [QSA]

# Serve correct content types, and prevent mod_deflate double gzip.
RewriteRule \.css\.gz$ - [T=text/css,E=no-gzip:1]
RewriteRule \.js\.gz$ - [T=text/javascript,E=no-gzip:1]
```
