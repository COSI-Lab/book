# TalTres

_updated: September 15, 2024_

TalTres is COSI's primary DNS server, replacing TalDos (now Caterpillar).
It also runs our point-to-site VPN.

*Third time's the charm.*

| | |
| :--- | :--- |
| Location | [Server Room - Network 1](../racks.md#network-1) |
| IP Addresses | 128.153.145.3, 128.153.145.53 |
| Deployed | true |

## Hardware

| | |
| :--- | :--- |
| CPU | Intel Xeon E5-2640v3 (x2)
| RAM | 64 GB
| STORAGE | 2.4 TB
| CONNECTIVITY | 1 Gbps

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Debian 12 Bookworm
| Last updated | Sep 2024
| End of life | unknown
| Enrolled in COSI auth | false
| NFS Mount | false

## Services

[Authoritative DNS](../../services/authoritative_dns.md)
[DHCP](../../services/dhcp.md)

## Notes
