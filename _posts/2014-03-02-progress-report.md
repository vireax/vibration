---
layout: post
title: "Progress report"
date: 2014-03-02
---

## Elastic foundation ##

Coefficient of subgrade reaction is in MPa/m or N/m^2/m. There is not document explaining how to convert subgrade reaction to a single spring stiffness to support truss structure. By chance, I chose ks = 99461 N/m as an equivent spring constant and the result of the displacement is similar to the calculation in Nam Il Kim, 2013. I still don't know how to formulate this model yet. I only doubt that C. V. G. Vllabhan and Y. C. Das, "A refined model for beam on elastic foundations", 1991, (ref23) use a 1 m x 1 m plate suppor. However, I cannot access this paper from the university profile.

Anyway, below is the result from unit test by vibrating the structure with elastic support and under loading condition

![vibration elastic support](http://oi60.tinypic.com/20fyf75.jpg "Vibrate Elastic Support")

![vibrate result](http://oi57.tinypic.com/5bxx50.jpg "Vibrate Result")

## Numerical Tests ##

### 1. Rao, 2004, 2D structure, 11 members, 6 nodes ##

![image](http://oi57.tinypic.com/2s67q7s.jpg "2D structures, simply support")

### 2. Nam Il Kim, 2013, 2D structure, elastic support, 16 members, 8 nodes ###

![image](http://oi57.tinypic.com/x8zva.jpg "2D structure, elastic support")

### 3. Nam Il Kim, 2013, 3D structure, elastic support, 36 members, 12 nodes ###

![image](http://oi58.tinypic.com/a32i42.jpg "3D structure, elastic support")
