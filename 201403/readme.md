# March 2014

## Winkler foundation

The unit of coefficient of subgrade reaction is in [MPa/m] or [N/m^2/m]

## Input files

nds.txt 

- position x3, 
- constraints x3, 
- spring stiffness x 3, 
- load x 3

mbs.txt 

- start node
- end node
- RO
- E
- A

## Tests - Objective 1

### 1. 2D Structure (Rao, 2004)

  a. alpha = ones(11,1)  
  b. alpha = ones(11,1), alpha(3) = ... , alpha(6) = ...  
  c. alpha = ones(11,1), alpha(10) = 0  
  
### 2. 2D Structure with elastic support (Kim, 2013)

  a. alpha = ones(16,1)  
  b. alpha = ones(16,1), alpha(9) = 0.3  
  c. alpha = ones(16,1), alpha(5)= 0.4, alpha(13) = 0.3  
  
### 3. 3D Structure with elastic support (Kim, 2013)

  a. alpha = ones(36,1)  
  b. alpha = ones(36,1), alpha(13) = 0.4  
  c. alpha = ones(36,1), alpha(1) = 0.3, alpha(21) = 0.5  

## Charts

- http://vireax.github.io/vibration/results/r1.html
- http://vireax.github.io/vibration/results/r2.html
- http://vireax.github.io/vibration/results/r3.html
