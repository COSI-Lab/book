# TalTres

TalTres is COSI's primary DNS server, replacing TalDos (now Caterpillar).

*Third time's the charm.*

| | |
| :--- | :--- |
| Location | [COLO](../racks.md#colo) |
| IP Addresses | 128.153.145.3 |
| Deployed | true |

## Hardware

| | |
| :--- | :--- |
| CPU | Intel Xeon E5-2640v3 (x2)
| RAM | 64 GB
| Storage | 2.4 TB (Hardware RAID)
| Connectivity | 1 Gbps

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Debian 12 Bookworm
| Last updated | Sep 2024
| End of life | June 2028

## Services

- [Authoritative DNS](../../services/authoritative_dns.md)
- [DHCP](../../services/dhcp.md)

## Notes

The hardware on this system is *wildly* over-specced for a DNS server.
