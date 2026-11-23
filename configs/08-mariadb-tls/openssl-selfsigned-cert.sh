#!/usr/bin/env bash
# Reconstructed from the lab report screenshots. (Figures 8.5.1 to 8.5.4)
# The private key is never published; only the commands are recorded.

sudo mkdir -p /etc/mysql/certs
sudo openssl req -x509 -nodes \
  -keyout /etc/mysql/certs/mariadb.key \
  -out /etc/mysql/certs/mariadb.crt \
  -days 365 -newkey rsa:2048

# Answers entered at the prompts:
#   Country Name:            JP
#   State or Province:       Hiroshima
#   Locality:                Hiroshima
#   Organization:            Bungkus
#   Organizational Unit:     IT
#   Common Name:             tapauserver.bungkus.org
#   Email Address:           root@bungkus.org

sudo chmod 644 /etc/mysql/certs/mariadb.crt
sudo chmod 600 /etc/mysql/certs/mariadb.key
sudo chown -R mysql:mysql /etc/mysql/certs/
