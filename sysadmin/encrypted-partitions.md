# Encrypted partitions

```bash
DEVICE="/dev/disk/by-id/scsi-0Linode_Volume_chroot-jails"
PARTITION="/dev/disk/by-id/scsi-0Linode_Volume_chroot-jails-part1"
# Install cryptsetup
yum install cryptsetup
# List partitions, if any, on device
fdisk -l "$DEVICE"
# Interactive prompts to create a new partition: n, p, 1, 2048, <default>, w
fdisk "$DEVICE" # Creates "$PARTITION"
# Encrypt partition
cryptsetup luksFormat "$PARTITION"
cryptsetup open "$PARTITION" encrypted
# Create a filesystem on the new partition
mkfs.ext4 "/dev/mapper/encrypted"
# Create a mountpoint
mkdir "/mnt/chroot-jails"
```

## (Re-)mounting the new volume
```bash
cryptsetup --type luks open "$PARTITION" encrypted
mount -t ext4 "/dev/mapper/encrypted" "/mnt/chroot-jails"
```
Confirm that the mount is encrypted by running `dmsetup status` or `cryptsetup status /dev/mapper/encrypted`.
