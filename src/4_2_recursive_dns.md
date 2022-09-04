# Recursive DNS

_updated: Sept 9th 2022_

The lab runs it's own caching DNS server located at 128.153.145.53. Not to be confused with our [authoritative](./4_1_recursive_dns.md) dns services. The purpose of the cache is to improve latency when multiple people are trying to access the same sites. Currently we forward all unknown DNS queries to Clarkson's name servers.

In the event the COSI's recursive dns server is removed we can fall back to the university's services at:

```
# Potsdam (preferred)
ns1: 128.153.5.254
ns2: 128.153.0.254

# Schenectady
crc-dns-0: 128.153.54.32
crc-dns-1: 128.153.54.33
```

Unbound is currently run as a VM under hydra. There are plans to migrate to a Docker container.

## Unbound

We currently use [Unbound](https://en.wikipedia.org/wiki/Unbound_(DNS_server)) for DNS. If possible, other clients should do their best to have their own DNS caches to further decrease latency when repeatedly accessing the same sites. 

### Configuration
```
server:
    # Bind to everything
    interface: 0.0.0.0
    interface: 0::

    ## Allow the whole clarkson network
    # access-control: 128.153.0.0/16 allow
    # access-control: 2605:6480::/32 allow
    ## Allow only the COSI subnets
    access-control: 128.153.144.0/23 allow
    access-control: 128.153.146.0/24 allow
    access-control: 2605:6480:c051::/48 allow

    do-ip4: yes
    do-ip6: yes
    do-udp: yes
    do-tcp: yes

## cosi and cslabs zones
## this saves some hops when accessing cosi services
stub-zone:
    name: "cosi.clarkson.edu"
    stub-addr: 128.153.145.3
    stub-addr: 128.153.145.4

stub-zone:
    name: "cslabs.clarkson.edu"
    stub-addr: 128.153.145.3
    stub-addr: 128.153.145.4

## Forward everything else to OIT name servers
forward-zone:
    name: "."
    forward-addr: 128.153.0.254
    forward-addr: 128.153.5.254
```
