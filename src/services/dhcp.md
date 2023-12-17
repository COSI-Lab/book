# DHCP

_updated: December 1st, 2023_

Since COSI has it's own network we also run a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) server to manage ip allocations. DHCP is an important service because it allows people temporiliy using our network to avoid setting a static IP address. However, since DHCP servers lease IP address based on client's MAC addresses we can also use our server to easily manage the IPs of other clients on our network. For example, we can manage the ITL machines by manually mapping their MAC addresses to IPs and we never have to worry about setting a static IP on each machine.

## isc-dhcp-server

We have a single dhcp server running on [TalDos](../infrastructure/servers/taldos.md).
In the past we had a fallback server running in a VM. This no longer exists.
We currently use Internet Systems Consortium's implementation of a DHCP server, which
has reached its end-of-life. We are currently working on testing a replacement.

## DHCP information

| field | value | notes |
| :---- | :---- | :---- |
| domain | cslabs.clarkson.edu | [authoritative dns](../services/authoritative_dns.md) |
| DNS servers | 128.153.145.53 | [recursive dns](../services/recursive_dns.md) | 
| NTP Servers | 128.153.2.253, 128.153.5.253 | Operated by OIT |
| Gateway | 128.153.144.1 | OIT Gateway |
| Subnet Mask | 255.255.254.0 | |

## Configuration 

```
# option definitions common to all supported networks...
option domain-name "cslabs.clarkson.edu";
option domain-name-servers 1.1.1.1, 1.0.0.1;

default-lease-time 600;
max-lease-time 7200;

# The ddns-updates-style parameter controls whether or not the server will
# attempt to do a DNS update when a lease is confirmed. We default to the
# behavior of the version 2 packages ('none', since DHCP v2 didn't
# have support for DDNS.)
ddns-update-style none;

# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
authoritative;

subnet 128.153.144.0 netmask 255.255.254.0 {
  range 128.153.144.100 128.153.144.254;
  option routers 128.153.144.1;
  option ntp-servers 128.153.2.253, 128.153.5.253;
}

# Fixed IP addresses can also be specified for hosts.   These addresses
# should not also be listed as being available for dynamic assignment.
# Hosts for which fixed IP addresses have been specified can boot using
# BOOTP or DHCP. Hosts for which no fixed address is specified can only
# be booted with DHCP, unless there is an address range on the subnet
# to which a BOOTP client is connected which has the dynamic-bootp flag
# set.
#host fantasia {
#  hardware ethernet 08:00:07:26:c0:a5;
#  fixed-address fantasia.example.com;
#}

# You can declare a class of clients and then do address allocation
# based on that. The example below shows a case where all clients
# in a certain class get addresses on the 10.17.224/24 subnet, and all
# other clients get addresses on the 10.0.29/24 subnet.

#class "foo" {
#  match if substring (option vendor-class-identifier, 0, 4) = "SUNW";
#}
```

## Notes

As of 12/01/23, the default DNS servers are 1.1.1.1 and 1.0.0.1 (Cloudflare) due to issues with Unbound
