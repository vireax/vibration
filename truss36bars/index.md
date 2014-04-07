---
layout: default
title: 36 Bars Truss
date: 2014-02-24
---

<style type="text/css">
/*body { 	background:#fff; 	color:#333; 	text-align:center;
	font-size:small;	line-height:1.8em; 
	margin:0em auto;	}*/
#wrap {width:680px; margin:0 auto;text-align:left;padding:20px 0;background:none;} 
#graphdiv {background:#fff; padding:0px; border:1px solid #ccc;float:left;}
#graphdiv .dygraph-label { font-family: Georgia,Verdana,serif; }
#graphdiv .dygraph-title { font-size: 36px; text-shadow: 2px 2px 2px gray; }
#graphdiv .dygraph-ylabel { font-size: 18px; text-shadow: -2px 2px 2px gray; }
/*.chart { border: 1px dashed black; margin: 5px 5px 5px 50px; padding: 2px; }	*/
.chart { border: 1px dashed black; margin: 0; padding: 0px; }	
#labels {border-bottom:1px solid #aaa;	width:100px;margin:0; 
padding:10px; font-size:.8em;line-height:1.2em; float:right;}

</style>
<script type="text/javascript" src="dygraph-combined.js"></script>

<div id="wrap">
<h1>Result: 36 bars truss</h1>
<div><p>Select parts of the chart horizontally to zoom in or double-click to return to original canvas.</p></div>
<div id="graphdiv" 
	class="chart" >
	<!--style="width:480px; height:500px;"-->
	Graphdiv...
</div>
<div id="labels">label...</div>

<div style="clear:both; padding-top:2em;">
<p> <strong>Objective 1: </strong>This chart summarizes the damage prediction in space truss using CCGA. Under unknown damage to any member, the modal properities of the structure such as natural frequencies and mode shapes change accordingly. In this research, it is possible to predict these damage indexes using cooperative coevolutionary genetic algorithm based on given properties</p>
<p> <strong>Objective 2: </strong>What if the given measurement is not accurate? The accuracy of the prediction will also vary but there should be certain level of error that can be accepted statistically.</p>
</div>
<img src="http://oi43.tinypic.com/2e397bq.jpg" />
</div>
<script type="text/javascript">
  g2 = new Dygraph(
    document.getElementById("graphdiv"),
    "data.csv", // path to CSV file
    {
	//title: 'Predicted Damage Indexes for 36 bars truss structure',
	titleHeight:16,
	labels: ["step","01", "02", "03", "04", "05", "06", "07", "08", "09", "10","11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36"],
	width:540,
	height:400,
	//'Damage Index':{axis:{}},
	xlabel:'Iteration',
	ylabel: 'Damage Indexes (BETA)',
	axes: {
/*	  x: {
		valueFormatter: function(ms) {  return 'xvf(' + new Date(ms).strftime('%Y-%m-%d') + ')';	},
		axisLabelFormatter: function(d) { return 'xalf(' + d.strftime('%Y-%m-%d') + ')';
		},
		pixelsPerLabel: 100,
	  },
	  */
/*	  y: {
		valueFormatter: function(y) {return 'yvf(' + y.toPrecision(2) + ')';		},
		axisLabelFormatter: function(y) { return 'yalf(' + y.toPrecision(2) + ')';	}
		},
		*/
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
