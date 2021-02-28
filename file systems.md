# File systems

## SMB
List shares
`smbclient -L <host> [-U <user> [password]]`
Mount (one time)
`mount -t cifs //<host>[/<remotedir>] <abspathlocaldir>`
E.g.
`sudo mount -t cifs //wdmycloud.local/mar /home/markham/mnt -o username=mar,uid=1000,nounix`

## Mount Google Drive, Dropbox, etc
`rclone` is an option that you can get through your package manager without adding a PPA.

It is a command-line tool for working with various cloud storage services including Google Drive, Amazon S3, Dropbox, Box... and it can be used to mount your Google Drive as a virtual file system:
```bash
sudo apt install rclone
rclone config # See config process below
mkdir ~/drive
rclone mount $NAME_OF_RCLONE_REMOTE: ~/drive/
```

See a more detailed walkthrough at https://ostechnix.com/how-to-mount-google-drive-locally-as-virtual-file-system-in-linux/

**Commands**
```bash
# Add/edit cloud services
rclone configure
rclone sync source:path dest:path [flags]
# Good flags include -P/--progress, --dry-run, -i/--interactive
rclone move source:path dest:path [flags]
rclone ls remote:path
rclone lsl remote:path
rclone listremotes
rclone md5sum remote:path
rclone delete remote:path
rclone dedupe remote:path
rclone about remote:path
rclone cat remote:path
# Make dir if non-existent
rclone mkdir remote:path
# Remove path if empty
rclone rmdir remote:path
# ...
```

rclone config
rclone copy
rclone sync
rclone move
rclone delete
rclone purge
rclone mkdir
rclone rmdir
rclone check
rclone ls
rclone lsd
rclone lsl
rclone md5sum
rclone sha1sum
rclone size
rclone version
rclone cleanup
rclone dedupe
rclone about
rclone authorize
rclone cachestats
rclone cat
rclone config create
rclone config delete
rclone config disconnect
rclone config dump
rclone config edit
rclone config file
rclone config password
rclone config providers
rclone config reconnect
rclone config show
rclone config update
rclone config userinfo
rclone copyto
rclone copyurl
rclone cryptcheck
rclone cryptdecode
rclone dbhashsum
rclone deletefile
rclone genautocomplete
rclone genautocomplete bash
rclone genautocomplete zsh
rclone gendocs
rclone hashsum
rclone link
rclone listremotes
rclone lsf
rclone lsjson
rclone mount
rclone mount vs rclone sync/copy
rclone moveto
rclone ncdu
rclone obscure
rclone rc
rclone rcat
rclone rcd
rclone rmdirs
rclone serve
rclone serve dlna
rclone serve ftp
rclone serve http
rclone serve restic
rclone serve sftp
rclone serve webdav
rclone settier
rclone touch
rclone tree

