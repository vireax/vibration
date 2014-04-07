---
layout: page
title: Chapter 4
---

#  RESULTS AND DISCUSSIONS #

## Damage identification

> Chart  
> Table  
> Observation  

| Structures | 1 (Rao, 2004)  | 2 (Kim, 2013)  |  3 (Kim, 2013)  |
| --------- | -------------- | -------------- | --------------- |
| Nb. members  | 11  | 16  | 36 |
| Nb. nodes  | 6  | 8 |  12 |
| Case a | undamaged, alpha(i) = 1 | undamaged | undamaged |
| Case b | partial damage: alpha(3) = 0.7, alpha(6)=0.3 | partial damage: alpha(?) = ?, alpha(?)=? | partial damage: alpha(?) = ?, alpha(?)=?  | 
| Case c | alpha(10) = 0 | partial damage: alpha(?) = ?, alpha(?)=?  | partial damage: alpha(?) = ?, alpha(?)=?  |

### 2D Rao

![Rao, 1a](http://vireax.github.io/vibration/fig201403/prediction1a.png)

![Rao, 1b](http://vireax.github.io/vibration/fig201403/prediction1b.png)

![Rao, 1c](http://vireax.github.io/vibration/fig201403/prediction1c.png)

### 2D Kim

![Kim, 2a](http://vireax.github.io/vibration/fig201403/prediction2a.png)

![Kim, 2b](http://vireax.github.io/vibration/fig201403/prediction2b.png)

![Kim, 2c](http://vireax.github.io/vibration/fig201403/prediction2c.png)

### 3D, Nam Il Kim

![Kim, 3a](http://vireax.github.io/vibration/fig201403/prediction3a.png)

![Kim, 3b](http://vireax.github.io/vibration/fig201403/prediction3b.png)

![Kim, 3c](http://vireax.github.io/vibration/fig201403/prediction3c.png)

## Noise

> Chart  
> Table  
> Observation  

## 4.3 Discussions

The results in Figure 1-7 indicates that co-operative co-evolutionary genetic algorithm can predict the damage effectively. 

From the comparison tables, CCGA outperforms both convetional GA and microGA.

CCGA proves better damage identification because, despite increased number of dimension and degree of freedom, the algorithms is supported by speciation which may in turn improve parallel search in manay species.

However, *No Free Lunch Theorem in Optimization* can raise questionable proof whether there exist tuning parameters which worsen this performance. Although the results extend the precision of the predicted stiffness factor to 8 decimal points and CCGA always give best prediction, there should be some drawback caused by this algorithms. Possible direction in detection the inconvenience may be a close look into varying tuning parameters, increased degree of freedom, ....[list all parameters + ref] 

### Summary review

- methods are vast/huge/confusing/complicated
- we tried to stick to the same models
- it may not garantee the performance with other method, or the same computation method with different algorithm, or different type of structure
- therefore, researcher may have to locate themself either in exploring an overall picture of the field for larger generalization, or study closely to a small topic for deep detail.
- and therefore, we need not only supporting argument. If anyone can find the problem to respective method, the judgement would be more complete.

### regarding noise

The comparison tables suggest small difference between the predicted damage with and without noise. Although this simulation is preliminary, it should be possible to predict certain range of error in damage detection based on known/give error in the actual measurement of the structure. As tested in Panigrahi et al. (2009), we cannot claim that the program can predict accurate result despite error in measurement. Researchers should always be aware of uncertainty in the process. 

/*If large error have no effect on the solution, there should be problematic*/

By observing variation of values in modal properties by 2% and 3% noise range, absolute error at higher modes tend to be many times greater than the exact value in lower mode. After recombining the measurement with these errors in the residual matrix, the objective values tend to move further from zero. It should be possible to eliminate these errors by revising the mathematics of the objective function so that the uncertainty can be separately minimize without affecting ??? the evolution.

One possible way in extending this observation, practitioners shouold be able to expand the range of noise in measurement and to collect the tolerance of the prediction by statistical approach. This work would be in one way relevant to industrial use, and in other way, *API* modular for experimenting different algorithms, models, and methods.

