# Virtual Machines

_updated: Sep 25, 2023_

This chapter contains an alphabetically ordered list of all of COSI's virtual machines.

**VM Hosts:**
- [hydra](./servers/hydra.md)

**Template:**
```
## name

_updated: Sept 18th 2022_

<Description & Current Purpose>

| | |
| :--- | :--- |
| Host |
| IP Addresses | 
| OS |
| Distro | 
| Last updated | 
| End of life | 
| Enrolled in COSI auth | true/false
| NFS Mount | true/false

**Services:**
```

## atlas

> deprecated: All DNS is handled by [TalDos](./servers/taldos.md).

_updated: December 15th, 2023_

Atlas is our secondary DNS server.

| | |
| :--- | :--- |
| Host | hydra
| IP Addresses | 128.153.145.4 , 2605:6480:c051:4::1 
| OS | GNU/Linux
| Distro | Ubuntu 22.04.1 LTS
| Last updated | Sept 18th 2022
| End of life | April 2032
| Enrolled in COSI auth | true
| NFS Mount | false

**Services:**
- [Authoritative DNS](../services/authoritative_dns.md)

## Docs

> deprecated: All new documentation should be added to book.

_updated: Sept 18th 2022_

Docs hosts our old [mediawiki](https://www.mediawiki.org/wiki/MediaWiki) documentation. 

| | |
| :--- | :--- |
| Host | [hydra](./servers/hydra.md)
| IP Addresses | 128.153.145.148
| OS | GNU/Linux
| Distro | Debian 10
| Last updated | ?
| End of life | June 30th 2024
| Enrolled in COSI auth | ?
| NFS Mount | ?

**Services:**
- TODO

## dubsdot

> deprecated: all new websevices should be deployed to [Tiamat](./servers/tiamat.md). Existing dubsdot services should be rebuilt and migrated.

_updated: Feb 28th 2023_

Dubsdot was our old web host. Ran many websites.

| | |
| :--- | :--- |
| Host | [hydra](./servers/hydra.md)
| IP Addresses | 128.153.145.200
| OS | GNU/Linux
| Distro | Debian 10
| Last updated | ?
| End of life | June 30th 2024
| Enrolled in COSI auth | ?
| NFS Mount | ?

**Services:**
- TODO

## dubsdot2

_updated: Feb 28th 2023_

> deprecated: all new websevices should be deployed to [Tiamat](./servers/tiamat.md). Existing dubsdot2 services should be rebuilt and migrated.

This was an interim web host and location to run [docker](https://www.docker.com) containers, with the intention of eventually removing a layer of virtualization and migrating services to [Tiamat](./servers/tiamat.md).

| | |
| :--- | :--- |
| Host |
| IP Addresses | 128.153.145.201 , 2605:6480:c051:200::1
| OS | GNU/Linux
| Distro | Debian 10
| Last updated | Sept 18th 2022
| End of life | June 30th 2024
| Enrolled in COSI auth | true
| NFS Mount | true

**Services:**

It is important that no two services use the same port.

| service | ports |
| :------ | :---- |
| [book](../websites/book.md)     | 8012 |
| boyd bot                        | 8004 |
| [cslabs](../websites/cslabs.md) | 8003 |
| [files](../websites/files.md)   | 8002 |
| [talks](../websites/talks.md)   | 8001 |
| [random](../websites/random.md) | 8010 |

**Notes:**

Everything running on dubsdot2 should be a [docker](https://www.docker.com) container using docker-compose. All of the containers are stored in `/opt`. Use the `readme` to keep track of port allocations and check other compose to learn how to let SSL be auto configured.

## fsu

_updated: Sept 25, 2023_

fsu provides the Floating Soda Unit bank (Mount Fsuvius) for the labs.

| | |
| :--- | :--- |
| Host | [hydra](./servers/hydra.md)
| IP Addresses | 128.153.145.219
| OS | GNU/Linux
| Distro | Ubuntu 22.04 LTS
| Last updated | ?
| End of life | Apr 2027
| Enrolled in COSI auth | false
| NFS Mount | false

**Services:**
| Service | Port |
| :--- | :--- |
| [Mount Fsuvius](http://fsu.cslabs.clarkson.edu) | 80

## gitea

## unbound

**Services:**
- [Recursive DNS](../services/recursive_dns.md)

## voip
