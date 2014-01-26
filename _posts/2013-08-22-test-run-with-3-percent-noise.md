---
layout: post
title: Test Run with 3% Noise
date: 2013-08-22
---

## Revisions

0.0.1 > Combine all functions in a single .m file
0.0.2 > Include random noise of +/-3% max in the measurement of mode shapes and frequencies

From 10 repeated run of 3 cases, I'm not sure if the results are in satisfactory range. Based one the original code, the program assign damage index to some elements, measure modal properties of the structure, then solve the problem using CCGA. Because each measurement are only evaluated once to detect the damage, the program may not be able to detect the damage accurately.

It is possible to solve the damage multiple times based on one measurement. A set of damage require multiple measurements and one measurement requires multiple detection process.

## Code
<img src="http://vibration.ximplex.info/_/rsrc/1377166518660/notes/testrunwith3noise/20130822_full_source_code.png" />

## Results

<img src="http://vibration.ximplex.info/_/rsrc/1377166188407/notes/testrunwith3noise/20130822_without_noise.png" />

<img src="http://vibration.ximplex.info/_/rsrc/1377166188390/notes/testrunwith3noise/20130822_with_noise.png" />
