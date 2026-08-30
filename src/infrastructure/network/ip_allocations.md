# IP Address Allocations

## 128.153.144.0/24 Subnet

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

| 128.153.145.# | Name |
| :---  | :---
| 1 | OIT Gateway |
| 2-29 | Network services/appliances, Mirror |
| 30-99 | COSI Servers |
| 100-169 | Research |
| 170-220 | Student projects / VMs  |
| 230-254 | Research |

## 2605:6480:c051::/48 Subnet

| 2605:6480:c051 | :XXXX: | YYYY:YYYY:YYYY:YYYY |
| :-:            | :-:  | :-: |
| network        | subnet | host |

COSI has been allocated 2^16 ipv6 subnets. Each subnet can have up to _2^64_ hosts. 

It is hard to come up with a reasonable way to allocate our subnets because we just have _so many_. 
