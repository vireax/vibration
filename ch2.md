---
layout: page
title: Chapter 2
---

# CO-OPERATIVE CO-EVOLUTION #

*A paragraph explaining organization of the chapter*

In order to solve damage detection problem using co-operative co-evolutionary genetic algorithms, prior knowledge of conventional genetic algorithms, encoding, selection method, and reproduction should provide a baseline into programming ccga. Based on the concept of evolution within species and finite element analysis of vibration in truss structure, numerical tests in the next chapter should provide practical approach for comparison with previous works on similar structure.

## 2.1 Genetic algorithm ##

- history
- principle
- application in computing

Genetic algorithms (GA) were invented primarily to understand the mechanism of natural evolution/adaptation. The discovery of genetic operators distinguishes themselves from evolutionary computation where mutation only requires one single parent and one child. Crossover, however, presents a unique feature of GA which recombine both characteristics in two parents in order to reproduce the following population and hopefully, they fit better to the environment (Mitchell, 1998). General procedure of genetic algorithms is simple but GA practitioners may face difficulties in encoding design variables into biological chromosomes, at early stage, as well as selecting the right set of parameters to solve optimization problems efficiently. This task is left to problem specific because it is not possible to fix the best set of parameters for every case. Termination condition can be set either based on the number of maximum generation or the convergence of the fitness value. General procedure of genetic algorithm can be described in pseudo-code. Starting from a random population of the first generation, the evolution continues as following: 

1. Initialize a population
2. Evaluate individual's fitness
3. Select potential parents: elitism, stochastic, rank, etc
4. Add genetic operator: inversion, mutation, crossover
5. Back to step 2 until termination condition (reaching maximum number of generation or acceptable fitness value)

The termination condition can be either the calculation reaches a predefined maximum number of generations or the fitness value converges toward certain value. Fixed-length, fixed-order bit strings are common encoding techniques in most application: binary encoding, character and real-valued encoding, and tree encoding. It is not possible to choose the best encoding for a particular problem. Although original theory focused more on basic binary encoding schema, later extensions and other kinds of encoding allow more natural representation to real problems. Inversion, evolving crossover hot-spot, and messy GAs are common examples of adaption to GAs. 

*2014-03-18-start*
Genetic algorithms scale down biological evolution into computer program. The evolution of most organisms requires/has/includes tow main processes: natural selection and sexual reproduction. From a pool of population, the fittest individuals having higher chance to survive, are more convenient to reproduce to ensure mixing and recombination of genes in their offsprings. Their fitness to the environment will adapt regularly by recombination of genes better than obtaining an exact copy of a single parent.

Relying beyond mutation operator used in evolutionary programming, the recombination of groups of genes has been proven mathematically as a critical part of the evolution. The first step is to encode physical problem into DNA-like structure/string. Binary encoding has been used as the promary technique, then real value encoding make the representation of variable more natural. Other criteria may involve fixed-length and fixed-order byte code depending on the complexity of the problem. The second step evaluate individuals fitness to the required criteria such as objective function(s) and constraint(s). The third step, in principle, select the fittest individuals for reproducing offsprings. Various selection techniques are available so as to maintain the balance between exploration and exploitation. The **idea** is to avoid trapping in local optima and to ensure diversification in the whole search space. Rather than allwing only the fittest group to survive, the least fittest are also given their probability for reproduction corresponging to their fitness values. The fourth step create offspring by recombination of groups of genes. Crossover involves 2 parents while mutation only flip certain parts of the original copy of a single parent. It is not possible to ensure mathematically htat the new generation can raise candidates more potential than their parent but biologically, the evolution of large number of population and generations was observed to provide successful results. *The evolution continues by repeating these steps*. In computer program, maximum number of generation or convergence criteria should be predefined to finalize the candiate solution. 

*2014-03-18-end* 
## 2.2 Chromosome encoding ##

> binary, string, real

reference - mitchel, 98

- GAs perform not very well with unimodal function
- binary schema is unnatural
- binary - gray, diploid
- string length vs. degree of implicit parallelism
- performance depends on problem and the detail of GA
- tree encoding schemes - GP - open-ended
- paradox

Chromosome encoding is responsible in translating numerical variables into the convention of gene and allele, so that the biological reproduction can abstract out the construct of the problem and variables. Binary encoding scheme was first proposed (Holland, 1975) to mimic the composition of biological chromosome. Later on, gray and diploid encoding extend the (?) functionality of the algorithm/technique while (?...) compromising the string length and degree of implicit parallelism. 

The difference in terms of performance between binary and real value encoding is still subjective to the implementation and the depth of use of the algorithms. Although mostly unnatural for engineering problems, both encoding technique still have their own strength and weaknesses.

*String or real value encoding overcomes/breaks the restriction to continuous search space in previous technique*. String and real-valued encoding overcomes the restriction to continuous search space [K. Deb, SBX, ...]. Despite the implication of Hollnd's schema-counting argument on lower performance than binary encoding, the prediction of a better encoding is problem dependent.

The use beyond(*of more than just*) fixed-length and fix-order bit string enables therefore open-ended search space, and can cause significant problem. However, this attempt is only the beginning of genetic programming community in tree encoding schemes. 

**adapting the encoding** 
Adapting  one type of encoding over another can affect the performance of genetic algorithm but it is not always possible to select the right one in advance. Rather than sticking to fixed encoding, it should be possible to adapt also the encoding during the evolution. However, while varying-length representation is possible/can overcome the complexity of the candidate solution, memory size requirement and types of strategies of the evolution are the main concern in order to .... 

