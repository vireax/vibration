function obj_val()
%function objVal = obj_val(eig_vec, eig_val, mbs, nds, beta)

clc
clear all;
close all;
nds = csvread('nds36bar.txt');
mbs = csvread('mbs36bar.txt');
alpha = ones(size(mbs,1),1);
noise = 0.03;
[eig_vec, eig_val, ~, ~ ] = vibrate(mbs, nds, alpha);
[Measured_eig_vector, Measured_eig_value] = measure(eig_vec, eig_val, noise);
beta = rand(size(mbs,1),1);
[~, ~, M_reduced, K_reduced] = vibrate(mbs, nds, beta);
No_dof = size(M_reduced,1);
R_matrix = zeros(No_dof);
for i = 1:No_dof
    R_matrix(:,i) = -Measured_eig_value(i)*M_reduced*Measured_eig_vector(:,i)+K_reduced*Measured_eig_vector(:,i);
end
sum_R = sum(sum(R_matrix.*R_matrix));
% disp(sum_R);
object_val = sqrt(sum_R);
disp('objectval = ');
disp(object_val);

end


function [measured_eig_vec, measured_eig_val] = measure(exact_eig_vec, exact_eig_val, noise)
n = size(exact_eig_vec,1);
% NOISE = 0.03; % default
% + or - 3% => total = 6%
if noise~=0
    err_val = ones(n,1) + (2*rand(n,1)-1)*noise;
    err_vec = ones(n) + (2*rand(n)-1)*noise;
else
    err_val = ones(n,1);
    err_vec = ones(n);
end
measured_eig_val = err_val.*exact_eig_val;
measured_eig_vec = err_vec.*exact_eig_vec;
end

function [eig_vec, eig_val, M, K] = vibrate(mbs, nds, alpha)
% nodes = [px, py, pz, cx, cy, cz];
% members = [{start_node}, {end_node}, {density}, {E}, {A}, {alpha}];

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

% Reduce K and M 
temp = nds(:, 4:6);             % pull constrained directions
temp = reshape(temp', 1, []);   %flatten the array
key = find(temp);               % index non zero element
M(key,:)=[];
M(:,key)=[];
K(key,:)=[];
K(:,key)=[];

[phi, w2] = eig(M\K);
eig_val = sqrt(diag(w2));
eig_vec = phi;

end
