# "Hardware"

The most important form of maintenance performed on Mirror is that of the physical hardware and operating system.

## Hardware 

_updated: Nov 20th 2024_

|                          |                                                 |
| ------------------------ | ----------------------------------------------- |
| RAM                      | 64GB (8x8GB) DDR3 ECC                           |
| OS Drive                 | Samsung 850 Pro 128GB                           |
| Primary Storage Drives   | 8x 16 TB IronWolf Pro NAS Drives - ST16000NE000 |
| Cache Drive              | Sabrent SB-RKT4P-1TB                            |
| NIC                      | HP 671798-001 10GBE NIC                         |

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

|              |               |
| :----------- | :------------ |
| OS           | GNU/Linux     |
| Distro       | Ubuntu 24.04  |
| Last updated | November 2024 |
| End of life  | April 2029    |

