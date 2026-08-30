# Janet (git)

Janet is the lab's GitLab host. It runs on dedicated hardware to provide more resources for CI pipelines and suports users outside of COSI.

| | |
| :--- | :--- |
| Location | [Server Room - Right](../racks.md#right)
| IP Addresses | 128.153.145.69
| Deployed | true

## Hardware

| | |
| :--- | :--- |
| CPU | 2x Intel(R) Xeon(R) CPU E5-2640 @ 3.00GHz
| RAM | 80 GB
| Storage | 8x 300 GB 15K SAS HDDs
| Connectivity | 10 Gigabit SFP+ NIC

## Operating System

| | |
| :--- | :--- |
| OS | GNU/Linux
| Distro | Ubuntu 24.04
| Last updated | August 2026
| End of life | May 2029

## Services

- [git.cosi.clarkson.edu](git.cosi.clarkson.edu)
- GitLab CI runners (docker)

## Notes

Our instance runs gitlab omnibus as a linux package. Therefore there should always be a dedicated gitlab maintainer who checks for updates and applies them. 

Realisticaly this is not an ideal production setup for gitlab, but short of buying hardware for a full blown kubernetes cluster this is a solid second best.
