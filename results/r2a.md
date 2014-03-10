---
layout: page
title: Kim 2D 2a
date: 2014-02-24
---

<script type="text/javascript" src="dygraph-combined.js"></script>

<div id="wrap">
<h1>Result: 2a</h1>
<div><p>Select parts of the chart horizontally to zoom in or double-click to return to original canvas.</p></div>
<div id="graphdiv" 
	class="chart" >
	<!--style="width:480px; height:500px;"-->
	Graphdiv...
</div>
<div id="labels">label...</div>

</div>
<script type="text/javascript">
  g2 = new Dygraph(
    document.getElementById("graphdiv"),
    "data2a.csv", // path to CSV file
    {
	//title: 'Predicted Damage Indexes for 36 bars truss structure',
	titleHeight:16,
	labels: ["step","01", "02", "03", "04", "05", "06", "07", "08", "09", "10","11","12","13","14","15","16"],
	width:540,
	height:420,
	delimiter:"\t",
	//'Damage Index':{axis:{}},
	xlabel:'Iteration',
	ylabel: 'Stiffness factor (BETA)',
	axes: {
		y: {
		valueFormatter: function(y) {return y.toPrecision(8) ;		},
		axisLabelFormatter: function(y) { return y.toPrecision(2) ;	}
		}
	},
	legend: 'always',
	strokeWidth:1,
	labelsSeparateLines:true,
	labelsDiv:document.getElementById("labels"),
	axisLabelFontSize:10,
	highlightSeriesOpts: {strokeWidth: 3,},


	}          // options
  );
</script>


