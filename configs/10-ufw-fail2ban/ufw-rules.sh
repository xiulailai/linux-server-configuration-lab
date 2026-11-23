#!/bin/bash
# Reconstructed from the lab report (Figure 10.3.1): the UFW commands as typed on the
# Ubuntu client. UFW stores rules in /etc/ufw/*.rules; the report shows only these commands
# and the resulting "ufw status" output, not the rules files.
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp        # SSH
sudo ufw allow 8080/tcp      # nginx
sudo ufw allow 8081/tcp      # adminer
sudo ufw enable
sudo ufw status verbose
