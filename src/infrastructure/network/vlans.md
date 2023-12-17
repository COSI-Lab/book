# VLANs

_updated: December 17th, 2023_

COSI has allocated the following VLANs:

| VID | Name       | Active? |
|-----|------------|---------|
| 1   | service    | yes     |
| 2   | cosi\_priv | yes     |
| 3   | cosi\_pub  | yes     |
| 4   | 146        | no      |
| 5   | phones     | no      |
| 6   | iot        | no      |
| 7   | cameras    | no      |


## VLAN 1: `service`

Since this is the default VID on many switches, it is never configured to allow
access to the internet. Whenever possible, it should be used for unassigned
interfaces and to provide access to management interfaces for our switches.

## VLAN 2: `cosi_priv`

This VLAN is our "default", and is behind our
[firewall](../../services/firewall.md). Any personal computer, or any server
that does not need direct from the Internet should be here.

## VLAN 3: `cosi_pub`

This VLAN has a direct connection to OIT, and is not protected by the 
[firewall](../../services/firewall.md). Only servers that need direct, 
unfiltered access to the Internet (ex. [Mirror](../../mirror/introduction.md))
should be on this VLAN.

## VLAN 4: `146`

This VLAN was used for the 128.153.146.0/24 subnet, but is not currently active.

## VLAN 5: `phones`

This VLAN was used for our VOIP phones.
See [Asterisk](../../services/asterisk.md) for more information.

## VLAN 6: `iot`

For untrusted devices that require an internet connection
(ex. smart home devices). It is currently unused.

## VLAN 7: `cameras`

This VLAN was used for untrusted devices that do NOT require an internet
connection. It is currently unused.
