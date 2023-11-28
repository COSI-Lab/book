# Talos

_updated: November 27th, 2023_

Talos is COSI's old primary DNS server, and is currently planned to be set up
in place of Atlas as our secondary DNS server.

| | |
| :--- | :--- |
| Location | [Server Room - Network 3](../racks.md#network-3) |
| IP Addresses | N/A |
| Deployed | false |

## Hardware

| | |
| :--- | :--- |
| CPU | Intel(R) Xeon(R) CPU E3-1220 v3 @ 3.10GHz
| RAM | 4GB DDR3 1333MHz
| STORAGE | 250GB SSD
| CONNECTIVITY | 1000MBit/s on motherboard
| MOTHERBOARD | X10SLL-f REV 1.02 

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux 
| Distro | Debian 11
| Last updated | September 27th, 2022
| End of life | Unknown
| Enrolled in COSI auth | false
| NFS Mount | false

## Services

[Authoritative DNS](../../services/authoritative_dns.md)
[DHCP](../../services/dhcp.md)
LDAP
Kerberos

## Notes

Talos was replaced by TalDos in Fall 2023 after it crashed due to memory errors.
