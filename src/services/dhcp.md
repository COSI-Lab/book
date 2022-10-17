# DHCP

_updated: Sept 30th 2022_

Since COSI has it's own network we also run a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) server to manage ip allocations. DHCP is an important service because it allows people temporiliy using our network to avoid setting a static IP address. However, since DHCP servers lease IP address based on client's MAC addresses we can also use our server to easily manage the IPs of other clients on our network. For example, we can manage the ITL machines by manually mapping their MAC addresses to IPs and we never have to worry about setting a static IP on each machine.

## isc-dhcp-server

The Internet Systems Consortium's implementation of a DHCP server is good enough. We have a single dhcp server running on [Talos](../infrastructure/servers/talos.md). In the past we had a fallback server running in a VM. This no longer exists.

## DHCP information

| field | value | notes |
| :---- | :---- | :---- |
| domain | cslabs.clarkson.edu | [authoritative dns](../services/authoritative_dns.md) |
| DNS servers | 128.153.145.53 | [recursive dns](../services/recursive_dns.md) | 
| NTP Servers | 128.153.2.253, 128.153.5.253 | Operated by OIT |
| Gateway | 128.153.144.1 | OIT Gateway |
| Subnet Mask | 255.255.254.0 | |

## Configuration 

TODO


