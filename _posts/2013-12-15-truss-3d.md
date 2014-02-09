---
layout: post
title: Truss 3D 
date: 2013-12-15
---

[code](https://github.com/Vireax/vibration/blob/master/201312/15_truss3d.m)
<pre><code>
    Read file from nodes(position x, y, z and constraints x, y, z) and members files
    Initialize empty arrays for K and M
    For each members,
        Retrieve starting and ending nodes number, and its properties (density, modulus, and cross-section)
        From nodes' coordinates, calculate length and angle to each axis
        Build the 3D transformation matrix 
        Calculate local mass and stiffness matrix
        Push local to global mass and stiffness
    Remove rows and columns of constrained nodes
    Calculate eigenvalue and eigenvector
    Display()
</code></pre>
