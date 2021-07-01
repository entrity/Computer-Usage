# Encrypted partitions

## Create a new partition
```bash
df -h # Find the current device and partition you want to resize (shrink)
umount / # Unmount chosen partition
fdisk 
```


```bash
sudo yum install cryptsetup
```