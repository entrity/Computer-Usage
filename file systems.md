# File systems

## Samba shares
List shares
`smbclient -L <host> [-U <user> [password]]`
Mount (one time)
`mount -t cifs //<host>[/<remotedir>] <abspathlocaldir>`
E.g.
`sudo mount -t cifs //wdmycloud.local/mar /home/markham/mnt -o username=mar,uid=1000,nounix`
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQ4ODE1MjUyNiwtNTU3NDAzMTkxXX0=
-->

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
