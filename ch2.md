---
layout: page
title: Chapter 2 - Review
---


## 2.1 Optimization ##

Optimization can be defined mathematically the search of the best decision or design variables in the search space while answering the objective function and equality and inequality constraints (x) (Yang, 2010). Generic form of optimization can be written mathematically as follow:

minimize x,, (1)

subject to =0, , (2)

0, , (3) where , and are function of the design vector x=. Classification of optimization problems can be based on the objective, constraint, landscape, functions form, variables, and determinacy. Depending on the complexity of the problem, only some optimization algorithms are suitable. In case of stochastic problem (uncertainty and noise in the design variables and the objective functions and/or constraints), standard optimization techniques need to be redefined in combination with statistics. Deterministic algorithms are conventionally suitable for solving linear optimization while stochastic algorithms can solve more difficult optimization problems in a reasonable amount of time. Meta-heuristic algorithms perform even better than heuristic approach based on some abstractions of nature. The advantages of these nature-inspired algorithms are based on selection of the best solution, thus convergence to optimality, and randomization which avoid trapping in local optima and ensure diversity of the solution. 



The efficiency of an algorithm is largely determined by their complexity. The algorithm complexity is often denoted by the order notations such as O(n ) or O() knowing n the size of the problem or input size, but the details of this topic is beyond the scope of this research. Common meta-heuristic algorithms listed in chronological order in Table 1 do not infer that older techniques become obsolete over years but they will increase diversity in order to become hopefully suitable candidates in reducing NP-hard problems (non-deterministic polynomial-time) which are still unsolvable in many real applications. This is a class of computational complexity problem where solution cannot be found in polynomial time relative to input size. Finally, although averaging the efficiency of different algorithms based No Free Lunch Theorems proves no better algorithm than another, it is always important to choose the most efficient algorithms to solve a particular problem. 

## 2.2 Genetic algorithms ##

### 2.2.1 Procedure ###

Genetic algorithms (GA) were invented primarily to understand the mechanism of natural evolution/adaptation. The discovery of genetic operators distinguishes themselves from evolutionary computation where mutation only requires one single parent and one child. Crossover, however, presents a unique feature of GA which recombine both characteristics in two parents in order to reproduce the following population and hopefully, they fit better to the environment (Mitchell, 1998). General procedure of genetic algorithms is simple but GA practitioners may face difficulties in encoding design variables into biological chromosomes, at early stage, as well as selecting the right set of parameters to solve optimization problems efficiently. This task is left to problem specific because it is not possible to fix the best set of parameters for every case. Termination condition can be set either based on the number of maximum generation or the convergence of the fitness value. General procedure of genetic algorithm can be described in pseudocode \ref{alg:ga}. Starting from a random population, the evolution continues as following: Initialize a population Evaluate individual's fitness Select potential parents: elitism, stochastic, rank, ... Add genetic operator: inversion, mutation, crossover Back to step 2 until termination condition (reaching maximum number of generation or acceptable fitness value) The termination condition can be either the calculation reaches a predefined maximum number of generations or the fitness value converges toward certain value. Fixed-length, fixed-order bit strings are common encoding techniques in most application: binary encodings, character and real-valued encodings, and tree encodings. It is not possible to choose the best encoding for a particular problem. Although original theory focused more on basic binary encoding schema, later extensions and other kinds of encodings allow more natural representation to real problems. Inversion, evolving crossover hot-spot, and messy GAs are common examples of adaption to GAs. 

### 2.2.2 Selection methods ###

After encoding design variables into biological chromosomes, the evolution takes place by selecting the best individuals from the current population for mating. However, the solution may be trapped in local optima if the fitness value converges too early, or the search is open ended if the candidates are never accepted after sufficient number of generation. No fixed parameters ensure the efficiency of the algorithms but there must be balance between exploitation and exploration. These selection methods (Table 2) often require experience and trial-and-error to choose the right combination as well as the right parameters. Some selection method can behave similarly to simulated annealing by varying these parameters between generations.

Table 2 Selection methods

