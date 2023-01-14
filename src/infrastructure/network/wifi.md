# WiFi

_updated: Jan 14th 2022_

COSI currently has it's own WiFi access point (AP) at `128.153.144.10`. You can configure the AP by visiting <https://128.153.144.10>. If for some reason you can't reach the configuration page you may find it helpful to reboot the AP. After rebooting there will be a "configuration SSID" in addition to the COSI ones. 

We have both a 2.4 Ghz SSID (cosi-u2) and a 5 Ghz SSID (cosu-u5). **If your device supports connecting to 5 ghz network you must use the 5 ghz network**. The passwords on the two SSIDs should be different to discourage usage of the 2.4 ghz network. 

## Relationship with OIT

OIT (reasonably) isn't a big fan of students/professors/labs/adminstrators running their own access points. Especially on the 2.4 ghz bands. We should do our best to avoid causing too much interference on their network. 

Since 5 ghz is generally "lower range" and better at handling rouge APs we should keep as much traffic on 5 ghz. As part of keeping our 2.4 ghz footprint small we have also turned the transmit power to the lowest setting. The 5 ghz network currently use max transmit power.

We should also periodically check that we are not transmitting on OITs wifi channels. You can do this by using the `Network > Wireless > AP Detection` feature. In general try to keep as much distance as possible in channel selection. 

_updated: Dec 7th 2022_

### Used channels

| WiFi         | OIT      | COSI |
| :----------- | :------- | :--- |
| 2.4 ghz      | 1, 6, 11 | 3, 9 |
| 5 ghz [UNII-1](https://en.wikipedia.org/wiki/Unlicensed_National_Information_Infrastructure) | 48  | 36  |
| 5 ghz [UNII-3](https://en.wikipedia.org/wiki/Unlicensed_National_Information_Infrastructure) | 149 | 161 |

## Hardware

// TODO: Equipment page?

## Firmware

// TODO: We have a second AP that failed a fireware update and it struggles to boot. Unclear if it's revivable. 