Techniques of adaptions of encoding include inversion, evolving crossover hotspot, and messy GAs. Inversion is a reordering operator for fixed length chromosomes by choosing two points in the string and reversing the order of the bits between them. Evolving crossover hotspot takes by evolving the position of crossover, and therefore introduces crossover and mutation at once based on its crossover template in parent individuals. Messy GAs combine building blocks of partial underspecified templates, cut and spice to produce legal string. One latest technique, simulated binary crossover (SBX), maintain the concept of search poser to deal with real encoding and therefore solve successfully encoding restriction in most engineering applications. 



## 2.3 Selection ##

> method  
> criteria  
> anything special 

*After encoding design variables into biological chromosomes, the evolution takes place by selecting the best individuals from the current population for mating. However, the solution may be trapped in local optima if the fitness value converges too early, or the search is open ended if the candidates are never accepted after sufficient number of generation. No fixed parameters ensure the efficiency of the algorithms but there must be balance between exploitation and exploration. These selection methods (Table 2) often require experience and trial-and-error to choose the right combination as well as the right parameters. Some selection method can behave similarly to simulated annealing by varying these parameters between generations.*

Selection in GAs is to create offsprings from fitter individuals from the population, to obtain more individual with higher fitness in the next generation(mitchel, 1998). Although each method is problem dependent, the main purpose is to maintain the balance between exploitation and exploration. Otherwise, the algorithm may converge to sub-optimal individuals, preventing diversity, or the evolution can become too slow. 

Fitness proportionate selection distribute individual's probability to reproduce in a roulette wheel proportinal to their fitness value and obtain individual after spinning the wheel *N* times. Stochastic universal sampling (SUS) only spin the wheel once by giving *N* equally spaced pointers to the pool (baker, 1987) *(the rate of the evolution depends on the variance of fitnessses in the population)*. Sigma scaling method maps raw fitness value to expected values to reduce premature convergence. Therefore, fitter individuals can be less visible at the beginning and relevant later when the standard deviation become low. Elistism forces GAs to remain some best individuals at each generation to avoid particpating in selection and recombination process. Rank selection is an alternative method without the need of scaling fitnesses. Since the expected values of the individuals depend on its rank, the absolute differences in fitness has no influence on the selection. Such linear ranking slow down the selection pressure but increase the preservation of diversity. This feature can be both strength and rawback which avoid quick convergence existed in fitness proportionate selection. Tournament selection is more computationally efficient than previous methods by eliminating two passes in fitness proportionate selection and sorting in rank scaling. This technique chooses one out of two individuals pulled randomly from the population, returns both back to the pool, and repeat the process until sufficient number of requiredd individuals. Steady state selection try to maintain generation gap where only few least fit individuals are replaced by potential offspring. This concept is also known as incremental learning and collective problem solving.

## 2.4 Genetic Operators ##

> mutation  
> crossover  

*Selection process only picks certain individuals to produce the population of the next generation. Genetic operator modify however the combination of individuals' chromosome. The location of recombination or mutation must be defined by earlier by its probability. Figure 1 details graphically the production of new chromosome based on these operators (Mitchell, 1998). Mutation is a unary variation operator, which means a single parent is responsible to reproduce an offspring by, supposedly causing a random, unbiased change. Fresh blood in the gene pool avoids early local convergence. It has therefore theoretical role to ensure connection in search space. This is the only operator in evolutionary programming. Crossover is a binary variation operator. It is the only operator in genetic programming. Recombination with higher arity is mathematically possible but has no biological equivalent. An offspring is obtained by combining two individual with different but desirable features. Other operators and mating strategies include inversion and gene doubling and several operators for preserving diversity in the population. The main purpose is not to overpopulate within a single species; theoretically the solution may fall into local optima. Matings between similar individuals are therefore restricted.*

The recombination of individual characteristics is a very essential role in order to create fitter offspring. Crossover is the main feature that distinguish genetic algorithms from many existing evolutionary computation method where only mutation at random point in the chromosome of a single parent. The simplest form, single point crossover, switches parts of parents' chromosome to recombine building blocks on different string, but can cause positional bias in long string and also lead to the preservation of hitchikers (undesired bit keeps following the useful schema), and end-point effect. Two-point crossover is then used/practiced/applied/proposed to solve/overcome thes inconvenience. Beyond the limitation of two-point crossover, more points can be used with also parameterized uniform crossover.

Crossover is not the only feature strength of genetic algorithms. Mutation has the same ability for disruption of existing schemas, with crossover as amore robust construction of new schemas. it is therfore neccessary to consider correct balance among crossover, mutation, and selection. *The details of the fitness function and encoding are somehow the important factor in obtaining the correct balance among xover, mutation and selection*.

Other less conventional operators are also available in the purpose of preserving diversity in the population. Thes include inversion, gene doubling, crowding, and speciation. A different way is to put restriction on mating by distinction of species, prevention of incest, and mating tags along chromosomes.

One missing concept related to real-value encoding has been proposed as simulated binary crossover (SBX) operator (K. Deb, yyyy?). Variables in many engineering problems are encoded in real value. By ..., ..., ... GAs users should be able to focus on the problem solving rather than encoding from-and-to binary encoding.

## 2.5 Co-operative co-evolution ##

> extensions of GAs  
> ccga by potter, 1994  

Co-operative co-evolution was designed firstly to prove better performance than conventional genetic algorithms. Then it should be also applicable in other evolutionary algorithms. This concept was distinguished from the competition within sub population such as parallel GAs (Grosso, 1985) and distributed GAs (Whitley & Starkweather, 1990). Co-operative co-evolution takes place based on the following conventions (Potter & Jong, 1994): Division of the population into species Assembly of representative members of each of the species to form the complete solutions Credit assignment at the species level based on the fitness of the complete solutions Evolution of the number of species if required Evolution of each species by standard genetic algorithm

## 2.6 Approaches in vibration based damage detection ##

> vibration - modal properties  
> objective function  
> findings  
