#!/bin/bash

# Run this script to install and configure **openkdim** to work with
# **postfix** on a Debian/Ubuntu server.

# The following instructions come from Digitalocean's [How To Install and Configure DKIM with Postfix on Debian Wheezy](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy)

# Usage:
#	./$0 <domain-name>

# CONSTANTS
DOMAIN=$1
MSOCKET=inet:12301@localhost
POSTFIX_CONF='/etc/postfix/main.cf'

function die() {
	>&2 echo -e "\033[31m$1\033[0m"
	exit ${2:-1}
}

function build_regex() {
	sed \
	-e 's@[[:space:]]*=[[:space:]]*@\\s*=\\s*@g' \
	-e 's@^[[:space:]]*@^\\s*@'
}

# If line is not found in file, append line to file
function ensure_line() {
	local fpath=$1
	local content="${*:2}"
	local regex=`<<<"$content" build_regex`
	if ! grep --line-regexp --quiet "$regex" "$fpath"; then
		echo "${content[*]}" >> "$fpath"
	fi
}

[[ -n $DOMAIN ]] || die "ERR. Domain arg required"

# INSTALL
apt-get install -y opendkim opendkim-tools

## CONFIGURE
ensure_line "/etc/opendkim.conf" 'AutoRestart             Yes'
ensure_line "/etc/opendkim.conf" 'AutoRestartRate         10/1h'
ensure_line "/etc/opendkim.conf" 'UMask                   002'
ensure_line "/etc/opendkim.conf" 'Syslog                  yes'
ensure_line "/etc/opendkim.conf" 'SyslogSuccess           Yes'
ensure_line "/etc/opendkim.conf" 'LogWhy                  Yes'
ensure_line "/etc/opendkim.conf" 'Canonicalization        relaxed/simple'
ensure_line "/etc/opendkim.conf" 'ExternalIgnoreList      refile:/etc/opendkim/TrustedHosts'
ensure_line "/etc/opendkim.conf" 'InternalHosts           refile:/etc/opendkim/TrustedHosts'
ensure_line "/etc/opendkim.conf" 'KeyTable                refile:/etc/opendkim/KeyTable'
ensure_line "/etc/opendkim.conf" 'SigningTable            refile:/etc/opendkim/SigningTable'
ensure_line "/etc/opendkim.conf" 'Mode                    sv'
ensure_line "/etc/opendkim.conf" 'PidFile                 /var/run/opendkim/opendkim.pid'
ensure_line "/etc/opendkim.conf" 'SignatureAlgorithm      rsa-sha256'
ensure_line "/etc/opendkim.conf" 'UserID                  opendkim:opendkim'
ensure_line "/etc/opendkim.conf" 'Socket                  inet:12301@localhost'


# Connect the milter to postfix
ensure_line "/etc/default/opendkim" "SOCKET=\"$MSOCKET\""
ensure_line '/etc/postfix/main.cf' 'milter_protocol = 2'
ensure_line '/etc/postfix/main.cf' 'milter_default_action = accept'

# It is likely that a filter (SpamAssasin, Clamav etc.) is already used by Postfix; if the following parameters are present, just append the opendkim milter to them (milters are separated by a comma), the port number should be the same as in opendkim.conf:
if grep -P '^smtpd_milters\s*=.*$MSOCKET' "$POSTFIX_CONF"; then
	: # noop
elif grep -P '^smtpd_milters\s*=' "$POSTFIX_CONF"; then
	sed -i -e "s/^\(smtpd_milters\s*=.*\)$/\1, $MSOCKET/" "$POSTFIX_CONF"
else
	echo "smtpd_milters = $MSOCKET" >> "$POSTFIX_CONF"
fi
if grep -P '^non_smtpd_milters\s*=.*$MSOCKET' "$POSTFIX_CONF"; then
	: # noop
elif grep -P '^non_smtpd_milters\s*=' "$POSTFIX_CONF"; then
	sed -i -e "s/^\(non_smtpd_milters\s*=.*\)$/\1, $MSOCKET/" "$POSTFIX_CONF"
else
	echo "non_smtpd_milters = $MSOCKET" >> "$POSTFIX_CONF"
fi

# Create a directory structure that will hold the trusted hosts, key tables, signing tables and crypto keys:
mkdir -p /etc/opendkim/keys
[[ -s /etc/opendkim/TrustedHosts ]] && die "Expectation failed: /etc/opendkim/TrustedHosts is not empty"
cat <<-EOF >> /etc/opendkim/TrustedHosts
127.0.0.1
localhost
192.168.0.1/24
$DOMAIN
*.$DOMAIN
EOF

# Create a key table at `/etc/opendkim/KeyTable`
cat <<-EOF > /etc/opendkim/KeyTable
mail._domainkey.$DOMAIN $DOMAIN:mail:/etc/opendkim/keys/$DOMAIN/mail.private
EOF

# Create a signing table at `/etc/opendkim/SigningTable`. This file is used
# for declaring the domains/email addresses and their selectors.
cat <<-EOF > /etc/opendkim/SigningTable
*@$DOMAIN mail._domainkey.$DOMAIN
EOF

# Generate the public and private keys

mkdir -p /etc/opendkim/keys/$DOMAIN # Create a separate folder for the domain to hold the keys
cd /etc/opendkim/keys/$DOMAIN
opendkim-genkey -s mail -d $DOMAIN # Generate the keys
chown opendkim:opendkim mail.private # Change the owner of the private key to opendkim

## Restart services
service postfix restart
service opendkim restart

## Instructions to add the public key to the domain’s DNS records
echo -e "\033[33mCopy the following public key and add a TXT record to your domain's DNS entries, named \033[0mmail._domainkey.$DOMAIN\033[33m:\033[0m"
cat mail.txt
echo

## Instructions to test
echo -e "\033[33mThe configuration can be tested by sending an empty email to \033[0mcheck-auth@verifier.port25.com\033[33m and a reply will be received. If everything works correctly you should see DKIM check: pass under Summary of Results.\033[0m"
