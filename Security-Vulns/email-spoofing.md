# Email spoofing

> I just sent a forged email to my email address that appears to originate from support@Insureio.com I was able to do this because of the following DMARC record:
DMARC record lookup and validation for: Insureio.com

> "No DMARC Record found"
> Or/And
> "No DMARC Reject Policy"

## Fix
1) Publish DMARC Record. (If not already published)
2) Enable DMARC Quarantine/Reject policy
3) Your DMARC record should look like "v=DMARC1; p=reject; sp=none; pct=100; ri=86400; rua=mailto:info@domain.com"

You can check your DMARC record form here:
https://mxtoolbox.com/SuperTool.aspx?action=mx%3alition.io&run=toolpage

Reference: https://www.knownhost.com/wiki/email/troubleshooting/setting-up_spf-dkim-dmarc_records

DMARC is a specially formatted TXT DNS record.
