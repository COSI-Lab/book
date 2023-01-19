# "Hardware"

The most import form of maintained preformed on Mirror is maintaining the physical hardware and operating system.

## Hardware 

_updated: Jan 19th 2023_

|||
|-----|----|
| RAM | 8x Black Diamond M-1333TER-8192BD23 8GB DDR3 RAM
| OS Drive | Samsung EVO 870 1TB SATA SSD
| Primary Storage Drives | 8x 16 TB IronWolf Pro NAS Drives - ST16000NE000
| Secondary Storage Drives | **TODO**
| Cache Drive | Sabrent SB-RKT4P-1TB
| NIC | HP 671798-001 10gb Ethernet Network Interface Card NIC Board

There is also some random PCIE 3 to M.2 riser card for cache drive.

## ZFS

We have the following ZFS layout mounted to `/storage`.

```
zoodle
  raidz1-0
    ata-ST16000NE000-2RW103_ZL2NGP92
    ata-ST16000NE000-2RW103_ZL2N6LPA
    ata-ST16000NE000-2RW103_ZL2MHH7Z
    ata-ST16000NE000-2RW103_ZL2N6LKX
  raidz1-1
    ata-ST16000NE000-2RW103_ZL2NED08
    ata-ST16000NE000-2RW103_ZL2N3TKV
    ata-ST16000NE000-2RW103_ZL2NHEV0
    ata-ST16000NE000-2RW103_ZL2N6SHS
cache
  nvme-Sabrent_Rocket_4.0_Plus_8D8C071602DD00011193
```

For the uninitiated raidz1 is the functional equivalent of RAID 5 and we can lose at most 1 disk in both groups. You can make endless tradeoffs on our storage pool layout. 

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Debian 11
| Last updated | Jan 19th 2023
| End of life | Unknown

