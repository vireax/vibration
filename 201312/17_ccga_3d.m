% 20131217 
% Vibration based damage detection for 3D truss structures

function ccga_3d()
% main function
clc
clear all;
close all;
nds = csvread('nds36bar.txt');
mbs = csvread('mbs36bar.txt');
noise = 0.03;
chrom_length = size(mbs,1);
n_individual = 20;
n_generation = 5;
% assign damage indexes
alpha = ones(size(mbs,1),1);
% init random individual (/beta)
individual = rand(n_individual, chrom_length);

[eig_vec, eig_val, ~, ~ ] = ...
    vibrate(mbs, nds, alpha);

[Measured_eig_vector, Measured_eig_value] = ...
    measure(eig_vec, eig_val, noise);

[Best_Ind, Best_Fitness] = ccga_generation(...
    Measured_eig_vector, Measured_eig_value, ...
    chrom_length, n_individual, individual, n_generation);

disp(Best_Ind);
disp(Best_Fitness);

end

% ccga_generation
function [best_individual, best_fitness] = ccga_generation(...
    Measured_eig_vector, Measured_eig_value, ...
    chrom_length, n_individual, individual, n_generation)

%   Parameters
n_eli_individual = 2;   % to keep the best for reproduction
n_select_individual = n_individual-n_eli_individual;
p_cross = 1.0;
p_mutate = 0.5;

object_val = truss_damage_detect_obj(...
    Measured_eig_vector, Measured_eig_value,...
    chrom_length, n_individual, individual);

% ==============================
% object_val = rand(n_individual,1);
% % % fitness = -object_val;
% % % best_ind_index = 1;
% % % best_fitness = fitness(1); %    why fitness(1)
% % % for i = 2:n_individual
% % %     if fitness(i)>best_fitness
% % %         best_ind_index = i;
% % %         best_fitness = fitness(i);
% % %     end
% % % end
% % % best_individual = individual(best_ind_index,:);

fitness = -object_val;
[best_fitness, best_ind_index] = max(fitness); % return max value and index
best_individual= individual(best_ind_index,:); % pull best individual from the pool
% ========================================

no_species = chrom_length;
species_fitness = zeros(no_species, n_individual);
species_individual = zeros(no_species,n_individual);

for i=1:n_individual
    for species=1:no_species
        species_individual(species,i) = individual(i,species);
        species_fitness(species,i)=fitness(i);
    end
end


sub_individual = zeros(n_individual, 1);
sub_fitness = zeros(n_individual, 1);
% start evolution
for gen = 1:n_generation        %   1-25
    
   % eval each specie
   for species=1:no_species     %   1-11
        % disp([gen species]);
  
      % eval each individual
      for i = 1:n_individual    %   1-20 => total = 20*11*25 = 5500
          sub_individual(i,1) = species_individual(species,i);
          sub_fitness(i) = species_fitness(species,i);
      end
      
%      [eli_individual, eli_fitness] = elitist(n_individual, sub_individual, sub_fitness, n_eli_individual);
      [eli_individual, ~] = elitist(n_individual, sub_individual, sub_fitness, n_eli_individual);

      scale_fitness = fitness_scaling(n_individual, sub_fitness);
      
%      [select_individual, select_fitness] = selection_sus(n_individual, sub_individual, scale_fitness, n_select_individual);
      [select_individual, ~] = selection_sus(n_individual, sub_individual, scale_fitness, n_select_individual);
      
      sub_chrom_length = 1;
      
      cross_individual = real_crossover(sub_chrom_length, p_cross, n_select_individual, select_individual);
      
      child_individual = real_mutation(sub_chrom_length, p_mutate, n_select_individual, cross_individual);
      
      sub_individual = [eli_individual; child_individual];
      
      transpose(sub_individual);
      for i=1:n_individual
          species_individual(species, i) = sub_individual(i,1);
      end
      
      [species_fitness(species,:),new_best_individual, new_best_fitness] = ...
          ccga_cal_fitness(Measured_eig_vector, Measured_eig_value, chrom_length, species, n_individual, ...
          species_individual(species,:), best_individual, best_fitness);
      
      best_individual = new_best_individual;
      best_fitness = new_best_fitness;
      
      % 99-104 > print > skipped
      
      %best_fitness, best_individual, gen, species          
      disp([gen species best_individual]);
      
   end
end
end

function elitist()
% keep best individual without joining the selection
end

function fitness_scaling()
% scale fitness value to min-max
end

function selection_sus()
% selection operation
end

function real_crossover()
% crossoever operation on real number
    function sbx_crossover()
           % simulated binary crossover technique
    end
end

function real_mutation()
% mutation of real number chromosomes
    function real_mutation_one_ind()
        % real mutation
    end
end

function ccga_cal_fitness()
% calculate fitness value
end

function object_val = truss_damage_detect_obj(...
    Measured_eig_vector, Measured_eig_value,...
    chrom_length, n_individual, individual)
%function obj_val()
%function objVal = obj_val(eig_vec, eig_val, mbs, nds, beta, noise)
object_val=zeros(n_individual,chrom_length);
for ind_count = 1:n_individual
    %Predicted_factor = individual(ind_count,:);
    %beta = rand(size(mbs,1),1); 
    beta = individual(ind_count,:);
    [~, ~, M_reduced, K_reduced] = vibrate(mbs, nds, beta);
    
    No_dof = size(M_reduced,1); 
    % OR No_dof = chrom_length; 
    % Need to verify try/catch (No_dof = chrom_length) here
    R_matrix = zeros(No_dof);
    for i = 1:No_dof
        R_matrix(:,i) = -Measured_eig_value(i)*M_reduced*Measured_eig_vector(:,i)+K_reduced*Measured_eig_vector(:,i);
    end
    sum_R = sum(sum(R_matrix.*R_matrix));
    % disp(sum_R);
    object_val(ind_count) = sqrt(sum_R);
end

end

function [measured_eig_vec, measured_eig_val] = measure...
    (exact_eig_vec, exact_eig_val, noise)

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

function [eig_vec, eig_val, M, K] = vibrate...
    (mbs, nds, alpha)

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




% =====================
% PROGRAMMING FLOW
% =====================
% CCGA_damage_run
%     ccga_generation
%         truss_damage_detect_obj
%         elitist
%         fitness_scaling
%         selection_sus
%         real_crossover
%             sbx_crossover
%         real_mutation
%             real_mutation_one_ind
%         ccga_cal_fitness
%             truss_damage_detect_obj
