#!/bin/bash
# /etc/openvpn/server/add-bridge.sh
# Reconstructed from the lab report screenshots (Figure 5.3.1.22 and the revised file in Figure 5.6.3.9).
# This is the revised version from Figure 5.6.3.9, which is the one in place when the service started.
# The first draft (Figure 5.3.1.22) was the same except for two things: the masquerade and
# add-port lines ended in "--permanent", and the file ended with a "firewall-cmd --reload" line.
# The revised file is shown cut off at the add-port line, so any lines after it are unknown.
# Needs chmod 700 (see the runbook).

# network interface which can connect to local network
IF=ens160
# interface VPN tunnel uses
# for the case of this example like specifying [tun] on the config, generally this param is [tun0]
VPNIF=tun0
# listening port of OpenVPN
PORT=1194

firewall-cmd --zone=public --add-masquerade
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i ${VPNIF} -o ${IF} -j ACCEPT
firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o ${IF} -j MASQUERADE
firewall-cmd --add-port=${PORT}/udp
