# Firewall

_updated: Feb 11, 2024_

Since COSI has its own network, we need to run our own firewall. 
Our firewall is a filtered bridge between our public and private VLANS; blocking 
all traffic except to hosts we create holes for. Our firewall currently runs on
[Kasper](../infrastructure/servers/kasper.md).

Firewall rules are kept in a private repository, which will not be linked here.

Some notes:
- Mirror should should not be behind the firewall, but the firewall should be configured that if Mirror accidentally lands behind the firewall nothing should break.
- Try your best to not open insecure ports. For example, opening ssh to a lab machine is dangerous because csguest is typically `sudo`.
- SSH should be configured off of the default port (22) to reduce the risk of automated attacks.
- Rules should periodically be audited. If a service is inactive, its firewall holes should be closed until it is brought up again.

## nftables

Our firewall is configured with nftables (the successor to iptables). 
Although the firewall repository has tools for some common tasks, it is a good
idea to get familiar with how [nftables](https://wiki.nftables.org/) works so
that you are able to make rules and fix problems should they arise.

## Example firewall configuration
This configuration shows how to set up a bare-bones firewall that allows all
outbound traffic and filters inbound traffic against a list of open ports. It
should not be used in the labs without first being modified to be more 
restrictive.

```
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
	set COSIv4 {
		type ipv4_addr
		flags interval

		elements = { 128.153.144.0/23 }
	}

	chain input {
		type filter hook input priority 0; policy drop;

		iif lo accept comment "Accept any localhost traffic"
		ct state invalid drop comment "Drop invalid connections"
		ct state established,related accept comment "Accept traffic originated from us"

		meta l4proto ipv6-icmp accept comment "Accept ICMPv6"
		meta l4proto icmp accept comment "Accept ICMP"
		ip protocol igmp accept comment "Accept IGMP"

		tcp dport {12345} ip saddr @COSIv4 accept comment "Opening a port within the labs on the firewall server itself"

		counter comment "Count any other traffic"
	}

	chain forward {
		# Drop everything forwarded
		type filter hook forward priority 0; counter; policy drop;
	}

	chain output {
		# Accept every outbound connection
		type filter hook output priority 0; counter; policy accept;
	}
}

table bridge filter {
	chain forward {
		type filter hook forward priority 0; policy drop;

		meta l4proto ipv6-icmp accept comment "Accept ICMPv6"
		meta l4proto icmp accept comment "Accept ICMP"
		ip protocol igmp accept comment "Accept IGMP"
		ether type arp counter accept comment "Allow ARP"

		iif LAN_if_name oif WAN_if_name counter accept comment "Allow packets from LAN to WAN"
		iif WAN_if_name oif LAN_if_name ct state invalid counter drop comment "Drop invalid WAN to LAN packets"
		iif WAN_if_name oif LAN_if_name ct state {established,related} counter accept comment "WAN to LAN if LAN initiated the connection"
		iif WAN_if_name oif LAN_if_name counter jump holes comment "WAN to LAN on open ports"

		counter log comment "Drop any packets that were unaccounted for. Should be 0"
	}

	chain holes {
		ip daddr 128.153.145.123 tcp dport {12345} counter accept comment "Opening a port"

		counter drop comment "Port is closed"
	}

	chain input {
		type filter hook input priority 0; counter; policy accept;
	}

	chain output {
		type filter hook output priority 0; counter; policy accept;
	}
}
```