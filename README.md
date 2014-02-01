## Objectives

* To predict level of damage in truss structures using co-operative co-evolutionary genetic algorithms
* To predict level of damage in presence of experimental error

## Prerequisite

* Vibration: truss structure, eigenvalue problem
* CCGA: Genetic algirithms, natural selection, species, objective function
* Uncertainty modeling: I don't know what this mean yet

## Programming

* CCGA was written originally in C, I'm now working in Matlab, the working program will be ported to Python for [PyKhmer Team](http://pykhmer.info)
* I don't have CS degree; I never attend programming class; I learn these language from tutorials. So, my programming style is just functional and/or procedural (I don't know what it means yet). Please, learn and improve the code at your convenience

## Rationale

* I don't have much to repeat them here. I'm rewriting my draft at http://vireax.github.io/vibration

## TODO 

* DONE: calculate (phi, lambda) = f(mbs, nds)
* add damage index (alpha)
* insert noise [-3%, +3%]
* calculate obj_val = f(lambda, phi, mbs, nds, alpha)
* calculate Fitness = F(Obj...)
* CCGA = f(gen, chrom., Fitness, Species, ..)
* Multiple runs => test statistics

## Commits

* 20140101 Build Jekyll
* 20140201 Rewrite the project description
