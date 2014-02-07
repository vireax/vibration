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
