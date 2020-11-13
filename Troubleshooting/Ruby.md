# Troubleshooting Ruby

---
## Caused by Resolv::ResolvError: no address for ...
```ruby 
# Ensure that this works with a trusted nameserver
Resolv.new([DNS.new({nameserver: '8.8.8.8'})]).getaddress('testapi.assurity.com')
# See if this works with the standard nameserver
Resolv.new([DNS.new({nameserver: '127.0.0.53'})]).getaddress('testapi.assurity.com')
```
Check your `/etc/resolv.conf`. Is the first entry `nameserver 127.0.0.53`? If not, make that edit.

If all else fails, restart the computer.
