# Firewall

_updated: December 1st, 2023_

Since COSI has its own network, we need to run our own Firewall. Our firewall is very simple; blocking all traffic except to hosts we create holes for. Our firewall runs on [Ziltoid](../infrastructure/servers/ziltoid.md).

Firewall rules are kept in a private repository, which will not be linked here.

Some notes:
- Mirror should should not be behind the firewall, but the firewall should be configured that if Mirror accidentally lands behind the firewall nothing should break.
- Try your best to not open insecure ports. For example, opening ssh to a lab machine is dangerous because csguest is typically `sudo`.
- SSH should be configured off of the default port (22) to reduce the risk of automated attacks.
- Rules should periodically be audited. If a service is inactive, its firewall holes should be closed until it is brought up again.

## nftables

Our firewall is configured with nftables (the successor to iptables). 
Although the firewall repository has tools for some common tasks, it is a good idea to get familiar with how [nftables](https://wiki.nftables.org/) works so that you are able to make rules and fix problems should they arise.
