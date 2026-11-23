#!/usr/bin/env bash
# Reconstructed from the lab report screenshots (Figures 7.3.1 to 7.3.6).
# The user and directory names are renamed (labuser, lab_share); the report used a
# team member's first name.

sudo dnf install samba samba-client -y

sudo mkdir -p /srv/samba/lab_share
sudo chown -R labuser:labuser /srv/samba/lab_share
sudo chmod -R 755 /srv/samba/lab_share

sudo smbpasswd -a labuser            # prompts twice for the SMB password

sudo firewall-cmd --permanent --add-service=samba
sudo firewall-cmd --reload
sudo systemctl enable --now smb nmb

# Rocky runs SELinux in Enforcing mode; label the share so smbd may use it.
sudo chcon -t samba_share_t /srv/samba/lab_share
