---
layout: page
title: Chapter 3 - Numerical Test
---

## 3.1 Procedure

### 3.1.1 Damage prediction

(Objective 1: How to predict damage?)

In order to predict damage level in each member of a truss structure, the measurement of modal properties (natural frequencies and mode shapes) are taken in advance. Numerical iteration starts by guessing a set of damage indexes ($$ \beta $$). These indexes reduce the local and therefore the global stiffness of the structure. Based on global mass and stiffness of the structure, simulated modal properties can be calculated as eigensolution of the two previous matrices. If the resulted modal properties are similar to the measurements, the prediction are correct and can be accepted. Otherwise, we will keep guessing until reacing the closest values possible. In worst case, we can never guess the right value because the design space is too huge.

The evaluation of closeness of the prediction is summarized by an objective function which combines all elements of the matricese of the predicted damage indexes and measuremed modal properties. The solution should be final if the objective value converges over interations. Otherwise, the problem is divergent and cannot be solved either because of wrong parameter settings or the technique is not suitable for this problem.

Purely random guess of damage indexes may not ensure to lead to the best solution within a limited number of iteration. Therefore, the evolutionary approach reproduce the next sets of variable based on the fitness of the previous sets. One set of variables is similar to an individual with its own chromosome. The fittest individual can hopefully reproduce even better individuals of the next generation. The selection takes place by giving priority to the fittest but also allowing the least fittest to reproduce.

More ... 
- Program flow / pseudocode / flowchart
- how to summarize data?
- ...

### 3.1.2 Damage prediction with measurement error

(Objective 2: How to predict damage despite noise)

Noise should be minimal at all stages. Previous section assumes that the meausurement was as accurate as analitical solution of the vibrating structures. However, this is not the case in industrial application. From the imperfection of real structures to instrumentation error, these modal properties cannot be as accurate as numerical model.

To evaluate the accuracy of the damage identification in practical use, experimental noise will be included during the measurement of modal properties. The resulted measurement will be calculated in objective function in previous damage detection technique with CCGA. The difference will be observed by varying the measurement error from -3% to +3% in natural frequencies and mode shapes. 

Todo ...
* Prahigani 
* Program flow

## 3.2 Test cases

### 3.2.1 2D Structure

Based on Rao et al., 2004
- 6 nodes
- 11 members-
- 1 pivot and 1 roller supports
- E, ro, A, l
- 
Cases
- undamaged $$ \alpha = ones(11) $$
- partially damaged ( members 3 and 6)
- 1 missing member (10)

Todo
- (image)

### 3.2.2 3D Structure

Based on Nam Il Kim, 2013
- 12 nodes
- 36 members
- fixed support in all four bottom nodes
- E, ro, A, l

Cases
- undamaged
- (?)...
- (?)...

## 3.3 Results

### 3.3.1 Damage prediction

Todo...
- result of 2D (in table)
- result of 3D (in table or chart because of too many elements)

### 3.3.2 Damage predition with noise

Todo...
- 2D (2 level table, $$ noise \in \[-3%,+3%\] $$ 
- 3D (2 level table, $$ noise \in \[-3%,+3%\] $$ 

## Discussion

