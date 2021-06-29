# Networks

## mininet

An emulation system for easy, safe testing on your own computer.

## cli network commands

### nmcli (Network Manager CLI) 
```bash
nmcli radio wifi off # Turn off wifi
nmcli dev wifi # List networks
nmcli dev wifi rescan # Then wait, then re-try `nmcli dev wifi`
```

## scapy
> Scapy is a packet manipulation tool for computer networks, originally written in Python by Philippe Biondi. It can forge or decode packets, send them on the wire, capture them, and match requests and replies. It can also handle tasks like scanning, tracerouting, probing, unit tests, attacks, and network discovery.

NB: consider ARP spoofing to bypass the OS kernel's TCP stack. cf:
* http://jvns.ca/blog/2014/08/12/what-happens-if-you-write-a-tcp-stack-in-python/
* http://jvns.ca/blog/2013/10/29/day-18-in-ur-connection/
* https://news.ycombinator.com/item?id=8167546
