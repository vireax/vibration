% Modal properties of 3D truss vibration
% Vireax Kim
% 20131215
clc;
clear all;
close all;

% nodes = [px, py, pz, cx, cy, cz];
% members = [{start_node}, {end_node}, {density}, {E}, {A}, {alpha}];
nds = csvread('nds36bar.txt');
mbs = csvread('mbs36bar.txt');

% allocate empty global matrices
nb_nds = size(nds,1);   nb_mbs = size(mbs,1); 
M = zeros(3*nb_nds);    K = zeros(3*nb_nds);

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
    k = (E*A/l)*T'*[1, -1; -1, 1]*T;
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

% Reduce K and M 
temp = nds(:, 4:6);             % pull constrained directions
temp = reshape(temp', 1, []);   %flatten the array
key = find(temp);               % index non zero element
M(key,:)=[];
M(:,key)=[];
K(key,:)=[];
K(:,key)=[];

[phi, w2] = eig(M\K);
% pull diagonal elements
frequency = sqrt(diag(w2));

disp(phi);
disp(frequency);
frequency2 = reshape(frequency,8,[]);
disp(frequency2);

% TODO 
% 1. DONE: calculate (phi, lambda) = f(mbs, nds)
% 1.1 add damage index (alpha)
% 1.2 insert noise [-3%, +3%]
% 2. calculate obj_val = f(lambda, phi, mbs, nds, alpha)
% 3. calculate Fitness = F(Obj...)
% 4. CCGA = f(gen, chrom., Fitness, Species, ..)
% 5. Multiple runs => test statistics
