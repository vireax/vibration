---
layout: post
title: Progress Report
date: 2014-03-02
---

## Elastic foundation ##

Coefficient of subgrade reaction is in MPa/m or N/m^2/m. There is not document explaining how to convert subgrade reaction to a single spring stiffness to support truss structure. By chance, I chose ks = 99461 N/m as an equivent spring constant and the result of the displacement is similar to the calculation in Nam Il Kim, 2013. I still don't know how to formulate this model yet. I only doubt that C. V. G. Vllabhan and Y. C. Das, "A refined model for beam on elastic foundations", 1991, (ref23) use a 1 m x 1 m plate suppor. However, I cannot access this paper from the university profile.

Anyway, below is the result from unit test by vibrating the structure with elastic support and under loading condition

(image)

## Numerical Tests ##

### 1. Rao, 2004, 2D structure, 11 members, 6 nodes ##

(image)

### 2. Nam Il Kim, 2013, 2D structure, elastic support, 16 members, 8 nodes ###

(image)

### 3. Nam Il Kim, 2013, 3D structure, elastic support, 36 members, 12 nodes ###

(image)
