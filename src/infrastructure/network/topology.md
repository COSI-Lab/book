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

_updated: December 17th, 2023_

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
	kasper [class="host"];

	subgraph switches {
		node [shape="record"]

		jgw [class="clarkson"];
		sc334 [class="clarkson",label="sc-334-c2960s"];
	
		FHILL [class="agg"];
	
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

	taldos [class="host"];
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
	
	sc334 -- FHILL -- mirror [class="smf10",label="3"];
	FHILL -- kasper [dir=forward,class="smf10",label="3"];
	FHILL -- kasper [dir=back,class="smf10",label="2"];
	FHILL -- tiamat [class="smf10",label="2"];

	FHILL -- private  [label="2"];
	private -- {itl1, itl2, itl3, itl4, taldos, hydra, kasper};
	{itl1, itl2, itl3, itl4} -- ITL;

	FHILL -- {cosi1, cosi2, m2} [label="2"];
	{cosi1, cosi2} -- COSI;

	FHILL -- m3 [label="2,5"];

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
		
		FCOLO [class="agg"];
		FHILL [class="agg"];
		
		mrackl [class="managed"];
		mrackr [class="managed"];
		mnet [class="managed"];

		wifi [class="unmanaged"];

		itl1 [class="unmanaged"];
		itl2 [class="unmanaged"];
		itl3 [class="unmanaged"];
		itl4 [class="unmanaged"];
		cosi1 [class="unmanaged"];
		cosi2 [class="unmanaged"];
	}

	mirror [class="host",href="../../mirror/introduction.md"];
	kasper [class="host",href="../servers/kasper.md"];
	taldos [class="host",href="../servers/talos.html"];
	hydra [class="host",href="../servers/hydra.html"];
	bacon [class="host",href="../servers/bacon.html"];
	tiamat [class="host",href="../servers/tiamat.html"];
	TBD [class="host"];
	elephant [class="host",href="../servers/elephant.html"];
	prometheus [class="host"];
	norm [class="host"];
	"red-dwarf" [class="host"];

	COSI [class="room"];
	ITL [class="room"];
	
	/* Edges */
	internet -- jgw [dir=back,class="clarkson"];
	FHILL -- FCOLO [class="smf10",label="2"];
	FCOLO -- jgw [class="clarkson"];

	FHILL -- {mrackl, mrackr, mnet, hydra, bacon, tiamat} [class="smf10",label="2"];
	mnet -- {itl1, itl2, itl3, itl4, cosi1, cosi2, wifi};
	mrackr -- {norm, "red-dwarf", prometheus} [label="2"];
	mrackl -- TBD [label="2"];
	{cosi1, cosi2} -- COSI [class="room"];
	{itl1, itl2, itl3, itl4} -- ITL [class="room"];
	FCOLO -- {mirror} [class="smf10",label="3"];
	FCOLO -- {elephant, taldos} [class="smf10",label="2"];
	FCOLO -- kasper [dir=forward,class="smf10",label="3"];
	FCOLO -- kasper [dir=back,class="smf10",label="2"];
	norm -- prometheus [class="e10g",label="direct 10G",fontcolor="blue"];
}
```
