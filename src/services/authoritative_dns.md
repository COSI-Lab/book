# Authoritative DNS

OIT has the following entries in their DNS tables. 

```
cosi.clarkson.edu.		3600	IN	NS	dns1.cosi.clarkson.edu.
cslabs.clarkson.edu.	3600	IN	NS	dns1.cosi.clarkson.edu.

mirror.clarkson.edu.	3600	IN	A	128.153.145.19
```

This means we have control over `*.cosi.clarkson.edu.` and `*.cslabs.clarkson.edu.` domains. Remember that this DNS is propagated back to the public DNS servers. Please keep the record names appropriate. If you even slightly question the name, please contact a lab director for their input.

## [zones](https://git.cosi.clarkson.edu/cosi-meta/zones)

Our DNS [zone files](https://en.wikipedia.org/wiki/Zone_file) are backed by a git repository on [GitLab](https://git.cosi.clarkson.edu/cosi-meta/zones). While they started separate in recent years we've strived to have the cosi.clarkson.edu and cslabs.clarkson.edu match.

When adding a new server to the network make sure you remember to add it's ip to the reverse zones.

## NSD

COSI has one authoritative DNS server running [NSD](https://en.wikipedia.org/wiki/NSD) which is `dns1.cosi.clarkson.edu` is running on [TalTres](../infrastructure/servers/taltres.md). 

OIT's caching DNS servers are configured to cache the entire zone files over XFR. That is why we have XFR enabled for OIT's name servers. If you notice DNS results are buggy within the Clarkson network it is probably this.

## Webhook

Deploying updates to the dns zones is a great use for Webhooks. Currently there is a webhook server built into the [zones](https://github.com/COSI-Lab/zones) repo, however it is not running.

## Notes

In the recent past, COSI had two dns servers, the other being `dns2.cosi.clarkson.edu` (Atlas). It was determined inefficient to have Atlas during the time in which the COSI network had to be fixed. This page and other mentions of Atlas should be changed in the near future.
