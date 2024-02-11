# Hydra

_updated: Sep 25, 2023_

Hydra is COSI's default VM host. 

| | |
| :--- | :--- |
| Location | [Server Room - Center](../racks.md#center) |
| IP Addresses | 128.153.145.42 |
| Deployed | true |

## Hardware

| | |
| :--- | :--- |
| CPU | AMD Opteron 6376 (x2)
| RAM | 64 GB
| STORAGE | 10TB (5x2TB)
| CONNECTIVITY | 10Gbps

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu 22.04.5 LTS
| Last updated | unknown
| End of life | April 2028
| Enrolled in COSI auth | true
| NFS Mount | true

## VMs

_updated: Sept 18th 2022_

- [atlas](../vms.md#atlas)
- [docs](../vms.md#docs)
- [dubsdot](../vms.md#dubsdot)
- [dubsdot2](../vms.md#dubsdot2)
- [gitea](../vms.md#gitea)
- [unbound](../vms.md#unbound)
- [voip](../vms.md#voip)

## Notes

It is not so bad to use virt-manager over ssh while on the Clarkson network.

VM's are using [qemu](https://www.qemu.org/) and virtmanager
```sh
ssh -X hydra virt-manager
```

