## Putting resources in alternate directories

```bash
# Download and extract resources to ./usr/include and ./usr/lib
apt download libimlib2
dpkg -x libimlib2_1.4.10-1_amd64.deb
apt download libimlib2-dev
dpkg -x libimlib2-dev_1.4.10-1_amd64.deb

# Set flags which make will use
export CFLAGS=-Iusr/include
export CPPFLAGS=$CFLAGS
export LDFLAGS=-Lusr/lib

# Call make
make
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3NzcyNjAyMjhdfQ==
-->