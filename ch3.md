---
layout: page
title: Chapter 3
---

# NUMERICAL TESTS #

*Overviews*

Three truss structures selected from previous researches (Rao et al., 2004; Kim et al., 2013) were modeled in finite element method and tested with co-operative co-evolutionary gnenetic algorithm. The program assigns different set of stiffness factor/damage index to each element, calculate the modal properties as the measurement, evolve the prediction of damage index to satisfy  the objective function based on simulated modal properties and the physical properties of each structure.

/*To illustrate the effectiveness of CCGA in damage identification in truss structures, three models were choosen from previous two related researches. The program will predict several sets of damage of each structure with the same damage condition. The comparison can be made by the coseness of the prediction to the assigned damage indexes.*/

## Test cases ##

The first truss model consists of 11 members, attached to 6 nodes, and supported by a simply support end/hinge and a roller type (Fig 1). Mechanical properties are modulus of elasticity (E = 207 GPa), density (\rho = 7860 kg), cross-sectional area (A = 0.0011 m^2), and length of each bay (l =  0.75 m). Three test cases were considered as a) an undamaged structure, b) partial damage in element 3 and 6, and c) complete damage in element 10.

> Figure 1 : truss 2D (M. A. Rao et al., 2004)

The second model is also a planar truss with elastic support at one end in place the roller type. The structure consists of 16 elements and 8 nodes with the following properties: E = 70 MPa and A = 0.01 m^2 (Fig. 2). Simulation cases are a) partial damage in element 9 (\alpha-9 = 0.7), and b) partial damage in elements 5 and 13 ( \alpha-5 = 0.6, \alpha-3 = 0.7).

> Figure 2 : truss 2D (Kim et al., 2013)

The third model represent a space truss consisting of 36 elements, 12 nodes, support by 3 simply support ends and elastic foundation on one end/elastic spring. Test cases are a) \alpha13 = 0.6 and b) alpha-1 = 0.7, alpha-21 = 0.5. The mechanical properties are consistent with the second model.

> Figure 3: truss 3D (Kim et al. 2013)

It is important to clarify that the terms *damage index*,  *stiffness reduction*, and *oooo* represent equally the percentage of defect/imperfection in the elements. A healthy/fully functional element should have its value 0 and a total damage is represented by 1. Other althernative terms being used in this research is stiffness factor or stiffness index: 0 for total damage and 1 for healthy element.

Elastic foundations used in models 2 and 3 are represented by spring elements which simplify the calculation of stiffiness matrix by superposition method. /*refer to the book []*/

The summary table of the seven test cases (Table 1) concludes the stiffness factors to be assigned into the simulation of respective model. In case of simulated experimental noise, the same program will repeat these order by inserting random noise during the calculation of modal properties.

> table 1: summary of test situation

Case    |   elements    |   DoF |   Induced damage |
--------------------------------------------
1 |  |  |  |
2 |  |  |  |
3 |  |  |  |
4 |  |  |  |
5 |  |  |  |
6 |  |  |  |
7 |  |  |  |
-------------------------------------------

## 3.2 Objective function ##

The objective function of damage detection problem has been formulated using resudual for method (Rao et al, 2004; Panigrahi et al., 2009, Kittipong, 2013). Given that a structure changes its modal properties following changes in physical 
properties due to presence of element defects, if a program can guess a correct set of damage indexes the resulting modal properties should be equal to the exact given properties. However, the prediction can rarely be accurate to the pre-defined exact values. At least, there should be very small difference contributing to each element of the matrices of eigenvalues and eigenvectors, vibration characteristics representing natural frequencies and mode shapes. These differences can be summarized into a scalar value which compare the closeness between different predictions to the exact damage.

The governing equation of motion of the dynamics of multi-degree freedom system is given by

> eq. (1)

where [m] and [k] are (nxn) mass and stiffness matrices, {x} and {F} are (nx1) displacement and applied force vector

The associated jth eigen equation is given by

> eq. (2)

where \lamda-j and {v-j} are the jth eigen values and corresponding eigenvector.

The sum of the expanded element stiffness matrices forms the global stiffness in the finite element model of the structure

> eq. (3)

This  summation also applies when damage occurs in the structure. The damage factors \alpha-i (i=1,2,..,N) are first mulltiplied to elements stiffiness matrix

> eq. (4) [kd] = \sigma i=1 N \alpha-i [k] i

where N is the number of elements  and \alpha i \in [0,1] denoting an undamage element with 1, reduction in stiffness (\alpha \lt 1) until total damage of the element (\alpha = 0)

The experimental eigenvalue and eigenvector satisfy the eigen equation (2), 

> eq. (5)

Given \beta-i (i = 1, 2, ..., N) the decision variables representing the predicted stiffness factors in each element, the resulting global stiffness can be written as

> eq. (6) [kd] = sigma \beta [k]i

By substituting the reduced stiffness [kd] in the eigen equation (5), and expression of residual force vector for jth mode in function of \beta i can be written as

> eq. (7) {Rj}= ...

The (nxn) residual force matrix [R] can be therefore written as 

> eq. (8) [R] = [ {R1} {R2} ... {Rn} ]

