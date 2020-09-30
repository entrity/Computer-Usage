# SELinux

## Get status ENFORCING|PERMISSIVE|DISABLED

```bash
getenforce # => Enforcing|Permissive|Disabled
selinuxenabled # Exits 0 if true
sestatus # Dumps more info
```

```bash
# Security context is formatted as user:role:type:mls
ls -Z # `ls` with security context
ps axZ # `ps ax` with security context
```

## Change access

```bash
# Change security context of file/dir. Only lasts until the modified portion of the filesystem is re-labeled. Write a custom local rule to persist further.
chcon [-Rv] --type=httpd_sys_content_t my_file_or_dir
# Make permanent security context changes
semanage fcontext -a -t httpd_sys_content_t "/html(/.*)?"
# Allow access to a port
semanage port -a -t http_port_t -p tcp 81
# List port permissions
semanage port -l
# Restore default securit contexts
restorecon [-Rv] [-n] /var/www/html
```

## Disable/Enable SELinux

For immediate changes, which do not persist across reboots, the `setenforce` command may be used to switch between Enforcing and Permissive modes on the fly.

For changes to persist across reboots, edit `/etc/selinux/config`, then reboot.

```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected. 
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

## Targetted mode

In `targetted` mode, there are 4 forms of access control, of which `type` is the default. Access is only allowed between similar types.