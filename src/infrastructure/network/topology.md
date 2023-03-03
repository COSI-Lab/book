# Topology

_updated: Jan 15th 2023_

**Legend: Edges**

| Style  | Description                   |
|--------|-------------------------------|
| Red    | 40 gigabit single mode fiber  |
| Orange | 10 gigabit single mode fiber  |
| Black  | 1 gigabit copper ethernet     |
| Green  | Patch Panel (speed varies by patch health) |
| Blue   | Special (read label by label) |
| Gray   | Controlled by OIT             |

Numeric labels on edges represent [VLANs](#vlans).

**Legend: Ovals**

| style  | description                |
|--------|----------------------------|
| Red    | Host                       |
| Green  | Room                       |
| Gray   | Controlled by OIT          |
| Green  | Patch Panel                |

**Legend: Boxes (switches)**

| style  | description                |
|--------|----------------------------|
| Purple | Aggregation (fiber) Switch |
| Blue   | Managed Switch             |
| Black  | Unmanaged Switch           |

If you have trouble distinguishing colors, you can read the source code.

## Current Topology

_updated: Mar 2nd 2023_

```dot process
/* COSI network topology
 *
 * Some things to keep in mind:
 * - Filenames must be both in the repo root (so `graphviz` itself sees them)
 *   and in the same directory (so they're hosted from the right place in the
 *   built book). The easiest way to do this is a symlink.
 * - The edge orientation is "tail -- head". `headlabel` and `taillabel` are
 *   powerful tools.
 */

graph {
	layout="sfdp";
	bgcolor="#dddddd";
	
	/* Nodes */
	internet [shape=none,height=1,width=1,fixedsize=true,image="cloud.gif",label=""];
	mirror [class="host"];
	ziltoid [class="host"];

	subgraph switches {
		node [shape="record"]

		jgw [class="clarkson"];
		sc334 [class="clarkson",label="sc-334-c2960s"];
	
		f2 [class="agg"];
	
		m2 [class="managed"];
		m3 [class="managed"];

		private [class="unmanaged"];
		wifi [class="unmanaged"];

		itl1 [class="unmanaged"];
		itl2 [class="unmanaged"];
		itl3 [class="unmanaged"];
		itl4 [class="unmanaged"];
		cosi1 [class="unmanaged"];
		cosi2 [class="unmanaged"];
	}

	talos [class="host"];
	eldwyn [class="host"];
	hydra [class="host"];
	tiamat [class="host"];
	prometheus [class="host"];
	COSI [class="room"];
	ITL [class="room"];
	// shitch;
	// "grand-dad" [class="host"];
	// bacon [class="host"];
	// f1 [class="agg"];
	
	/* Edges */
	internet -- jgw[dir=back,len=1,class="clarkson"];
	jgw -- sc334 [class="clarkson"];
	
	sc334 -- f2 -- mirror [class="smf10",label="3"];
	f2 -- ziltoid [dir=forward,class="smf10",label="3"];
	f2 -- ziltoid [dir=back,class="smf10",label="2"];
	f2 -- tiamat [class="smf10",label="2"];

	f2 -- private  [label="2"];
	private -- {itl1, itl2, itl3, itl4, talos, hydra, ziltoid};
	{itl1, itl2, itl3, itl4} -- ITL;

	f2 -- {cosi1, cosi2, m2} [label="2"];
	{cosi1, cosi2} -- COSI;

	f2 -- m3 [label="2,5"];

	m2 -- {prometheus, wifi};
	m3 -- {eldwyn};
}
```

## Desired Topology

_updated: Mar 2nd 2023_

```dot process
graph {
	layout="sfdp";

	bgcolor="#dddddd";
	ratio=0.75;
	
	/* Nodes */
	internet [shape=none,height=1,width=1,fixedsize=true,image="cloud.gif",label=""];
	
	subgraph switches {
		node [shape="record"]
		jgw [class="clarkson"];
		sc334 [class="clarkson",label="sc-334-c2960s"];
		"beef*" [class="clarkson"];
		
		fcolo [class="agg"];
		fhill [class="agg"];
		
		mnet [class="managed"];
		mrackl [class="managed"];
		mrackr [class="managed"];

		wifi [class="unmanaged"];
		shitch [class="unmanaged"];
		itl1 [class="unmanaged"];
		itl2 [class="unmanaged"];
		itl3 [class="unmanaged"];
		itl4 [class="unmanaged"];
		cosi1 [class="unmanaged"];
		cosi2 [class="unmanaged"];
	}

	mirror [class="host",href="../../mirror/introduction.md"];
	ziltoid [class="host",href="../servers/ziltoid.md"];
	hydra [class="host",href="../servers/hydra.html"];
	bacon [class="host",href="../servers/bacon.html"];
	tiamat [class="host",href="../servers/tiamat.html"];
	eldwyn [class="host",href="../servers/eldwyn.html"];
	"grand-dad" [class="host"];
	ziltoid [class="host",href="../servers/ziltoid.html"];
	talos [class="host",href="../servers/talos.html"];
	elephant [class="host",href="../servers/elephant.html"];
	prometheus [class="host"];
	norm [class="host"];
	"red-dwarf" [class="host"];
	COSI [class="room"];
	ITL [class="room"];
	
	/* Edges */
	internet -- jgw [dir=back,class="clarkson"];
	jgw -- {sc334, "beef*"} [class="clarkson"];
	"beef*" -- ITL [class="room"];
	fhill -- sc334 [class="smf10",label="3"];
	fcolo -- jgw [class="smf10",label="3"];

	fcolo -- fhill [class="smf10",label="2,4,5,6,7"];
	fhill -- {mnet, hydra, bacon, tiamat} [class="smf10",label="2"];
	fhill -- mrackl [label="2,5"];
	fhill -- mrackr [label="2"];
	mnet -- {itl1, itl2, itl3, itl4, cosi1, cosi2, wifi};
	mrackr -- {norm, "red-dwarf", prometheus} [label="2"];
	mrackl -- "grand-dad" [label="2"];
	mrackl -- eldwyn [label="2,5"];
	{cosi1, cosi2} -- COSI [class="room"];
	{itl1, itl2, itl3, itl4} -- ITL [class="room"];
	shitch -- talos;
	shitch -- ziltoid;
	fcolo -- {mirror} [class="smf10",label="3"];
	fcolo -- shitch [dir=forward,label="2"];
	fcolo -- elephant [class="smf10",label="2"];
	fcolo -- shitch [dir=back];
	fcolo -- ziltoid [dir=forward,class="smf10",label="3"];
	fcolo -- ziltoid [dir=back,class="smf10",label="2"];
	norm -- prometheus [class="e10g",label="direct 10G",fontcolor="blue"];
}
```

- _"beef" is switch with a 40 gigabit uplink that has yet to been allocated by OIT. It will connect the Window's machines to OIT's lab vlan._

## VLANS

_updated: Jan 15th 2023_

> TODO: Make a separate page for VLANs w/ a short explanation and more detail.

COSI has the following VLANs.

| VLAN id | name   | description
|---------|--------|-------------
| 1       | unused | Many switches this is the default, therefor we don't use it 
| 2       | v2\_cosi\_priv   | Our "default". This VLAN is behind the [firewall](../../services/firewall.md).
| 3       | v3\_cosi\_public | VLAN with a direct connection to OIT. This is infront of the [firewall](../../services/firewall.md).
| 4       | v4\_146 | VLAN for the 128.153.146.0/24 network. Currently this is unused and not well documented
| 5       | v5\_phones | VLAN for Voice Over IP (VOIP) phones. Read [Asterisk](../../services/asterisk.md) for more information.
| 6       | v6\_iot | VLAN for untrusted devices that require an internet connect. Think : Amazon Alexa |
| 7       | v7\_cameras | A very poorly named VLAN for untrusted devices that do not require an internet connect. Consider the printer. Arguably, it seems the need for this VLAN is low.