{Rj} will be {0} only if each predicted damage stiffness \beta i = \alpha i (i = 1, 2, ..., N), and therefore leading [R] = {0}

The objective function summarises this residual matrix by computing the square root of the sum of square of every element.

> eq. (9) f

where N is the number of element, n is the degree of freedom.

/*?mention differences from Rao and Panigrahi in diagonal terms?*/
> vibration 
> elastic support

## Damage identification ##

> procedure > algorithm 1
> parameters  > Table 2: parameter settings
> data

This problem can be solved wiith any scientific software or programming language based on the guideline in the following section. In this research, a program was written in Matlab. The result consist of comma separated value in clear text to allow furtter implementation with spreadsheet and graphic manipulation software. 

The program was written based on the following procedure

- read input files containing information of the test model
- initiate experimental stiffness factor
- calculate modal properties of the damaged structure
- generate a random vector \beta i (i = 1, 2, ..., N) \beta i \in [0, 1], multiplied by the number of species
- in each generation of each species, evaluate fitness, select fittest individual, crossover and mutation, 
- write predicted stiffness factor to csv file
- plot figure of the prediction over generations


> algorithm 1: damage detection

- read input
- assign damage \alpha i
- calculate \lambda and \phi
- randmize \beta i x species
- while (gen &lt; max-gen) do
    - foreach species do
        - eval fitness
        - select
        - xover and mutate
    - end
- return fittest offsprings
- end


This program starts by retrieving nodes and elements properties from two comma separated value (CSV) files. Nodes' data contains spatial position, constraints, and loads in x, y, z direction as a standard procedure in finite lement program. Elements' data consist of indexes of starting and ending nodes, element's density (\rho), modulus of elasticity (E), and cross-sectional area (A). Although the three last variables are consistent in our test models, the program is made flexible to varying properties in each elements by modifying the input file only. The stored arrays are useful for further calculation inside the program without rereading repeatedly the input files.

Experimental damage factors are then included into array of truss elements' properties following each situation in Table 1.

These damage factors are therefore included in the calculation of element stiffness, then structure's stiffness, and finally the modal properties of the damaged structure \lambda-d and \phi-d.

Initialization of predicted damage factors \beta-i is purely randomized. The number of array is the number of population multiplied by the number of species. The array's length is the number of chromosome, thus the number of elements of the structure.

From these individuals, the program evaluates the fitness value of each individual before selecting potential candidates to reproduce. In this research, elitism and stochastic universal sampling (SUS) selections are used. The fittest individual withing and among species will be selected as the solution if termination criteria are validated. 

The evaluation of fitness value is based on the minimization criteria. The raw fitness values (Fi) are calculated from the objective value (fi) of each individual (Eq. 10), then normalized (NFi) among individuals in the current population (Eq. 11). This normalized fitness value NFi is then scaled with a scaling factor (SCF) to make more difference between the maximum and average fitness values (Eq. 12).

> eq. 10 : Fi = 
> eq. 11 : NFi = 
> eq. 12 : SFi = 

/*explain selection: why and how*/

Two selection operator are used before recombination of chromosomes: elitism and stochastic universal sampling (SUS). Elitism operator keeps a set number of fittest individuals, preventing them from mating, and merges back their characteristics in the offsprings pool. This operator ensure that the best solution is not lost in case the best individuals in the next generation are worse than their parents. *Stochastic universal sampling ...*

During this coevolution, the interaction between species neither harms or helps another, and the main purpose of this numerical optimization is to choose the best solution among many potential candidates from many species; the program will keep supporting virtually indefinitely the evolution. As soon as the time comes or termination criteria are satisfied, the best individual can ensure to be the fittest among its population, among multiple species, and through natural selection over many generations.

### 3.3.1 Parameter settings

These parameters are obtained by trial and error to achieved satisfactory results. Because the exploration of optimal parameters is still open-ended, these values are proven to help sove the current problem with good performance.

> Table 2: parameters 

Parameters  |   Values
---------------------
generation | ..
species | ..
chromosome length | ..
xover | ...
mutation | ...
---------------------



## 3.4 Experimental noise ##

Noise is always unavoidable in practice. Considering instrumentation, measurement, and data transfer; uncertainty should be kept minimal and to an acceptable tolerance [?]. In this research, CCGA might or might not be proven to be effective in damage detection. However, the performance of the algorithm should not be judge with the experimental noise. In this section random noise in the ranges of 2% and 3% in natural frequencies and mode shapes are included randomly into the exact measurement of modal properties. The evolution takes place following the same procedure as explained in previous section until reaching termination criteria. Maximum number of generation is used here as termination criteria.

> Algorithm 2

- read input
- assign damage \alpha i
- calculate \lambda and \phi exact
- calculate \lambda and \phi measured with noise
- randmize \beta i x species
- while (gen &lt; max-gen) do
    - foreach species do
        - eval fitness
        - select
        - xover and mutate
    - end
- return fittest offsprings
- end


The result will be collected for comparison with damage detection without noise. Figure of the evolution can be also plotted to illustrate visually the convergence of the prediction.

## 3.5 Summary ##

This chapter presented test models for simulation, cases of damages on each model, and programming procedure for each objective of the research. Reasons and techniques to produce each step should provide sufficient guide to test the algorithm numerically. 
