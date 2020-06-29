# Linode

## Networking not working

_cf_ https://www.linode.com/community/questions/323/my-linode-is-unreachable-after-maintenance

1. I recommend enabling [Network Helper](https://www.linode.com/docs/platform/network-helper/) (on an individual server basis, not globally).
1. Reboot.
1. Ensure there's no static file in `/etc/sysconfig/network-scripts`, e.g. `ifcfg-static-eth0`
1. If necessary `systemctl restart network.service`

Test by using the Lish console and see if you can reach _outward_ to the network: `ping stanford.edu`
