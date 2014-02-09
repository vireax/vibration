Summary
=======================

## Objective 1

Predict damage in 2D and 3D truss structures

### Tasks
* 2D
  * Case 1: \alpha = 1
  * Case 2: \alpha != 1
  * Case 3: \alpha != 1
* 3D
  * Case 1: \alpha = 1
  * Case 2: \alpha != 1
  * Case 3: \alpha != 1

### Summary table
* \alpha vs. \beta for each case
* => 6 runs


## Objective 2

Effect of measurement noises on the prediction (\beta)
### Grid
* err_lambda = -3%:+3% --> lambda_m = (1+err_lambda) x lambda*
* err_phi = -3% : + 3% --> phi_m = (1+err_phi) x phi*

### Tasks
* 2D
  * Case 1: \alpha = 1
  * Case 2: \alpha != 1
  * Case 3: \alpha != 1
* 3D
  * Case 1: \alpha = 1
  * Case 2: \alpha != 1
  * Case 3: \alpha != 1

### Summary table
* residual = Sum of sqare (alpha_i - beta_i)
* tabular data of residual in function of err_lamba and err_phi

## 20140209

`vibration.m`

To include the effect of spring element, the stiffness of the spring on the assigned node will be included using superposition method. Therefore, the structure's stiffness is calculated as unrelated to the elastic support, the springs' stiffness will be included before elimination of rows and columns associated constrained nodes.

With input file (csv):  ` nodes = px, py, pz, cx, cy, cz, kx, ky, kz `

With external forces, 3 more columns are needed: ` nodes = px, py, pz, cx, cy, cz, kx, ky, kz, fx, fy, fz `

``` matlab

for i = 1: nb_nds
    % retrieve kx, ky, kz from node i
    kx = nds(i, 7);
    ky = nds(i, 8);
    kz = nds(i, 9);
    % push values to the global stiffness matrix, in diagonal terms
    K (3*i-2, 3*i-2) = K(3*i-2, 3*i-2) + kx;
    K (3*i-1, 3*i-1) = K (3*i-1, 3*i-1) + ky;
    K (3*i, 3*i) = K (3*i, 3*i)+ kz;
end
```
