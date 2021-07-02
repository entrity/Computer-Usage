# Chroot jails

Add specific users to a `chrootjail` group and then reference that group in your ssh config.

## /etc/ssh/sshd_config
```
Match Group chrootjail
  ChrootDirectory /mnt/crypted/chrootjails/%u
  ForceCommand internal-sftp -l INFO
  AuthorizedKeysFile /mnt/crypted/chrootjails/%u/home/%u/.ssh/authorized_keys
  X11Forwarding no
  AllowTcpForwarding no
  PasswordAuthentication no
```

## Jail resources
Hardlink or copy these files into the jail. I actually copy them into the jails' parent dir, then hardlink them into the jails
```
bin/bash
lib64/libc.so
lib64/libtinfo.so
lib64/ld-linux-x86-64.so.2
lib64/libdl.so.2
lib64/libc.so.6
lib64/libdl.so
lib64/libtinfo.so.5
```

## Adding additional jails as subdirectories
```bash
user=$1
cd "$JAILS_PARENT"
mkdir -p "$user/bin" "$user/lib64" "$user/home/$user"
find bin lib64 -type f | while read f; do
  ln "$f" "$user/$f" || >&2 echo -e "\033[31merr $f\033[0m"
done
usermod -aG chrootjail "$user"
usermod -d "/home/$user" "$user"
chown -R "$user:$user" "$user/"*
chmod -R -w "$user/bin" "$user/lib64"
ln -s /var/www/
```

## Troubleshooting
* Ensure the chroot dir itself is owned by `root`
* Ensure the permissions on the dirs beneath the chroot are owned by the user
* Ensure the user's home is `/home/$user/`
* Ensure the permissions on `/home/$user/.ssh` are `0700`
* Ensure the permissions on `/home/$user/.ssh/authorized_keys` are `0600`
