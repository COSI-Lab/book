# IP Address Allocations

All links on this page should point at the underlying physical (or virtual) _infrastructure_. Links do **not** redirect towards _services_.

## IP Address Listing for 128.153.144.1/24 subnet

_updated: December 15, 2023_

| 128.153.144.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2 | OIT Echo 360 in the ITL |
| 10 | COSI WiFi |
| 21-28	| COSI Machines (1-8) |
| 29 | 3D Printer Machine |
| 40-65 | ITL Machines |
| 100-254 | DHCP |

### Layout

| 128.153.144.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2-9 | University services |
| 10-20 | Access Points |
| 21-39 | COSI Machines |
| 40-65 | ITL Machines  |
| 66-99	| Unallocated   |
| 100-254 | DHCP |

## IP Address Listing for 128.153.145.1/24 subnet

| 128.153.145.# | Name |
| :--- | :---
| 1 | OIT Gateway |
| 2 | [Kasper](../servers/kasper.md) |
| 3 | [TalDos](../servers/taldos.md) |
| 4 | [Talos](../servers/talos.md) |
| 41 | [Tiamat](../servers/tiamat.md) |
| 42 | [Hydra](../servers/hydra.md) |
| 43 | [Janet](../servers/janet.md) |
| 53 | [TalDos](../servers/taldos.md) |
| 179 | [hbox](../servers/hbox.md) |


### Layout

# Layout of 145/24 network

_TODO: reallocate the entire network_

## IPv6 Address Listing for 2605:6480:c051::/48 network

### Subnet Allocations

| 2605:6480:c051 | :XXXX: | YYYY:YYYY:YYYY:YYYY |
| :-:            | :-:  | :-: |
| network        | subnet | host |

COSI has been allocated 2^16 ipv6 subnets. Each subnet can have up to _2^64_ hosts. 

It is hard to come up with a reasonable way to allocate our subnets because we just have _so many_. 
