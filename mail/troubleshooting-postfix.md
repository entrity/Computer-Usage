# Troubleshooting Postfix

View:
- `/var/log/mail.log` Yes, even this one
- `/var/log/mail.err`
- `/var/log/daemon.log`

---
`/var/log/mail.log` says:
> connect to gmail-smtp-in.l.google.com[2607:f8b0:400d:c01::1b]:25: Network is unreachable

I updated `/etc/postfix/main.cnf` to replace `inet_protocols = all` with `inet_protocols = ipv4`. (Externally, my machine has only an ipv4 address).

---
`/var/log/mail.log` says:
> May 12 03:23:12 jumpingbilly postfix/smtp[4178586]: 4A360659: host mx-aol.mail.gm0.yahoodns.net[67.195.228.86] said: 421 4.7.0 [TSS04] Messages from 209.141.40.67 temporarily deferred due to unexpected volume or user complaints - 4.16.55.1; see https://postmaster.verizonmedia.com/error-codes (in reply to MAIL FROM command)

I don't know. Maybe adding a PTR record (at the hosting company, not at the DNS registrar) will help.

---
`/var/log/mail.log` says:
> May 12 03:13:12 jumpingbilly postfix/smtp[4178281]: 4A360659: host mx-ao
l.mail.gm0.yahoodns.net[67.195.204.75] said: 421 4.7.0 [TSS04] Messages 
from 209.141.40.67 temporarily deferred due to unexpected volume or user
 complaints - 4.16.55.1; see https://postmaster.verizonmedia.com/error-c
odes (in reply to MAIL FROM command)

I don't know. Maybe adding a PTR record (at the hosting company, not at the DNS registrar) will help.
