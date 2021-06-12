# Setting up a mail server

## Test the rejectability of your emails
Send an email to mail-tester.com, and it will show you the raw email as well as a checklist for tasks to make it less suspicious, e.g. setting up DNS PTR records.

1. Visit https://www.mail-tester.com/. The home page gives you an email address to which to send your message, e.g. `test-xepg6s2cs@srv1.mail-tester.com`
2. Go to your server and send off an email, e.g.
```bash
echo test body | mailx -r noreply@mydomain.com -s 'test subject' test-xepg6s2cs@srv1.mail-tester.com
```
3. Go back to mail-tester.com and click the button to view your raw email, checklist, and score.


## SPF record
> Sender Policy Framework (SPF) is an email validation system designed to prevent email spam by detecting email spoofing, a common vulnerability, by verifying sender IP addresses.

* [Add your SPF record at your domain provider](https://support.google.com/a/answer/10684623)
* [Define your SPF record—Advanced setup](https://support.google.com/a/answer/10683907)

To turn on SPF for your domain, add a DNS TXT record at your domain provider. (After adding an SPF record, it can take up to 48 hours for SPF authentication to start working.)
e.g. `v=spf1 ip4:200.240.140.60 ~all`

## DKIM signing
> DomainKeys Identified Mail (DKIM) is a method for associating a domain name to an email message, thereby allowing a person, role, or organization to claim some responsibility for the message.

See ./opendkim.md

## DMARC record
> A DMARC policy allows a sender to indicate that their emails are protected by SPF and/or DKIM, and give instruction if neither of those authentication methods passes. Please be sure you have a DKIM and SPF set before using DMARC.

Add a TXT record to your domain `_dmarc.mydomain.com` with the following value: `v=DMARC1; p=none`

## Reverse DNS lookup
> Reverse DNS lookup or reverse DNS resolution (rDNS) is the determination of a domain name that is associated with a given IP address. Some companies such as AOL will reject any message sent from a server without rDNS, so you must ensure that you have one.
You cannot associate more than one domain name with a single IP address.

1. Set up an rDNS record (on the server)
2. Make sure your hostname (or postfix `myhostname`) matches the domain name.
```bash
postconf -e "myhostname = example.com"
postconf mydomain # => com
systemctl restart postfix
```
