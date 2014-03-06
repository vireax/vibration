---
layout: page
title: Chapter 1 - Introduction
---

## 1.1 Background ##

Genetic Algorithms were invented for different purposes from evolutionary strategies (Mitchell, 1998). The mechanisms of natural adaptation reveal natural genetic operators and natural selection. Based on genetic operators such as crossover, mutation and inversion, individuals within a generation interact to reproduce hopefully offspring who will fit better to the environment. This theoretical foundation leads to successive adaption into computational evolution, and therefore various types of nature-inspired algorithms. No free lunch theorems for optimization (Wolpert & Macready, 1997) suggested that no universally better algorithms exist because the best and efficient algorithms are subject to specific tasks only (Yang, 2010). This theorem encourages researchers to improve their model as well as to cover possible range of application. Vibration based damage detection is a non destructive testing technique usually employed in mechanical and civil applications. Modal properties of the structure such mass, stiffness, and damping are collected for analysis. Damage identification can be classified into different levels such as: presence of damage, location, severity, and prediction of remaining service life; but not limited to classification based on measurement method and instrumentation (Doebling, Farrar, & Prime, 1998). The computation usually involves highly modal function, thus it requires expensive exploration in search space. The answer to optimizing this kind of problem is therefore evolutionary approach because, despite limited ability to search optimum design variables, nature-inspired algorithms have shown various results up to present (Yang, 2010). Not limited to Genetic Algorithms and successive evolutionary techniques, co-operative co-evolution (Potter & Jong, 1994) showed significant improvement by evolving within and between species in each generation. This co-operative approach suggested lower computational cost. However, future implementation of this technique requires the verification of interdependencies between objective function variables. Diverse range of algorithms and applications leads therefore the main purpose of this research. Although the efficiency of every optimization algorithms will not be studied for comparison, the author will verify in depth the efficiency of co-operative co-evolutionary genetic algorithm on simulated damages of truss structures against previous research using the closest test possible.

## 1.2 Objectives ##

This research aims to predict level of damage in truss structure using co-operative co-evolutionary genetic algorithms based on the following specific objectives:  
- To compare the accuracy of damage detection with previous research based on the principle of residual force and CCGA
- To predict damage level while including experimental noise during measurement of modal properties

## 1.3 Scopes ##

- The concept of co-operative co-evolution will be implemented on conventional genetic algorithms only, other family of evolutionary algorithms will not be tested 
- Planar and space trusses will be modeled based on finite element methods to ensure that any error of the solution are only caused by the algorithm itself, not the test subject 
- Damage index of truss element will be numerically simulated, so as the measurement of modal properties of the damaged structure

## 1.4 Significance ##

This research will fill the gap between the integration of theoretical algorithms with application-specific knowledge bases and practical experimental constraints. 
- The accuracy of CCGA over traditional GA allows improved technique in solving optimization problem. 
- Verification with experimental noise allows extension in practical use of the system ratherather than computer simulation and laboratory.

## 1.5 Reviews of literature ##

Vibration based damage detection techniques use changes in the modal properties (frequencies, mode shapes, and modal damping) caused by changes in the physical properties (Doebling et al., 1998). However, slow adoption in industry is caused firstly by inaccuracy in data compression and loss in data transfer of multiple modes. The second obstacle of industrial adoption is caused by the level of sensitivity to global or local response which depends on the level of excitation frequencies modes. In practice, damage identification depends on prior analytical model or prior test data. Finite Elements Methods (FEM) are expected to minimize this dependence but they may not be appropriate in every case. 

Actual measurements require correct placement of sensors for sufficient level of sensitivity, repeatability of the tests, and it is also possible to use vibration induced by ambient environmental (Koo, Jong Jae Lee, & Chung-Bang Yun, 2008) or operating loads for the assessment of structural integrity. Some data set are available for researchers to verify their methods with real cases but not many works have done sufficient comparison. Genetic algorithms (Holland, 1975) have been long implemented from biological evolution to various fields, and therefore, in engineering optimization along with other meta-heuristic applications (Mitchell, 1998). Damage identification has also adopted this technique to solve mechanical and civil problems in beams (Rao, Srinivas, & Murthy, 2004) and structures (Hu et al., 2001; Nobahari & Seyedpoor, 2011), in either simulation or real models. Scarcity of scopes also enables hybrid methods to improve efficiency (Meruane & Heylen, 2011) as well as performance assessment between different techniques (Perera, Ruiz, & Manzano, 2009). Potter & Jong (1994) extended the abstract model of Darwinian evolution and biological genetics by modeling the coevolution of cooperating species. 

Better performance over conventional genetic algorithms suggests therefore potential representation and resolution of higher complexity problems. Recent damage detection in beam (Panigrahi, Chakraverty, & Mishra, 2009) is the core motivation of the second objective. The authors included random noise of 2% in natural frequency and 3% in mode shapes to good agreement of genetic algorithms in identifying damaged and undamaged cases with and without noise. Experimental noise possibly defects the prediction of damage but this problem can never be avoided in practice; examples are irregularity in the body, thermal stress, instrumentation error, etc. If the prediction gives a higher level of accuracy, it should also return better prediction even if are introduced experimental noises. The accuracy of this case clearly cannot be deducted from the performance of the damage identification algorithm alone, CCGA of course, because measurement error occurred earlier than the identification process. However, The algorithm should cover an acceptable range of noise level in order to predict the damage reliably.


<pre><code>
## Background
* CCGA was proven better than GA
* GA was used to solve vibration based damage detection
* CCGA should be able to solve damage detection problems

## Objectives
* Predict damage 
* Predict damage with experimental noise

## Scope
* Structure: 2D and 3D truss
* Noise: between -3% and +3% in $$ \lambda $$ and $$ \phi $$

## Significance
* higher accuracy
* ready for practical use

## Review
* GA
* CCGA
* Vibration based damage detection
* Uncertainty modeling
</code></pre>
