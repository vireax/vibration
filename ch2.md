---
layout: page
title: Chapter 2
---

# CO-OPERATIVE CO-EVOLUTION #

> A paragraph explaining organization of the chapter

## 2.1 Genetic algorithm ##

> history  
> principle  
> application in computing  

Genetic algorithms (GA) were invented primarily to understand the mechanism of natural evolution/adaptation. The discovery of genetic operators distinguishes themselves from evolutionary computation where mutation only requires one single parent and one child. Crossover, however, presents a unique feature of GA which recombine both characteristics in two parents in order to reproduce the following population and hopefully, they fit better to the environment (Mitchell, 1998). General procedure of genetic algorithms is simple but GA practitioners may face difficulties in encoding design variables into biological chromosomes, at early stage, as well as selecting the right set of parameters to solve optimization problems efficiently. This task is left to problem specific because it is not possible to fix the best set of parameters for every case. Termination condition can be set either based on the number of maximum generation or the convergence of the fitness value. General procedure of genetic algorithm can be described in pseudocode \ref{alg:ga}. Starting from a random population, the evolution continues as following: 

- Initialize a population 
- Evaluate individual's fitness 
- Select potential parents: elitism, stochastic, rank, ... 
- Add genetic operator: inversion, mutation, crossover 
- Back to step 2 until termination condition (reaching maximum number of generation or acceptable fitness value) 

The termination condition can be either the calculation reaches a predefined maximum number of generations or the fitness value converges toward certain value. Fixed-length, fixed-order bit strings are common encoding techniques in most application: binary encodings, character and real-valued encodings, and tree encodings. It is not possible to choose the best encoding for a particular problem. Although original theory focused more on basic binary encoding schema, later extensions and other kinds of encodings allow more natural representation to real problems. Inversion, evolving crossover hot-spot, and messy GAs are common examples of adaption to GAs. 

## 2.2 Chromosome encoding ##

> binary  
> string  
> real  

## 2.3 Selection ##

> method  
> criteria  
> anything special ?

After encoding design variables into biological chromosomes, the evolution takes place by selecting the best individuals from the current population for mating. However, the solution may be trapped in local optima if the fitness value converges too early, or the search is open ended if the candidates are never accepted after sufficient number of generation. No fixed parameters ensure the efficiency of the algorithms but there must be balance between exploitation and exploration. These selection methods (Table 2) often require experience and trial-and-error to choose the right combination as well as the right parameters. Some selection method can behave similarly to simulated annealing by varying these parameters between generations.


## 2.4 Operators ##

> mutation  
> crossover  

Selection process only picks certain individuals to produce the population of the next generation. Genetic operator modify however the combination of individuals' chromosome. The location of recombination or mutation must be defined by earlier by its probability. Figure 1 details graphically the production of new chromosome based on these operators (Mitchell, 1998). Mutation is a unary variation operator, which means a single parent is responsible to reproduce an offspring by, supposedly causing a random, unbiased change. Fresh blood in the gene pool avoids early local convergence. It has therefore theoretical role to ensure connection in search space. This is the only operator in evolutionary programming. Crossover is a binary variation operator. It is the only operator in genetic programming. Recombination with higher arity is mathematically possible but has no biological equivalent. An offspring is obtained by combining two individual with different but desirable features. Other operators and mating strategies include inversion and gene doubling and several operators for preserving diversity in the population. The main purpose is not to overpopulate within a single species; theoretically the solution may fall into local optima. Matings between similar individuals are therefore restricted.


## 2.5 Co-operative co-evolution ##

> extensions of GAs  
> ccga by potter, 1994  

Co-operative co-evolution was designed firstly to prove better performance than conventional genetic algorithms. Then it should be also applicable in other evolutionary algorithms. This concept was distinguished from the competition within subpopulation such as parallel GAs (Grosso, 1985) and distributed GAs (Whitley & Starkweather, 1990). Co-operative co-evolution takes place based on the following conventions (Potter & Jong, 1994): Division of the population into species Assembly of representative members of each of the species to form the complete solutions Credit assignment at the species level based on the fitness of the complete solutions Evolution of the number of species if required Evolution of each species by standard genetic algorithm

## 2.6 Approaches in vibration based damage detection ##

> vibration > modal properties  
> objective function  
> findings  
