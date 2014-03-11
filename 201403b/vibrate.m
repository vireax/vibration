% 20140209 
% vibrate the structure with addition of spring elements at certain nodes 
% the input file "nds.txt" is therefore px, py, pz, cx, cy, cz, kx, ky, kz
% these stiffness will be added after formulation of the global stiffness
% of the structure, by indexing based on node's id and direction x, y, z

% Unit test to verify with previous result in Nam Il Kim, 2013

function vibrate()
clear all; close all; clc;

% 3 bars structure
% Uncomment only one row to test
% 1 (2D-Rao-2004), 2 (2D-Kim-2013), 3 (3D-Kim-2013)
% nds = csvread('nds1.txt'); mbs = csvread('mbs1.txt');
nds = csvread('nds2.txt'); mbs = csvread('mbs2.txt');
% nds = csvread('nds3.txt'); mbs = csvread('mbs3.txt');

% function [eig_vec, eig_val, M, K] = vibrate(mbs, nds, alpha)
% disp('size alpha'); disp(size(alpha));
% nodes = [px, py, pz, cx, cy, cz];
% members = [{start_node}, {end_node}, {density}, {E}, {A}, {alpha}];
% allocate empty global matrices
nb_nds = size(nds,1);   nb_mbs = size(mbs,1); 
M = zeros(3*nb_nds);    K = zeros(3*nb_nds);

% to be removed
alpha = ones(nb_mbs,1);

for i = 1:nb_mbs
    ndi = mbs(i, 1);   %   start node
    ndj = mbs(i, 2);   %   end node
    ro  = mbs(i, 3);   %   density
    E   = mbs(i, 4);   %   modulus
    A   = mbs(i, 5);   %   cross-section
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

% push spring's stiffness here 
% iterate through each node

for i = 1: nb_nds
    % retrieve kx, ky, kz from node i
    kx = nds(i, 7);
    ky = nds(i, 8);
    kz = nds(i, 9);
    % push values to the global stiffness matrix,...
    % in diagonal terms
    K (3*i-2, 3*i-2) = K(3*i-2, 3*i-2) + kx;
    K (3*i-1, 3*i-1) = K (3*i-1, 3*i-1) + ky;
    K (3*i, 3*i) = K (3*i, 3*i)+ kz;
end

% Reduce K and M 
temp = nds(:, 4:6);             % pull constrained directions
temp = reshape(temp', 1, []);   % flatten the array
key = find(temp);               % index non zero element
M(key,:)=[];
M(:,key)=[];
K(key,:)=[];
K(:,key)=[];
% disp(M(1,1));

% [phi, w2] = eig(M\K);
%%%%%%%%%%%%%%%%%%%% eig_val = sqrt(diag(w2)); => Wrong
% eig_val = diag(w2);
% eig_vec = phi;

% disp(eig_val);
% disp(eig_vec);
% nds(:,[7,8,9])

% -----------------------
% calculate internal force
F = nds(:,10:12); % pull from nodes input
F = reshape(F',1,[]); % flatten 
F = F'  ; % rebuild to column vector
F(key) = [];

U_temp = K\F;
U = zeros(3*nb_nds,1);
j = 1;
for i = 1: nb_nds*3
    if any(key(:)== i)
        U(i) = 0;
    else
        U(i) = U_temp(j);
        j = j+1;
    end
end

U = reshape(U', 3, []);
U = U';
disp('Displacement');
disp('- - - - - - - - - - - - - - - - - - - - - - ');
fprintf('\t dx  \t dy \t dz \n');
disp('- - - - - - - - - - - - - - - - - - - - - - ');
disp(U*1000);
% disp('M = '); disp(M);
% disp('K = '); disp(K);
end