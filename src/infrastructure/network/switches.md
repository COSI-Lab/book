# Switches 

The purpose of this document is to provide more detailed descriptions of our managed network switches. 

## F2

_updated: Jan 12th 2023_

F2 is currently our top level fiber networking switch. It is a Juniper QFX 3500 running `JUNOS 12.3X50-D30.2`. The management interface is [assigned]() to `128.153.145.21`.

| Ports | Count |
|-------------|-------|
| SPF+ (10G)  | 48    |
| QSPF+ (40G) | 4     |

The switch is physically split into 6 groups of 8 SFP+ ports and 1 group of 4 QSPF+ ports. 

```
| 0 | 2 | 4 | 6 |   | 8 | 10 | 12 | 14 |   | 16 | 18 | 20 | 22 |   |  Q0  |  Q2  |   | 24 | 26 | 28 | 30 |   | 32 | 34 | 36 | 38 |   | 40 | 42 | 44 | 46 |
|---|---|---|---|---|---|----|----|----|---|----|----|----|----|---|------|------|---|----|----|----|----|---|----|----|----|----|---|----|----|----|----|
| 1 | 3 | 5 | 7 |   | 9 | 11 | 13 | 15 |   | 17 | 19 | 21 | 23 |   |  Q1  |  Q3  |   | 25 | 27 | 29 | 31 |   | 33 | 35 | 37 | 39 |   | 41 | 43 | 45 | 47 |
```

We've allocated (but have no configured) groups of ports to map to certain VLANs. Likewise, even number SFP+ ports are allocated for 10 gigabit while odd numbers are allocated to 1 gigabit. 

| Ports | VLANs    | Speed |
|-------|----------|-------|
| 0-7   | v2\_wan  | 10 G  |
| 8-15  | v2\_wan  | 1 G   |
| 16-23 | TBD      |       |
| 24-39 | v3\_lan  | 10 G  |
| 40-47 | v3\_lan  | 1 G   |

On the back there are 2 RJ45 ports for management over IP and a RJ45 port for serial management using a cross over serial cable. The serial connection has a baud rate of `9600`.

