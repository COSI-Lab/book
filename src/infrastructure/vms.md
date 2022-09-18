# Virtual Machines

_updated: Sept 17th 2022_

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

_updated: Sept 18th 2022_

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

> deprecated: In the interm all new websevices should be deployed to [dubsdot2](#dubsdot2). Existing dubsdot services should be rebuilt and migrated.

_updated: Sept 18th 2022_

Dubsdot is our old web host. Runs many websites.

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

_updated: Sept 18th 2022_

Interm web host and location to run [docker](https://www.docker.com) containers. Eventually the goal is to remove a layer of virtualization and migrate services to [tiamat](./servers/tiamat.md).

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

## gitea

## unbound

**Services:**
- [Recursive DNS](../services/recursive_dns.md)

## voip
