# Firewall

_updated: Oct 16th 2022_

Since COSI has it's own network we need to run our own Firewall. Our firewall is very simple: block all traffic except to ports we poke holes for. Our firewall current runs on [Ziltoid](../infrastructure/servers/ziltoid.md).

Some notes:
- Mirror should should not be behind the firewall, but the firewall should be configured that if Mirror accidentally lands behind the firewall nothing should break.
- Try your best to not open insecure ports. For example, opening ssh to a lab machine is dangerous because csguest is typically `sudo`.
- Rules should periodically be audited

## iptables

TODO
