# yum

A package manager for CentOS and other RPM distros of Linux.

```bash
yum provides $FILE # Which package provides the file (whether installed or not)
yum info $PACKAGE # Version, installed, etc
yum list installed
yum install $PACKAGE
yum remove $PACKAGE
yum clean all # Clear cache
yum makecache fast # Rebuild cache
```
