# Hydra

_updated: Sept 18th 2022_

Hydra is COSI's defacto VM host. 

| | |
| :--- | :--- |
| Location | [server room: left](../racks/server_room.md#left) |
| IP Addresses | 128.153.145.42 |
| Deployed | true |

## Hardware

| | |
| :--- | :--- |
| CPU | AMD Opteron 6376
| RAM | 
| STORAGE | 
| CONNECTIVITY | 
| OTHER |

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu 18.04.5 LTS
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

```sh
ssh -X hydra virt-manager
```

