#!/usr/bin/env bash
# Reconstructed from the lab report screenshots. (Figures 4.6.3 to 4.6.6)
# Private keys are never published; only the commands are recorded.
# -nodes leaves the key without a passphrase so httpd can start unattended.

sudo mkdir -p /etc/pki/tls/certs /etc/pki/tls/private

# web1: the screenshot shows NO -days option, so OpenSSL used its default of 30 days.
# The certificate viewed in Firefox (Figure 4.10.12) is valid 27 Apr to 27 May 2026.
sudo openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout /etc/pki/tls/private/web1.bungkus.org.key \
  -out /etc/pki/tls/certs/web1.bungkus.org.crt

# web2: this one does pass -days 365
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/pki/tls/private/web2.bungkus.org.key \
  -out /etc/pki/tls/certs/web2.bungkus.org.crt

# Answers entered at the prompts for both certificates:
#   Country Name:            JP
#   State or Province:       Hiroshima
#   Locality:                Hiroshima
#   Organization:            Bungkus
#   Organizational Unit:     IT
#   Common Name:             tapauserver.bungkus.org   (not web1/web2; see docs)
#   Email Address:           root@bungkus.org
