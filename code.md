---
layout: page
title: Programming walkthrough
---

<div style="position:fixed, top:0; padding:1em; width:auto; background:#f7f7f7;">
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat ultrices tellus vitae ultricies. Curabitur eu arcu mauris. Cras pharetra magna ac libero ultricies, sed cursus sapien pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque eu pretium ipsum. Pellentesque aliquam mattis massa, ut condimentum sapien ultricies id. Nullam rutrum nunc nec enim laoreet tincidunt. Maecenas interdum arcu a neque rutrum consectetur. Proin tristique augue sed tristique faucibus. In a consequat tellus. Phasellus vulputate vitae orci a feugiat. Aliquam erat volutpat. Phasellus convallis elit ac commodo suscipit. Curabitur sodales feugiat odio non malesuada. Integer pretium condimentum dui, egestas placerat lectus mollis quis. 
</div>

## 1. Calculation of modal properties

### 1.1. Read input file from nodes and elements

{% highlight matlab %}

nds = csvread('nds.txt');
mbs = csvread('mbs.txt');

{% endhighlight %}

### 1.2. Calculate stiffness and mass matrix

* Init structure's  stiffness and mass matrix `size = 3*nb_nds`
* Scan each members
* Retrieve nodes number
* Retrieve nodes position
* Calculate local stiffness
* Calculate global stiffness, using transformation of coordinates

{% highlight matlab %}

nb_nds = size(nds,1);   
nb_mbs = size(mbs,1); 
M = zeros(3*nb_nds);    
K = zeros(3*nb_nds);

% to be removed when include in GA program
alpha = ones(nb_mbs,1);

for i = 1:nb_mbs
    ndi = mbs(i, 1);   %   start node
    ndj = mbs(i, 2);   %   end node
    ro   = mbs(i, 3);   %   density
    E    = mbs(i, 4);   %   modulus
    A    = mbs(i, 5);   %   cross-section
    % alpha : damage index will be inserted here
    % stiffness [k] and mass [m] of each member
    xi = nds(ndi, 1);    yi = nds(ndi, 2);    zi = nds(ndi, 3);
    xj = nds(ndj, 1);    yj = nds(ndj, 2);    zj = nds(ndj, 3);
    
    l = sqrt( (xj-xi)^2 + (yj-yi)^2 + (zj-zi)^2 );
    CX = (xj-xi)/l;    CY = (yj-yi)/l;    CZ = (zj-zi)/l;
    
    T = [CX, CY, CZ, 0, 0, 0; 0, 0, 0, CX, CY, CZ];
    k = (alpha(i)*E*A/l)*T'*[1, -1; -1, 1]*T;
    m = (ro*A*l/6)*T'*[2, 1; 1, 2]*T;
    
    % push local [k] and [m] to global matrices
    
    M(3*ndi-2:3*ndi,3*ndi-2:3*ndi) = M(3*ndi-2:3*ndi,3*ndi-2:3*ndi) + m(1:3,1:3); %ss
    M(3*ndi-2:3*ndi,3*ndj-2:3*ndj) = M(3*ndi-2:3*ndi,3*ndj-2:3*ndj) + m(1:3,4:6); %se
    M(3*ndj-2:3*ndj,3*ndi-2:3*ndi) = M(3*ndj-2:3*ndj,3*ndi-2:3*ndi) + m(4:6,1:3);  %es
    M(3*ndj-2:3*ndj,3*ndj-2:3*ndj) = M(3*ndj-2:3*ndj,3*ndj-2:3*ndj) + m(4:6,4:6);  %ee
    
    K(3*ndi-2:3*ndi,3*ndi-2:3*ndi) = K(3*ndi-2:3*ndi,3*ndi-2:3*ndi) + k(1:3,1:3); %ss
    K(3*ndi-2:3*ndi,3*ndj-2:3*ndj) = K(3*ndi-2:3*ndi,3*ndj-2:3*ndj) + k(1:3,4:6); %se
    K(3*ndj-2:3*ndj,3*ndi-2:3*ndi) = K(3*ndj-2:3*ndj,3*ndi-2:3*ndi) + k(4:6,1:3);  %es
    K(3*ndj-2:3*ndj,3*ndj-2:3*ndj) = K(3*ndj-2:3*ndj,3*ndj-2:3*ndj) + k(4:6,4:6);  %ee
    
    %  for 2D, http://fsinet.fsid.cvut.cz/en/u2052/node137.html 
end

{% endhighlight %}


### 1.3. Push stiffness of elastic support to the structure's stiffness

20140209  `vibrate.m`

To include the effect of spring element, the stiffness of the spring on the assigned node will be included using superposition method. Therefore, the structure's stiffness is calculated as unrelated to the elastic support, the springs' stiffness will be included before elimination of rows and columns associated constrained nodes.

* With input file (csv)   `nodes = px, py, pz, cx, cy, cz, kx, ky, kz`
* With external forces, 3 more columns are needed  `nodes = px, py, pz, cx, cy, cz, kx, ky, kz, fx, fy, fz`

{% highlight matlab %}  

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
    
{% endhighlight %}

### 1.4. Remove rows and colums of constrained nodes

{% highlight matlab %}

% Reduce K and M 
% If elastic support is attached, the node is not constrained
temp = nds(:, 4:6);             % pull constrained directions
temp = reshape(temp', 1, []);   % flatten the array
key = find(temp);               % index non zero element
M(key,:)=[];
M(:,key)=[];
K(key,:)=[];
K(:,key)=[];
    
{% endhighlight %}

### 1.5. Calculate modal properties

These values will be pushed to the calculation of objective function, with combination of predicted damage

{% highlight matlab %}

[phi, w2] = eig(M\K);
%  eig_val = sqrt(diag(w2)); => Wrong
eig_val = diag(w2);
eig_vec = phi;
    
{% endhighlight %}

## Damage indetification ##

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat ultrices tellus vitae ultricies. Curabitur eu arcu mauris. Cras pharetra magna ac libero ultricies, sed cursus sapien pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque eu pretium ipsum. Pellentesque aliquam mattis massa, ut condimentum sapien ultricies id. Nullam rutrum nunc nec enim laoreet tincidunt. Maecenas interdum arcu a neque rutrum consectetur. Proin tristique augue sed tristique faucibus. In a consequat tellus. Phasellus vulputate vitae orci a feugiat. Aliquam erat volutpat. Phasellus convallis elit ac commodo suscipit. Curabitur sodales feugiat odio non malesuada. Integer pretium condimentum dui, egestas placerat lectus mollis quis. 

## Noise ##

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi volutpat ultrices tellus vitae ultricies. Curabitur eu arcu mauris. Cras pharetra magna ac libero ultricies, sed cursus sapien pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque eu pretium ipsum. Pellentesque aliquam mattis massa, ut condimentum sapien ultricies id. Nullam rutrum nunc nec enim laoreet tincidunt. Maecenas interdum arcu a neque rutrum consectetur. Proin tristique augue sed tristique faucibus. In a consequat tellus. Phasellus vulputate vitae orci a feugiat. Aliquam erat volutpat. Phasellus convallis elit ac commodo suscipit. Curabitur sodales feugiat odio non malesuada. Integer pretium condimentum dui, egestas placerat lectus mollis quis. 

