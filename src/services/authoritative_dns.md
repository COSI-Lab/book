# Authoritative DNS

_updated: Jan 22th 2023_

OIT has the following entries in their DNS tables. 

```
cosi.clarkson.edu.	3600	IN	NS	dns1.cosi.clarkson.edu.
cslabs.clarkson.edu.	3600	IN	NS	dns1.cosi.clarkson.edu.

mirror.clarkson.edu.	3600	IN	A	128.153.145.19
```

This means we have control over `*.cosi.clarkson.edu.` and `*.cslabs.clarkson.edu.` domains. Remember that this DNS is propagated back to the public DNS servers. Please keep the record names appropriate. If you even slightly question the name, please contact a lab director for their input.

## [zones](https://gitea.cosi.clarkson.edu/COSI_Maintainers/zones)

Our DNS [zone files](https://en.wikipedia.org/wiki/Zone_file) are backed by a git repository on [gitea](../websites/gitea.md). While they started separate in recent years we've strived to have the cosi.clarkson.edu and cslabs.clarkson.edu match.

When adding a new server to the network make sure you remember to add it's ip to the reverse zones.

## NSD

COSI has one authoritative DNS server running [NSD](https://en.wikipedia.org/wiki/NSD) which is `dns1.cosi.clarkson.edu` is running on [Talos](../infrastructure/servers/talos.md). 

OIT's caching DNS servers are configured to cache the entire zone files over XFR. That is why we have XFR enabled for OIT's name servers. If you notice DNS results are buggy within the Clarkson network it is probably this.

## Webhook

Deploying updates to the dns zones is a great use for Webhooks. Currently there is a webhook server built into the [zones](https://gitea.cosi.clarkson.edu/COSI_Maintainers/zones) repo.

## Current Configuration

Note: the `"REDACTED"` secret must be the same in both config files. You could create a reasonable secret with this command `dd if=/dev/random of=/dev/stdout count=1 bs=32 | base64`. Be careful not to leak the secret.

`dns1.cosi.clarkson.edu` configuration:
```
#
# See the nsd.conf(5) man page.
#

server:
	# Use 1 core
	server-count: 1

	ip-address: 127.0.0.1
	ip-address: 128.153.145.3
	ip-address: 2605:6480:c051:3::1

	do-ip4: yes
	do-ip6: yes

	# Location of zone files
	zonesdir: "/etc/nsd/zones"

	# Idk why not
	hide-version: yes

	# Send less junk
	minimal-responses: yes

	# Save stats every hour
	statistics: 3600
	logfile: "/var/log/nsd.log"

key:
	name: "cosikey"
	algorithm: hmac-sha256
	secret: "REDACTED"

pattern:
	name: "xfr"

	## OIT DNS SERVERS (maybe we should give them a key?)
	provide-xfr: 128.153.5.254 NOKEY
	provide-xfr: 128.153.0.254 NOKEY
	provide-xfr: 128.153.54.32 NOKEY
	provide-xfr: 128.153.54.33 NOKEY
	
	## Allow xfr for all of clarkson
	#provide-xfr: 128.153.0.0/16 NOKEY
	#provide-xfr: 2605:6480::1/32 NOKEY

# Zones
zone:
	name: "cosi.clarkson.edu"
	zonefile: "db.cosi"
	include-pattern: "xfr"

zone:
	name: "cslabs.clarkson.edu"
	zonefile: "db.cslabs"
	include-pattern: "xfr"

zone:
	name: "144.153.128.in-addr.arpa"
	zonefile: "db.cslabs.rvs.144"
	include-pattern: "xfr"

zone:
	name: "145.153.128.in-addr.arpa"
	zonefile: "db.cslabs.rvs.145"
	include-pattern: "xfr"

zone:
	name: "146.153.128.in-addr.arpa"
	zonefile: "db.cslabs.rvs.146"
	include-pattern: "xfr"

zone:
	name: "1.5.0.c.0.8.4.6.5.0.6.2.ip6.arpa"
	zonefile: "db.cslabs.rvs.c051"
	include-pattern: "xfr"
```

## Notes

In the recent past, COSI had two dns servers, the other being `dns2.cosi.clarkson.edu` [Atlas](../infrastructure/vms.md#atlas). It was determined inefficient to have Atlas during the time in which the COSI network had to be fixed. This page and other mentions of Atlas should be changed in the near future.
