# Tiamat

_updated: November 27, 2023_

Tiamat is COSI's web / container host, and is home to the CSlabs website, Talks, 
Book, and others. Tiamat uses NGINX to proxy connections to each website and
container.

| | |
| :--- | :--- |
| Location | [Server Room - Center](../racks.md#center) |
| IP Addresses | 128.153.145.41 |
| Deployed | true |

## Hardware

| | |
| :--- | :--- |
| CPU | AMD Opteron 6220
| RAM | 64 GB
| STORAGE | 1TB
| CONNECTIVITY | 10 Gbps

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu 22.04
| Last updated | Nov 2023
| End of life | April 2027
| Enrolled in COSI auth | true
| NFS Mount | false

## Services

Docker host

## Websites

[CSLabs](../../websites/cslabs.md)

[Book](../../websites/book.md)

[Talks](../../websites/talks.md)

## Notes

Projects to be hosted are stored in the directory `/docker`. The quickest way to host a project on Tiamat is to clone its repository to this directory. You can manage containers individually with Docker or use `run.sh` to rebuild all projects.

Incoming connections are forwarded to their respective containers using [NGINX Proxy Manager](https://nginxproxymanager.com/), which also handles SSL termination and certificates for each project.

It is recommended to add the line `restart: unless-stopped` to your project's `docker-compose.yml` so that it is automatically restarted when Tiamat reboots.