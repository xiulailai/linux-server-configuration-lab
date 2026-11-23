#!/usr/bin/env bash
# Reconstructed from the lab report screenshots. (Figures 4.8.1 to 4.8.3, 4.11.2)
# Commands only; no output was captured for the semanage/restorecon steps.

sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/web1.bungkus.org(/.*)?"
sudo restorecon -Rv /var/www/web1.bungkus.org/
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/web2.bungkus.org(/.*)?"
sudo restorecon -Rv /var/www/web2.bungkus.org/
sudo setsebool -P httpd_can_network_connect on

# Troubleshooting fix: repoint the default ssl.conf at a certificate that exists.
# NOTE: the report points it at tapauserver.bungkus.org.crt/.key, but the certificates
# generated earlier are named web1.bungkus.org.* and web2.bungkus.org.*. See docs.
sudo sed -i 's|/etc/pki/tls/certs/localhost.crt|/etc/pki/tls/certs/tapauserver.bungkus.org.crt|g' /etc/httpd/conf.d/ssl.conf
sudo sed -i 's|/etc/pki/tls/private/localhost.key|/etc/pki/tls/private/tapauserver.bungkus.org.key|g' /etc/httpd/conf.d/ssl.conf
