# Libs troubleshooting

---
After upgrading Ubuntu (and ticking the box to remove obsolete packages), my Ruby gives an error when trying to `require 'openssl.so'`:

> /home/me/.rbenv/versions/2.6.6/lib/ruby/2.6.0/openssl.rb:13:in require': libssl.so.1.0.0: cannot open shared object file: No such file or directory - /home/me/.rbenv/versions/2.6.6/lib/ruby/2.6.0/x86_64-linux/openssl.so (LoadError)

**Solution**: Add old ppa to sources list. Then use apt to re-download the old package.

```bash
echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' > /etc/apt/sources.list.d/ubuntu18.list
apt update
apt install libssl1.0.0
# Also install other dependencies that went missing:
apt install libmysqlclient20
echo 'deb http://us.archive.ubuntu.com/ubuntu/ bionic main restricted' >> /etc/apt/sources.list.d/ubuntu18.list
apt update
apt install libreadline7
```
Other packages went missing after the Ubuntu 20.10 upgrade. I didn't care to add sources. I just downloaded and installed with `dpkg`:
```bash
# https://packages.ubuntu.com/focal/amd64/libffi7/download
dpkg -i libffi7_3.3-4_amd64.deb
```
