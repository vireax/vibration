---
layout: page
title: Chapter 5
---

# CONCLUSION #

/*2014-04-06*/

The objective of this research has been to solve vibration based damge detection in truss structure using co-operative co-evolutionary genetic algorithm. Written in Matlab, the program assigns a predefined set of damage serveral elements of the structure, computes the objective function based on modal properties of the damaged structure, and evolve following genetic algorithms in multiple species, and considering the stiffness factors of each element as the decision variables.

The results show reliable convergence toward the predefined damage levels and higher accuracy comparing to detection on the same models with conventional genetic algorithm (Rao et al., 2004) and micro genetic algorithm (Kim et al., 2013). 

The same program simulates the detection with experimental noise within the range of 2% and 3% in natural frequencies and mode shapes. The prediction become less accurate but suggest that margins of error can be predicted based on changes in experimental noise.

Despite every effort in justifying the applicability of CCGA in solving damage detection problem, these claims are openly falsifiable in future research with the following recommendations.

CCGA was found to outperform other two extensions of genetic algorithms in overall, wider combination of each parameters were not observed. These should be different combination that can deliver optimal condition which improves the performance. While searching for optimal parameters, unsatisfactory values should also be found. This exploration should justify the comparison between algorithms in more complete manner.

With too many algorithms, calculation methods, and use cases; the researchers can look not only optimal tuning parameters for solving each problem efficiently but also optimal criteria in choosing the right technbique for the right problem. At this point, researchers should be therefore aware of the positioning either to look closely and deeply into a narrow scope, or far from subjective tasks for capturing the whole picture based on many findings.

Experimental noise can be included optionally in academic research but cannot be avoided in practice. For practical reason, wider range of noise should be tested to predicte the range of tolerance of the damage detection. For theoretical reason, since change in the detection varies following noise and absolition noise at higher mode is many time greater than the lower mode, elimination of uncertainty/error in the objective function should be done to improve not only the performance of CCGA and also other algorithms.

