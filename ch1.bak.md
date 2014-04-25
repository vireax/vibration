---
layout: page
title: Chapter 1
---

# INTRODUCTION #

## 1.1 Background

In the area of engineering optimization, problems arise endlessly along every possible solution. At some points, deterministic method cannot sufficiently answer complex problems. Darwinian theory of biological evolution has been adopted for solving various disciplines. Based on the principle of survival of the fittest, genetic algorithms encourage crossover process among the fittest individuals, and thus, surpass random gene mutation of single parents in earlier approach of evolutionary algorithms (Holland, Goldberg, X S Yang).

Genetic algorithms were invented for differet purposes from evolutionary strategies (Mitchell, 1998). The mechanisms of natural adaptation reveal natural genetic operators and natural selection. Based on genetic operator such as crossover, mutation and inversion, matings between individuals can hopefully reproduce offsprings which will fit better to the evironment. Thies theoretical foundation leads to successive adoption into computational evolution, and therefore various types of nature-inspired algorithms. *No free lunch theorems for optimization* (Wolpert & Macready, 1997) suggested that no universally better algorithms exist because the best and efficient algorithms are subject to specific tasks only (Yang, 2010). This theorem encourages however researchers to improve their model as well as to cover possible ranges of applications of each technique.

Vibration based damage detection is a non-destructive testing technique (NDT) usually employed in mechanical and civil applications. Modal properties of the structures such as mass, stiffness, and damping are collected for analysis. Damage identification can be classified into different levels such as: presence of damage, location, severity, and prediction of remaining service life; but not limited to other classifications based on measurement method and instrumentation (Doebling, Farrar, & Prime, 1998). The computation usually involve highly modal function, thus it requires expensive exploration in the search space. The answer to optimizing this kind of problem is therefore evolutionary approach because, despite limited ability to search optimum design variables, nature-inspired algorithms have shown various results up to present (Yang, 2010).

Not limited to genetic algorithms and successive evolutionary techniques, co-operative co-evolution showed significant improvement by evolving withing and between species in each generation. This co-operative approach suggested lower computational cost while improving problem solving capabilities in any other evolutionary algorithms (EA). However, future implementation of this technique also requires more verification of interdependencies between objective function variables (Doebling, Farrar, & Prime, 1998).

Diversse range of algorithms and applications leads therefore the main purpose of this research. Although the efficiency of optimization algorithms will not be discussed for comparison, this research will attempt to verify in depth the efficiency of co-operative co-evolutionary genetic algorithm on simulated damages of truss structure with previous research using the same test models.

Prior to this research, conventional genetic algorithm has been proven to solve successfully damage identification in vibrating bodies such as truss structure and beam elements (Rao, 2004). Among different extensions of genetic algorithms (distributed, parallel, micro, ...), co-operative co-evolutionary approach suggests improved performance in several function optimizations (Potter, 1994). This approach divide the whole population into evolution within and among species. Therefore, co-operative co-evolutionary approach should be able to implement/supplement conventional genetic algorithms in order to obtain better solution in vibration based damage identification problem.

## 1.2 Objectives

This research aims to predict level of damage in truss structure using co-operative co-evolutionary genetic algorithms based on the following specific objectives:  

- To compare the accuracy of damage detection with previous research based on the principle of residual force and CCGA
- To predict damage level while including experimental noise in measurement of modal properties

## 1.3 Scopes ##

- The concept of co-operative co-evolution will be implemented on conventional genetic algorithms, other family of evolutionary algorithms are not in the scope of this study
- Planar and space trusses will be modeled based on finite element methods to ensure that any error of the solution are only caused by the algorithm itself, not the real test subject 
- Damage indexes of truss element will be numerically simulated, so as the measurement of modal properties of the damaged structure

## 1.4 Significance ##

This research will fill the gap between the integration of theoretical algorithms with application-specific knowledge bases and practical experimental constraints. 

- The accuracy of CCGA over traditional GA allows improved technique in solving optimization problem. 
- Verification with experimental noise allows extension in practical use of the system rathe than computer simulation and laboratory.

## 1.5 Review

### 1.5.1 Vibration based damage detection

In aerospace and civil industry, vibration based damage detection allows continuous health monitoring of the structure. Changes in physical properties result also changes in mechanical properties, which determine therefore product life and the response/characteristics of failure of the whole system at large. To minimize all possible cost/lost due to these changes, engineers should be able to monitor/make use of modal properties of the structure during operation and predict correctly level of damages and warn signs of failure at the very early stages.

/*technique*/ 
Vibration-based damage detection techniques use changes in modal properties (frequencies, mode shapes, and modal damping) cuaed by changes in physical properties (Doebling et al., 1998). However, slow adoption in industry is caused firstly by inaccuracy in data compression and loss in data transfer of muliple modes. The second obstacle of industrial adoption is caused by the level of sensitivity to global or local response which depends on the level of excitation frequencies modes.

In practice, damage identification depends on prior analytical model or prior test data. Finite Elements Methods (FEM) are expected to minimize this dependence but they may not be appropriate in every case. Actual measurements require correct placement of sensors for sufficient level of sensitivity, repeatability of the tests, and it is also possible to use vibration induced by ambient environment (Koo, Jong Jae Lee, & Chung-Bang Yun, 2008) or operating loads for the assessment of structural integrity. Some data set are available for researchers to verify their methods with real cases but not many works have done sufficient comparison.

Genetic algorithms proposed by Holland (1975) have been long impleented from biological evolution into various fields, and therefore, in engineering optimization along with other meta-heuristic applications (Mitchell, 1998). Damage identification has also adopted this technique to solve mechanical and civil problems in beams (Rao, Srinivas, & Murthy, 2004) and structures (Hu et al., 2001; Nobahari & Seyedpoor, 2011), in either simulation or real test models. Scarcity of scopes also enable hybrid method to improve search efficiency (Meruane & Heylen, 2001) as well as performance assessment between different techniques (Perera, Ruiz, & Manzano, 2009). Potter & Jong (1994) extended the abastract model of Dawinian evolution and biological genetics by modeling the co-evolution of co-operating species. Better performance over conventional genetic algorithms suggests therefore potential representation and resolution of higher complexity problems. 

Recent damage detection in beam (Panigrahi, Chakraverty, & Mishra, 2009) is the core motivation of the second objective. Random noise of 2% and 3% in natural frequencies and in mode shapes were included into the process of damage indentification. 

/*Experimental noise possibly defects the prediction of damage but this uncertainty can never be avoided in practice; examples are irregularity in the body, thermal stress, instrumentation error, etc. If the prediction gives a higher level of accuracy, it should also return better prediction despite small experimental noise. The accuracy of this case cannot be deducted from the performance of the damage identification algorithm, CCGA, alone because measurement error occured before the identification process. However, the algorithm should cover an acceptable range of noise in order to predict the damage reliably.


> findings ...

### 1.5.2 Co-operative co-evolution

> Principle  
> Application  
> Side effect  
> Limit  

/*In theory, the dependency on ... can be explained by ...*/
/*In practice, the model represent ...*/

### 1.5.3 Selected papers 

> Theory: GA (Holland), CCGA (Potter, 1994), Damage detection (Panigrahi)  
> Model: Rao, and Nam Il Kim  
