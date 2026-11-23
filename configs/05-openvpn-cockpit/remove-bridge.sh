#!/bin/bash
# /etc/openvpn/server/remove-bridge.sh
# Reconstructed from the lab report screenshots (Figure 5.3.1.24).
# Complete as shown. This is the first-draft version. The report revised add-bridge.sh to drop
# "--permanent" but does not show a revised remove-bridge.sh, so the two may not match.

# network interface which can connect to local network
IF=ens160
# interface VPN tunnel uses
# for the case of this example like specifying [tun] on the config, generally this param is [tun0]
VPNIF=tun0
# listening port of OpenVPN
PORT=1194

firewall-cmd --zone=public --remove-masquerade --permanent
firewall-cmd --direct --remove-rule ipv4 filter FORWARD 0 -i ${VPNIF} -o ${IF} -j ACCEPT
firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -o ${IF} -j MASQUERADE
firewall-cmd --remove-port=${PORT}/udp --permanent
firewall-cmd --reload
