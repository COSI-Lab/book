# Topology

_updated: Feb 12, 2024_


Note: Topology graphs have been temporarily removed due to dependency issues with `mdbook-graphviz`.

# Current Topology

_updated: Feb 12, 2024_

## Server Room

> ### Switch FHILL
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | Internet Gateway | 3    | 10G Optical |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | Kasper (WAN)     | 3    | 10G Optical |
> | Upublic          | 3    | 1G Copper   |
> | Mirror           | 3    | 10G Optical |
> | Kasper (LAN)     | 2    | 10G Optical |
> | Uprivate         | 2    | 1G Copper   |
> | Tiamat           | 2    | 10G Optical |
> | Hydra            | 2    | 10G Optical |
> | Janet            | 2    | 10G Optical |
> | Elephant         | 2    | 10G Optical |
> | WiFi AP          | 2    | 1G Copper   |

> ### Switch Upublic
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FHILL            | U    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | ITL Projector PC | U    | 1G Copper   |
> | hbox             | U    | 1G Copper   |

> ### Switch Uprivate
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FHILL            | U    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | MrackL           | U    | 1G Copper   |
> | MrackC           | U    | 1G Copper   |
> | MrackR           | U    | 1G Copper   |
> | COSI Sw/Patch    | U    | 1G Copper   |
> | ITL Sw/Patch     | U    | 1G Copper   |
> | TalDos           | U    | 1G Copper   |

> ### Switches MrackL/MrackC/MrackR
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | Uprivate         | 2    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | Multiple Hosts   | 2    | 1G Copper   |

## COLO

> ### Switch FCOLO
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FHILL            | 3    | 10G Optical |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|

# Desired Topology

_updated: Feb 12, 2024_

## Server Room

> ### Switch FHILL
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FCOLO            | 3    | 10G Optical |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | Kasper (WAN)     | 3    | 10G Optical |
> | Upublic          | 3    | 1G Copper   |
> | Kasper (LAN)     | 2    | 10G Optical |
> | Uprivate         | 2    | 1G Copper   |
> | Hydra            | 2    | 10G Optical |
> | Janet            | 2    | 10G Optical |
> | WiFi AP          | 2    | 1G Copper   |

> ### Switch Upublic
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FHILL            | U    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | ITL Projector PC | U    | 1G Copper   |
> | hbox             | U    | 1G Copper   |

> ### Switch Uprivate
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | FHILL            | U    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | MrackL           | U    | 1G Copper   |
> | MrackC           | U    | 1G Copper   |
> | MrackR           | U    | 1G Copper   |
> | COSI Sw/Patch    | U    | 1G Copper   |
> | ITL Sw/Patch     | U    | 1G Copper   |
> | TalDos           | U    | 1G Copper   |

> ### Switches MrackL/MrackC/MrackR
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | Uprivate         | 2    | 1G Copper   |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | Multiple Hosts   | 2    | 1G Copper   |

## COLO

> ### Switch FCOLO
> | Upstream Link    | VLAN | Link Type   |
> |------------------|------|-------------|
> | Internet Gateway | 3    | 10G Optical |
>
> | Downstream Link  | VLAN | Link Type   |
> |------------------|------|-------------|
> | Kasper (WAN)     | 3    | 10G Optical |
> | Mirror           | 3    | 10G Optical |
> | Kasper (LAN)     | 2    | 10G Optical |
> | FHILL            | 3    | 10G Optical |
> | Tiamat           | 2    | 10G Optical |
> | Elephant         | 2    | 10G Optical |
> | TalDos           | 2    | 1G Copper   |