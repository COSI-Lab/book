# Kasper

Kasper is our current firewall and the successor to [Ziltoid](ziltoid.md).
It functions as a filtered bridge between our public and private VLANs.

| | |
| :--- | :--- |
| Location | [COLO](../racks.md#colo)
| IP Addresses | 128.153.145.2
| Deployed | true

## Hardware

| | |
| :--- | :--- |
| CPU | 12x Intel(R) Xeon(R) CPU E5-2620 @ 2.00GHz
| RAM | 8 GB
| Storage| 2x 300 GB 15K SAS HDDs
| Connectivity | 2x 10 Gigabit SFP+ NICs

## Operating System

| | |
| :--- | :--- |
| OS | FreeBSD
| Distro | OPNsense 26.7
| Last updated | September 2026
| End of life | January 2027

## Services

- [Firewall](../../services/firewall.md)

## Notes

Kasper formerly utilized nftables on Ubuntu as our firewall configuration, which is what much of the current firewall documentation refrences. These pages should be updated to reflect the shift to OPNsense.
