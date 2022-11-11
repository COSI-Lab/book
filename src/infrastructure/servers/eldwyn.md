# Eldwyn

_updated: Nov 11th 2022_

| | |
| :--- | :--- |
| Location | [COLO](../racks.md#colo.md)
| IP Addresses | 128.153.145.45
| Deployed | true

## Hardware

| | |
| :--- | :--- |
| CPU | 4 Core Intel Xeon E5410
| RAM | 8x 4G KVR667D2D4Fk2/8G
| STORAGE | 
| CONNECTIVITY | Standard 10 Gigabit NIC
| MOTHERBOARD | SuperMicro X7DBP-i rev 1.2

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu 22.04
| Last updated | November 11, 2022
| End of life | April 2027
| Enrolled in COSI auth |
| NFS Mount |

## Services

## Notes

Eldwyn's BIOS is so old it cannot boot of an SSD. An attempt to find a newer version of the BIOS was _unsuccessful_. 

Normally we use a boot SSD, but since we can't use a boot SSD we just use the normal hard drives. To increase the reliability the drives we set up the roots partitions in a [RAID 5](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_5) using `mdadm`. 

One of the drives is configured to be the boot drive. If that drive dies there are two options

- Boot a live disk, mount the root partition, and recover any important data.
- Boot a live disk and try to manually install grub on one of the other drives.

Godspeed.
