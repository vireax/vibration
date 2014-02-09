---
layout: post
title: Test statistics
date: 2013-12-25
---

Statistical tests can be used to validate the result at any step during the course of the research. In this research, vibration-based damage detection, the predicted damage indexes may not always provide the same answer in every run. It is possible to run multiple time,  retrieve means and variances, test with the induced damage. If the test statistics do not fit the critical value with a significance level $$ \alpha $$, the results can be rejected.

In the case of measurement of modal properties with uncertainty, an amount of noise will be introduced into these measurement, and therefore causes the program to predicted less accurately. At a threshold, although CCGA perform better than conventional GA, the prediction will not be reliable at all. Statistical test will be used here whether we should accept or reject the given result. Chi-square test goodness-of-fit may be the closest approach to decide the acceptance criteria.

<div>$$ \chi^2 = \sum \frac {(Observe - Expected)^2} {Expected} $$</div>

Errors will range from -3% to +3%. However, 2 variables are to be included: frequency and mode shape. Therefore, it will be more appropriate to separate the range of error by these variable, then to observe the variation of the predicted damage later. Any prediction that cause chi_square to exceed the critical value will be rejected, thus the given error cannot be used to predict the damage accurately any more.

Monte Carlo Simulation: it is unnecessary to simulate the measurement because these value with be calculated/grouped into a single mean value, then predict the same process as described earlier. We are not going to predict the real damage, but we are evaluating at what level of error, the prediction cannot be reliable anymore.

Extreme cases will be tested first:( (-3%, -3%), (3%, 3%), (-3%, +3%) and (3%, -3%) ), to ensure that null hypothesis can be rejected somewhere within the chosen range. What if despite these error the prediction still work fine? It means that the prediction invade other given measurement or these errors have not relationship to the variation of the damage prediction. What's next? Someone must verify the mathematical model of the solution for hidden reason.

<span> $$ \chi^2 (critical value, p) $$</span>: table to summarize all simulations


This means that 49 (7x7) simulations are needed to get this table, multiplied by number of repetitions (3 or 5 or 7 if necessary). The degree of freedom for chi square test is therefore (nb-members -1) x (nb-repetition -1). The expected values are \alpha.

* <span> $$ \epsilon_\lambda $$ </span> = \[-3%,+3%\]  
* <span> $$ \epsilon_\phi $$</span>= \[-3%,+3%\] 

For one case, eg.  <span> $$ \epsilon\_\lambda $$ </span> = 2% and $$\epsilon\_\phi $$ = -1% 

<pre><code>
\beta vs. \test_cases, 
.... , test 1,  test 2,  test 3, ....,  test n
\beta_1
\beta_2
\beta_n
</code></pre>

Next:

* ANOVA may be interesting but I need time to learn and to fit output more. I'm not sure yet if I can do anything with regression. 
* Simulation can be expensive. It may be better to run some part at a time and write solution to individual files for future summary
* To find structures used as test case/benchmark
* To push all result into web based, interactive graphic for better visualization (Dygraphs.js fits best)
