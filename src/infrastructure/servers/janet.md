# Janet

_updated: Feb 11, 2024_

Janet is COSI's secondary VM host. While it has much less storage than [hydra](./hydra.md), it has considerably more compute power and memory.

| | |
| :--- | :--- |
| Location | [Server Room - Right](../racks.md#right)
| IP Addresses | 128.153.145.43
| Deployed | true

## Hardware

| | |
| :--- | :--- |
| CPU | 2x Intel(R) Xeon(R) CPU E5-2640 @ 3.00GHz
| RAM | 80 GB
| STORAGE | 8x 300 GB 15K SAS HDDs
| CONNECTIVITY | 10 Gigabit SFP+ NIC

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu Server 22.04
| Last updated | Jan 2024
| End of life | April 2027
| Enrolled in COSI auth | false
| NFS Mount | false

## VMs

_updated: Feb 11, 2024_

- CS444

## Notes

Just like [Hydra](./hydra.md), you can use virt-manager over ssh to manage VMs on Janet.

VM's are using [qemu](https://www.qemu.org/) and virtmanager
```sh
ssh -X janet virt-manager
```

