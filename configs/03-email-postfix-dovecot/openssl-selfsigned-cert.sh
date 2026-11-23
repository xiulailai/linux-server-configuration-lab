#!/usr/bin/env bash
# Reconstructed from the lab report screenshots (Figures 3.6.1 - 3.6.4).
# Self-signed certificate for the mail server. -nodes means the private key has NO
# passphrase (required so Postfix and Dovecot can start unattended). The key itself
# is never published; only the commands are recorded here.

sudo openssl req -newkey rsa:2048 -nodes \
  -keyout /etc/pki/tls/private/mailserver.key \
  -x509 -days 1095 \
  -out /etc/pki/tls/certs/mailserver.crt

# Answers given at the prompts (Figure 3.6.2):
#   Country Name:            JP
#   State or Province:       Hiroshima
#   Locality:                Hiroshima
#   Organization:            Bungkus
#   Organizational Unit:     IT
#   Common Name:             tapauserver.bungkus.org
#   Email Address:           root@bungkus.org

sudo chmod 600 /etc/pki/tls/private/mailserver.key
sudo chmod 644 /etc/pki/tls/certs/mailserver.crt

# Check the subject (Figure 3.6.4)
openssl x509 -in /etc/pki/tls/certs/mailserver.crt -text -noout | grep -A2 "Subject:"
