## SSH

- `-X`  Enables X11 (display) forwarding. (But this allows an attacker to listen to my keystrokes.)
- create a pipe between machines

## SSHD

### chroot jail

I set up the following in `/etc/ssh/sshd_config`
```
Match Group chrootjail
	ChrootDirectory /var/chrootjail/
	PasswordAuthentication no
	AuthorizedKeysFile /var/chrootjail/home/%u/.ssh/authorized_keys
```

To make the jail have an interface, though, I needed to copy `/bin/bash` into the jail and also its dependencies, which are given from `ldd /bin/bash`.

I also had to create the `/var/chrootjail/home` directory and create a user and set his home directory and set his group membership.

## SSHFS

```bash
# Mount a remote directory:
sshfs ${user}@${host}:${path} $mydir
# "path" can be absolute or relative to the user's $HOME
# "user@host" can be an alias from .ssh/config
# "mydir" should be an empty local directory

# Unmount the directory:
fusermount -u $mydir 
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTU5NjA3ODU5LC04NDIxMjMzMzgsMTcyMT
I5MDgzMF19
-->

## FTP

```bash
python -m pyftpdlib [--help]
python -m pyftpdlib -w -u <uname> -P <pass>
```

## Reverse Shell
### Echo only
```bash
# target terminal A
ssh -R -N 8888:localhost:8888 qa
# target terminal B
nc -l localhost 8888
# bridge server
nc localhost 8888 # Then enter text
```
### Execute only
```bash
# target terminal A
ssh -R -N 8888:localhost:8888 qa
# target terminal C
mkfifo nci
nc -l localhost 8888 >nci
# target terminal C
/bin/bash -i 0<nci
# bridge server
nc localhost 8888 # then enter commands, whose output appears on target:C
```
