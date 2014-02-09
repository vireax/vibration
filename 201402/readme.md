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

## Displacement 

```
Displacement 2D
         0         0         0
    0.0862   -4.7665         0
    0.9556   -7.7125         0
    1.5537   -6.7029         0
    3.6965   -0.3020         0
    3.3944   -4.5874         0
    2.4280   -8.4692         0
    1.9139   -7.2169         0
```

```
Displacement 3D
    5.4107    5.4107   -0.3576
    4.0803    3.5069   -0.1693
    3.8293    3.8293   -1.6373
    3.5069    4.0803   -0.1693
    2.2698    2.2698    0.8667
    2.8820    1.9586   -0.1201
    1.9545    1.9545   -1.2394
    1.9586    2.8820   -0.1201
    1.4568    1.4568    0.9715
         0         0         0
         0         0         0
         0         0         0
```
