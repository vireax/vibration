---
layout: page
title: General Questions
---

Other pages: vibration - genetic algorithms - Noise


## What?
* Measure modal properties from a truss structure (2D and 3D)
* Predict if and how much the structure is already damaged


## Why?
* Genetic algorithms: optimization of many design variables is tough
* Vibration based damage detection: allows non-destructive testing and on-line health monitoring without shutting down the whole system.
* Co-operative co-evolution: outperform conventional GAs with many benchmark function. Hopefully, it will also help predict damage levels better than GA.
* Numerical test: real example can face budget constraint, building constraints, data acquisition constraints, etc. Starting point from pure numerical test allow better evaluation on the performance of the algorithm rather than to solve subjectively to a specific problem.
* Noise: measurement can contain noise. Small noise range can be accepted but researchers need to define the general threshold first.
* Truss structures: basic model for calculation in finite elements
* 2D vs 3D: 1) to check whether the performance of the algorithms can degraded following the number of dimensions and elements; 2) to leave API for future extension in industrial practice.

## How?

Objective 1: Predict damage level
* Read physical and mechanical properties of the structure
* Assign partial damage to some elements of the structure
* Guess a set of damage indexes as possible solution
* Calculate the objective value
* Repeat until end of max-gen or convergence of the solution
* Verify with previous research for accuracy and performance

Objective 2: Predict damage level with noise
* Assign 2 ranges of noise for each modal properties
* Calculate exact modal properties
* Deviate from exact properties by measurement noise
* Predict the damage as in objective 1
* Observe
> * difference
> * accept/reject
>* threshold 
## More ... 

Please add your question in <a href="/about.html">About</a> page.
