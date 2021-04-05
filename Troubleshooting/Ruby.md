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

  In insureio, this error also shows up as:
  * Unable to send to recipient ...  Seahorse::Client::NetworkingError Failed ...
  * expected: "Dispatched emails to 1 of 2 recipients."
         got: "Dispatched emails to 0 of 2 recipients."

----
## ArgumentError: must specify a key

This has popped up when doing sundry tasks, e.g. `as_json` for models with `attr_encrypted` when the key is nil. Just set the key.

----
## Ruby on Rails: post body/params is empty when posting a large payload/file

This was actually an Apache issue, and enabling mod_security
