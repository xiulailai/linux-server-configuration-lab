# Linux Server Configuration Lab

A small company network built from two virtual machines: a **Rocky Linux 9.7 server** that provides the network services, and an **Ubuntu 24.04 client** that uses them. The lab covers the core services of a network (DNS, DHCP, secure mail, secure web) and six extras (VPN with Cockpit, Docker, Samba, MariaDB with TLS, ClamAV, and a firewall with intrusion banning).

Built as a group lab for Systems and Network Administration (CT106-3-2) at Asia Pacific University (APU), on VirtualBox. This repository turns the lab report into a runbook for each service, with the working configuration files and screenshots recovered from the report. The domain `bungkus.org`, the hostnames and the addresses are fictional lab values.

## The network

```
                 VirtualBox NAT network "ClientServerNet"  192.168.200.0/24
        ┌─────────────────────────────────────────────────────────────────────┐
        │                                                                     │
 ┌──────┴───────────────────────────────┐          ┌──────────────────────────┴──┐
 │ tapauserver.bungkus.org  (Rocky 9.7) │          │ tapauclient.bungkus.org     │
 │                                      │          │ (Ubuntu 24.04, DHCP lease)  │
 │ DNS (BIND)        DHCP (ISC dhcpd)   │◄────────►│                             │
 │ Mail (Postfix, Dovecot, TLS)         │          │ Thunderbird, Firefox        │
 │ Web (Apache, HTTPS, 2 vhosts)        │          │ OpenVPN client              │
 │ OpenVPN + Cockpit                    │          │ Docker stack (nginx,        │
 │ Samba share       MariaDB (TLS)      │          │   MariaDB, Adminer)         │
 │ ClamAV                               │          │ UFW + Fail2ban              │
 └──────────────────────────────────────┘          └─────────────────────────────┘
```

## Services

| # | Runbook | What it does | Main tools |
|---|---|---|---|
| 01 | [DNS](docs/01-dns-bind.md) | Forward and reverse zones for `bungkus.org`, used by the client | BIND |
| 02 | [DHCP](docs/02-dhcp.md) | Hands the client an address, gateway and DNS server | ISC dhcpd |
| 03 | [Secure mail](docs/03-email-postfix-dovecot.md) | SMTP and IMAP with TLS, users in Thunderbird | Postfix, Dovecot, OpenSSL |
| 04 | [Secure web](docs/04-web-apache-tls.md) | Two HTTPS virtual hosts with self-signed certificates | Apache, SELinux |
| 05 | [VPN and Cockpit](docs/05-openvpn-cockpit.md) | Cockpit reachable only through an OpenVPN tunnel | OpenVPN, Easy-RSA, Cockpit |
| 06 | [Docker](docs/06-docker-compose.md) | nginx, MariaDB and Adminer on separate networks | Docker Compose |
| 07 | [File sharing](docs/07-samba.md) | Authenticated SMB share mounted from Ubuntu | Samba |
| 08 | [Database with TLS](docs/08-mariadb-tls.md) | MariaDB that requires TLS for a remote user | MariaDB, OpenSSL |
| 09 | [Antivirus](docs/09-clamav.md) | Signature updates, daemon, daily scheduled scan | ClamAV, cron |
| 10 | [Firewall and banning](docs/10-ufw-fail2ban.md) | Deny-by-default firewall and SSH brute-force bans | UFW, Fail2ban |

## Repository layout

```
.
├── docs/            One runbook per service: purpose, steps, configuration, verification, troubleshooting
├── configs/         The configuration files and scripts, one folder per service
└── screenshots/     Evidence from the lab, one folder per service
```

Each runbook has the same sections, so you can read just the one you care about. The files in `configs/` were read back from the report's screenshots, and each one starts with a comment saying so.

## What is and is not included

- **Reconstructed from screenshots.** The config files were recovered from images in the report. Where only part of a file was shown, the file says so with a `# ...` note, and nothing was filled in from guesswork.
- **Secrets removed.** Passwords, keys and certificate bodies are replaced with `CHANGE_ME` or left out. Generate your own before using any of this.
- **Not re-run.** The steps come from the lab report. They were not re-tested on a fresh Rocky VM for this repository.
- **A lab, not a production design.** Several choices are fine for a lab and wrong for production (self-signed certificates, a database user that can connect from any host, weak lab passwords). Each runbook ends with a notes section that flags them.

## Known inconsistencies in the source report

The report was written by six people on different machines, so a few values do not agree. The runbooks point these out where they matter.

- The server address appears as 192.168.200.3 in some chapters and 192.168.200.4 in others.
- The VPN chapter was done on a VMware host with interface `ens160`, while the rest use VirtualBox and `enp0s3`.
- A few figure captions do not match the screenshots (for example the ClamAV client scan, and a `MaxThreads` value).

## Team

Group AJ. Each person wrote up and configured the services below, and everyone configured DNS and DHCP.

| Services | Member |
|---|---|
| Secure mail, secure web, ClamAV | [@xiulailai](https://github.com/xiulailai) |
| Docker Compose, UFW and Fail2ban | [@2FoR1](https://github.com/2FoR1) |
| OpenVPN and Cockpit | [@7786z](https://github.com/7786z) |
| DHCP, MariaDB with TLS | [@Xylore9](https://github.com/Xylore9) |
| Samba | [@WilliamChuah](https://github.com/WilliamChuah) |

A sixth teammate also configured DNS and DHCP.

## License

Released under the [MIT License](LICENSE). Copyright (c) 2026 automaticicemaker Contributors and APU.
