---
layout: post
title: Formulation of stiffness with elastic support
date: 2014-02-08
---

## Finite element method ##

Stiffness of member 'e'
<div> $$ k^{(e)}  = \frac{AE}{l} \begin{bmatrix}1 & -1 \\-1 & 1 \end{bmatrix} $$ </div>

Member stiffness in global coordinate
<div> $$ \underline{k} =  \underline{T}^{T} \hat{k} \underline{T } $$ </div>

Or
<div> 
$$ \underline{k}  = \frac{AE}{l} \begin{bmatrix}
\underline{\lambda} & -\underline{\lambda} \\
-\underline{\lambda} & \underline{\lambda} \end{bmatrix} $$ 
</div>

With

<div>
$$ \underline{\lambda} = 
\begin{bmatrix}
Cx^2 & CxCy & CxCz \\
CyCx & Cy^2 & CyCz \\
CzCx & CzCy & Cz^2
\end{bmatrix}
$$
</div>
<div> $$ Cx = cos(\theta_x), Cy = cos(\theta_y), Cz = cos(\theta_z) $$</div>

Based on superposition method, the global stiffness of the structure becomes <span> $$ K = k^{(1)} + k^{(2)} + ... + k^{(n)} $$</span>

In case 3 spring elements are added to ith node

<div> $$ k_i =  \begin{Bmatrix}k_x \\k_y \\k_z \end{Bmatrix} $$ </div>

These 3 values will inclue directly into the diagonal terms of global stiffness corresponding to elements i without disturbing local stiffness of other elements. To prove this claim, each spring element are parallel to each axis, and therefore, only one term of Cx or Cy or Cz can be equal to 1. The other ends of the spring are considered fixed, leaving therefore rows and colums 4,5,6 unaffecting the stiffness matrix of the structure.

For example, a spring parallel to X-axis: Cx = 1, Cy = 0, Cz = 0

<div> $$
\underline{k} =  
\begin{bmatrix}1 & 0 \\ 0 & 0 \\ 0 & 0 \\
0 & 1 \\ 0 & 0 \\ 0 & 0\end{bmatrix}
k_x  \begin{bmatrix}1 & -1 \\-1 & 1 \end{bmatrix} 
\begin{bmatrix}1 & 0 & 0 & 0 &0 & 0 \\ 
0 & 0 & 0 & 1 &0 & 0 \end{bmatrix} 
$$</div>


## Programming ##

* Remove spring element from the system
* Calculate member stiffness in local coordinate
* Calculate member stiffness in global coordinate
* Add each member's stiffness to structure's stiffness matrix
* Add spring's stiffness on associated nodes' rows and columns, following each axis

To calculate displacement, force, and reaction
* Remove rows and columns relative to undisplaced direction of each nodes
* Calculate the displacement by displacment method <span>$$ K U = F $$ </span>
* member's internal force: based on Hook's law
* reaction force on support and by spring elements: rebuild full stiffness matrix
