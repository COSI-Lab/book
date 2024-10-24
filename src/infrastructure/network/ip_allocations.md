# IP Address Allocations

All links on this page should point at the underlying physical (or virtual) _infrastructure_. Links do **not** redirect towards _services_.

## 128.153.144.0/24 Subnet
### IP Address Listing
_updated: October 24, 2024_

| 128.153.144.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2 | OIT Echo 360 in the ITL |
| 10 | COSI WiFi |
| 21-28	| COSI Machines (1-8) |
| 29 | 3D Printer Machine |
| 40-65 | ITL Machines |
| 100-250 | DHCP |

### Layout

| 128.153.144.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2-9 | University services |
| 10-20 | Access Points |
| 21-39 | COSI Machines |
| 40-65 | ITL Machines  |
| 66-99	| Unallocated   |
| 100-250 | DHCP |
| 251-253 | Unallocated |
| 254 | VPN Entry Point |

## 128.153.145.0/24 Subnet
### IP Address Listing
_updated: October 24, 2024_

| 128.153.145.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2 | [Kasper](../servers/kasper.md) |
| 3 | [TalTres](../servers/taltres.md) |
| 5 | [Ziltoid](../servers/ziltoid.md) |
| 10 | [Bacon](../servers/bacon.md) |
| 19 | [Mirror](../../mirror/introduction.md) |
| 20 | [FCOLO](../network/switches.md) |
| 20 | [FHILL](../network/switches.md) |
| 38 | [Wallace](../servers/wallace.md) |
| 39 | [Gromit](../servers/gromit.md) |
| 41 | [Tiamat](../servers/tiamat.md) |
| 42 | [Hydra](../servers/hydra.md) |
| 43 | [Janet](../servers/janet.md) |
| 52 | [Caterpillar](../servers/caterpillar.md) |
| 53 | [TalTres](../servers/taltres.md) |
| 90 | [Elephant](../servers/elephant.md) |

### Allocations

| 128.153.145.# | Name |
| :---  | :---
| 1 | OIT Gateway |
| 2-29 | Network services/appliances, Mirror |
| 30-99 | COSI Servers |
| 100-169 | Research |
| 170-220 | Student projects / VMs  |
| 230-254 | Research |

## 2605:6480:c051::/48 Subnet

### Allocations

| 2605:6480:c051 | :XXXX: | YYYY:YYYY:YYYY:YYYY |
| :-:            | :-:  | :-: |
| network        | subnet | host |

COSI has been allocated 2^16 ipv6 subnets. Each subnet can have up to _2^64_ hosts. 

It is hard to come up with a reasonable way to allocate our subnets because we just have _so many_. 