Selection Description Fitness-proportionate Each individual earns a probability to reproduce based on their fitness, prevent premature convergence Sigma Scaling Maps raw values to expected values to avoid premature convergence, limit reproduction by highly fit individual Elitism Retains a number of the best individual Boltzman Similar to simulated annealing, continuously varying temperature, controls the rate of selection Rank selection Prevents too quick convergence, depends on rank not on absolute fitness Tournament selection Only requires a single pass, thus computationally more efficient than rank selection Steady State selection Controls generation gap, only few individuals are replaced 2.2.3 Genetic operators Selection process only picks certain individuals to produce the population of the next generation. Genetic operator modify however the combination of individuals' chromosome. The location of recombination or mutation must be defined by earlier by its probability. Figure 1 details graphically the production of new chromosome based on these operators (Mitchell, 1998). Mutation is a unary variation operator, which means a single parent is responsible to reproduce an offspring by, supposedly causing a random, unbiased change. Fresh blood in the gene pool avoids early local convergence. It has therefore theoretical role to ensure connection in search space. This is the only operator in evolutionary programming. Crossover is a binary variation operator. It is the only operator in genetic programming. Recombination with higher arity is mathematically possible but has no biological equivalent. An offspring is obtained by combining two individual with different but desirable features. Other operators and mating strategies include inversion and gene doubling and several operators for preserving diversity in the population. The main purpose is not to overpopulate within a single species; theoretically the solution may fall into local optima. Matings between similar individuals are therefore restricted.

Algorithm 1: Conventional genetic algorithm 1 2 3 4 5 6 7 8 9 gen = 0 ; Pop = randomly initialized population; evaluate fitness of each individual in Pop(gen); while termination condition = false do gen=gen+1 select Pop(gen) from Pop(gen-1) based on fitness ; apply genetic operator to Pop(gen); evaluate fitness of each individual in Pop ; end



Figure 1 Genetic operators

## 2.3 Co-operative co-evolutionary genetic algorithm  ##

Co-operative co-evolution was designed firstly to prove better performance than conventional genetic algorithms. Then it should be also applicable in other evolutionary algorithms. This concept was distinguished from the competition within subpopulation such as parallel GAs (Grosso, 1985) and distributed GAs (Whitley & Starkweather, 1990). Co-operative co-evolution takes place based on the following conventions (Potter & Jong, 1994): Division of the population into species Assembly of representative members of each of the species to form the complete solutions Credit assignment at the species level based on the fitness of the complete solutions Evolution of the number of species if required Evolution of each species by standard genetic algorithm

Algorithm 2: Co-operative co-evolutionary genetic algorithm 1 2 3 4 5 6 7 8 9 10 11 12 13 gen = 0 ; foreach specie s do Po = randomly initialized population; evaluate fitness of each individual in Po(gen); end while termination condition = false do gen = gen + 1 ; foreach specie s do select Po(gen) from Po(gen-1) based on fitness ; apply genetic operator to Po(gen); evaluate fitness of each individual in Po ; end end

<pre>
## Related researches

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel porttitor lectus. Integer sodales tincidunt nisi sed fermentum. Morbi eget nulla quis arcu sagittis dictum. Etiam ligula leo, dapibus eu elit sed, fringilla consequat eros. Aliquam ipsum est, fringilla a ante ac, sagittis dignissim dui. Nunc condimentum posuere rhoncus. Vivamus porttitor, dui et aliquam posuere, urna tortor ultricies est, at placerat elit tortor non ipsum. Donec condimentum magna sed ipsum ultricies interdum.

## Genetic algorithms
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel porttitor lectus. Integer sodales tincidunt nisi sed fermentum. Morbi eget nulla quis arcu sagittis dictum. Etiam ligula leo, dapibus eu elit sed, fringilla consequat eros. Aliquam ipsum est, fringilla a ante ac, sagittis dignissim dui. Nunc condimentum posuere rhoncus. Vivamus porttitor, dui et aliquam posuere, urna tortor ultricies est, at placerat elit tortor non ipsum. Donec condimentum magna sed ipsum ultricies interdum.

## Co-operative co-evolution
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel porttitor lectus. Integer sodales tincidunt nisi sed fermentum. Morbi eget nulla quis arcu sagittis dictum. Etiam ligula leo, dapibus eu elit sed, fringilla consequat eros. Aliquam ipsum est, fringilla a ante ac, sagittis dignissim dui. Nunc condimentum posuere rhoncus. Vivamus porttitor, dui et aliquam posuere, urna tortor ultricies est, at placerat elit tortor non ipsum. Donec condimentum magna sed ipsum ultricies interdum.

## Uncertainty modeling
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel porttitor lectus. Integer sodales tincidunt nisi sed fermentum. Morbi eget nulla quis arcu sagittis dictum. Etiam ligula leo, dapibus eu elit sed, fringilla consequat eros. Aliquam ipsum est, fringilla a ante ac, sagittis dignissim dui. Nunc condimentum posuere rhoncus. Vivamus porttitor, dui et aliquam posuere, urna tortor ultricies est, at placerat elit tortor non ipsum. Donec condimentum magna sed ipsum ultricies interdum.



## Testing LaTeX

$$ \begin{aligned} \dot{x} & = \sigma(y-x) \\ \dot{y} & = \rho x - y - xz \\ \dot{z} & = -\beta z + xy \end{aligned} $$
</pre>
