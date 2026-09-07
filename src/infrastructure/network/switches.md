# Switches 

The purpose of this document is to provide more detailed descriptions of our managed network switches. 

## FHILL

FHILL our primary fiber switch on the hill campus. It is a
[Mikrotik CRS326-24S+2Q+RM](https://mikrotik.com/product/crs326_24s_2q_rm)
running `RouterOS v7`. The management interface is assigned to `128.153.145.21`,
and is currently accessible from within the lab network.
If in doubt, the Ethernet port labeled `MGMT/BOOT` should always be configured
to allow access to the management interface.

| Ports           | Count |
|-----------------|-------|
| SPF+ (10G)      | 24    |
| QSPF+ (40G)     | 2     |
| Ethetnet (100M) | 1     |

The switch is physically split into 3 groups of 8 SFP+ ports and 1 group
containing the 2 QSFP+ ports. It also has a 100M Ethernet port for management.

```
| 2 | 4 | 6 | 8 |   | 10 | 12 | 14 | 16 |   | 18 | 20 | 22 | 24 |   |  Q2  |   |      |
|---|---|---|---|---|----|----|----|----|---|----|----|----|----|---|------|---|------|
| 1 | 3 | 5 | 7 |   | 9  | 11 | 13 | 15 |   | 17 | 19 | 21 | 23 |   |  Q1  |   | MGMT |
```

We've configured groups of ports to map to certain [VLANs](../network/vlans.md). Ports not listed below are disabled.

| Ports | VID   | Name       | Speed |
|-------|-------|------------|-------|
| 2     | Trunk |            | 10 G  |
| 0-15  | 2     | cosi\_priv | 10 G  |

## FCOLO

FCOLO is currently our top level fiber switch, located in COLO.
It is a
[Mikrotik CRS326-24S+2Q+RM](https://mikrotik.com/product/crs326_24s_2q_rm)
running `RouterOS v7`. The management interface is assigned to `128.153.145.20`,
and is currently accessible from within the lab network.

| Ports           | Count |
|-----------------|-------|
| SPF+ (10G)      | 24    |
| QSPF+ (40G)     | 2     |
| Ethetnet (100M) | 1     |

The switch is physically split into 3 groups of 8 SFP+ ports and 1 group
containing the 2 QSFP+ ports. It also has a 100M Ethernet port for management.

```
| 2 | 4 | 6 | 8 |   | 10 | 12 | 14 | 16 |   | 18 | 20 | 22 | 24 |   |  Q2  |   |      |
|---|---|---|---|---|----|----|----|----|---|----|----|----|----|---|------|---|------|
| 1 | 3 | 5 | 7 |   | 9  | 11 | 13 | 15 |   | 17 | 19 | 21 | 23 |   |  Q1  |   | MGMT |
```

We've configured groups of ports to map to certain [VLANs](../network/vlans.md).
Traffic between cosi\_pub and cosi\_priv is controlled by the
[firewall.](../../services/firewall.md). Ports not listed below are disabled.

| Ports | VID.  | Name       | Speed |
|-------|-------|------------|-------|
| 1     | 3     | cosi\_pub  | 10 G  |
| 2     | Trunk |            | 10 G  |
| 3-8   | 3     | cosi\_pub  | 10 G  |
| 9-16  | 2     | cosi\_priv | 10 G  |

### STP
Kasper is currently configured as a filtered bridge between `cosi_pub` and `cosi_priv`. STP will detect this as a loop, because even though both ports are on separate VLANs, they are on the same bridge on the switch. To solve this STP has been disabled entirely on FCOLO.
