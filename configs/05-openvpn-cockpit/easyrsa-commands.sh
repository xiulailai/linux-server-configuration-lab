#!/bin/bash
# Reconstructed from the lab report screenshots (Figures 5.3.1.3 to 5.3.1.9).
# This is a record of the commands, not a script the report ran. The report does not show a
# vars file, so no easy-rsa settings were changed; the defaults were used. The visible
# defaults were a 2048-bit DH parameter and 825-day certificates.
# Run from /usr/share/easy-rsa/3 (the report's prompt shows directory "3").

sudo ./easyrsa init-pki
sudo ./easyrsa build-ca                       # CN tapauserver_CA, protected by a CA passphrase (CHANGE_ME)
sudo ./easyrsa build-server-full tapauserver1 nopass
sudo ./easyrsa build-client-full tapauclient1 nopass
sudo ./easyrsa gen-dh
sudo openvpn --genkey secret ./pki/ta.key
sudo cp -pR /usr/share/easy-rsa/3/pki/{issued,private,ca.crt,dh.pem,ta.key} /etc/openvpn/server/
