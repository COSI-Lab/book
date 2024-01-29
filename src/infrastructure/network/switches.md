# Switches 

The purpose of this document is to provide more detailed descriptions of our managed network switches. 

## FHILL

_updated: December 17th, 2023_

FHILL is currently our top level fiber networking switch. It is a
[Mikrotik CRS326-24S+2Q+RM](https://mikrotik.com/product/crs326_24s_2q_rm)
running `RouterOS v7`. The management interface is assigned to `128.153.145.21`,
and is currently only accessible by plugging in to one of the service ports.
If in doubt, the Ethernet port labeled `MGMT/BOOT` should always be configured
to allow access to the management interface.

| Ports | Count |
|-------------|-------|
| SPF+ (10G)  | 24    |
| QSPF+ (40G) | 2     |

The switch is physically split into 3 groups of 8 SFP+ ports and 1 group
containing the 2 QSFP+ ports. It also has a 100M Ethernet port for management.

```
| 0 | 2 | 4 | 6 |   | 8 | 10 | 12 | 14 |   | 16 | 18 | 20 | 22 |   |  Q0  |   |      |
|---|---|---|---|---|---|----|----|----|---|----|----|----|----|---|------|---|------|
| 1 | 3 | 5 | 7 |   | 9 | 11 | 13 | 15 |   | 17 | 19 | 21 | 23 |   |  Q1  |   | MGMT |
```

We've configured groups of ports to map to certain [VLANs](../network/vlans.md).

| Ports | VID | Name       | Speed |
|-------|-----|------------|-------|
| 0-7   | 3   | cosi\_priv | 10 G  |
| 8-15  | 2   | cosi\_pub  | 10 G  |
| 16-23 | 1   | service    | 10 G  |
| Q0-Q1 | 1   | service    | 40 G  |
| MGMT  | 1   | service    | 100 M |

## FCOLO

_updated: December 17th, 2023_

FCOLO is our fiber network switch in COLO, which we are planning to use as our
top level switch once we have moved some critical infrastructure there. It is a
[Mikrotik CRS326-24S+2Q+RM](https://mikrotik.com/product/crs326_24s_2q_rm)
running `RouterOS v7`. Its management interface is currently not accessible.

| Ports | Count |
|-------------|-------|
| SPF+ (10G)  | 24    |
| QSPF+ (40G) | 2     |

The switch is physically split into 3 groups of 8 SFP+ ports and 1 group
containing the 2 QSFP+ ports. It also has a 100M Ethernet port for management.

```
| 0 | 2 | 4 | 6 |   | 8 | 10 | 12 | 14 |   | 16 | 18 | 20 | 22 |   |  Q0  |   |      |
|---|---|---|---|---|---|----|----|----|---|----|----|----|----|---|------|---|------|
| 1 | 3 | 5 | 7 |   | 9 | 11 | 13 | 15 |   | 17 | 19 | 21 | 23 |   |  Q1  |   | MGMT |
```
