# CGI

Your cgi file may be binary or a script.

## Execute on command line

The query string is obtained through the environment variable QUERY_STRING, and the POST body is obtained by reading stdin.

```bash
export QUERY_STRING='foo=bar&baz=qux'
echo -n "the post body" | ./myscript.cgi
```

## Config in Apache
1. Enable the cgi and/or cgid modules. In Apache2.4, symlink these .load/.conf files from mods-available to mods-enabled.
2. Use something like the following in your VirtualHost config:
```
ScriptAlias /cgi-bin/ /var/www/compulife/cgi-bin/
<Directory /var/www/compulife/cgi-bin>
  Options ExecCGI
  AddHandler cgi-script .cgi .pl .py .rb
</Directory>
```
