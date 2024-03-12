# DHCP

_updated: December 1st, 2023_

Since COSI has it's own network we also run a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) server to manage ip allocations. DHCP is an important service because it allows people temporiliy using our network to avoid setting a static IP address. However, since DHCP servers lease IP address based on client's MAC addresses we can also use our server to easily manage the IPs of other clients on our network. For example, we can manage the ITL machines by manually mapping their MAC addresses to IPs and we never have to worry about setting a static IP on each machine.

## Kea

We have a single dhcp server running on [TalDos](../infrastructure/servers/taldos.md).
In the past we had a fallback server running in a VM. This no longer exists.
We currently use Internet Systems Consortium's Kea DHCP server.

## DHCP configuration

### IPv4
- Subnet: 128.153.144.0/23
- Address pool: 128.153.144.100-128.153.144.254
- Gateway: 128.153.144.1
- DNS servers: 128.153.145.53, 1.1.1.1
- NTO servers: 128.153.2.253, 128.153.5.253
- Domain: cslabs.clarkson.edu

### IPv6

- Not yet configured

## Notes
