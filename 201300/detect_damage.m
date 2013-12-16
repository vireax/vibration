% CCGA for Vibration based damage detection in 2D truss
% 2013/08 --  Vireax

function output = detect_damage()
clear all; close all; clc;
% Parameters settings
chrom_length = 11;
n_individual = 20;
n_generation = 5;

% Main
% Random 11x20 Matrix
individual = rand(n_individual, chrom_length); % data unused
fid = fopen('pop_real.txt','r');    % Unused
individual = fscanf(fid, '%f', [n_individual,chrom_length]); 
fclose(fid);
noise = 0.03;

damage_index = ones(11,1);
damage_index(3)=0.3;
damage_index(6)=0.7;

%[Exact_eig_vector, Exact_eig_value] = vibrate(noise);
[Measured_eig_vector, Measured_eig_value, ~] = vibrate2(damage_index, noise);

output = zeros(5,11);
for i=1:5
% Start loop here
[Best_Ind, ~] = ccga_generation(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, individual, n_generation);
%[Best_Ind, Best_Fit] = ccga_generation(Exact_eig_vector, Exact_eig_value, chrom_length, n_individual, individual, n_generation);
% [Best_Ind, Best_Fit] = ccga_generation(11, 20, [11x20] matrix, 25);
%disp(Best_Ind);
%disp(Best_Fit);
%output = Best_Ind;
output(i,:) = Best_Ind(:);
end

% ccga_generation
function [best_individual, best_fitness] = ccga_generation(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, individual, n_generation)
%   Parameters
n_eli_individual = 2;   % to keep the best for reproduction
n_select_individual = n_individual-n_eli_individual;
p_cross = 1.0;
p_mutate = 0.5;
object_val = truss_damage_detect_obj2(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, individual);

% object_val = rand(n_individual,1);
fitness = -object_val;
best_ind_index = 1;
best_fitness = fitness(1); %    why fitness(1)
for i = 2:n_individual
    if fitness(i)>best_fitness
        best_ind_index = i;
        best_fitness = fitness(i);
    end
end
best_individual = individual(best_ind_index,:);

% line 28-35 skipped
no_species = chrom_length;
species_fitness = zeros(no_species, n_individual);
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
      
      [eli_individual, eli_fitness] = elitist(n_individual, sub_individual, sub_fitness, n_eli_individual);
      
      scale_fitness = fitness_scaling(n_individual, sub_fitness);
      
      [select_individual, select_fitness] = selection_sus(n_individual, sub_individual, scale_fitness, n_select_individual);
      
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

% truss_damage_detect_obj > Can be removed now
function object_val = truss_damage_detect_obj(Exact_eig_vector, Exact_eig_value, chrom_length, n_individual, individual)
RO = 7860;  %   density
YM = 207e9; %   Young's modulus
L = 0.75;   %   Bay length
Area = 0.0011; %   Cross section
alpha = ones(11,1);
%   nodes = [x_pos, y_pos, x_fixed, y_fixed, x_force, y_force];
nodes = [
    0,  0,  1,  1, 0,   0;
    L, 0,   0,  0, 0,   0;
    2*L, 0, 0,  1, 0,   0;
    0,  L,  0,  0,  0,  0;
    L,  L,  0,  0,  0,  0;
    2*L, L, 0,  0,  0,  0];

%   elements = [start, end, density, E, A, alpha]
elements    = [
    1,  2, RO, YM, Area, alpha(1);
    2,  3, RO, YM, Area, alpha(2);
    3,  6, RO, YM, Area, alpha(3);
    5,  6, RO, YM, Area, alpha(4);
    4,  5, RO, YM, Area, alpha(5);
    1,  4, RO, YM, Area, alpha(6);
    1,  5, RO, YM, Area, alpha(7);
    2,  4, RO, YM, Area, alpha(8);
    2,  5, RO, YM, Area, alpha(9);
    2,  6, RO, YM, Area, alpha(10);
    3,  5, RO, YM, Area, alpha(11)];


%--------------------------------------------------------------------
% Calculate object_val of each individual ( n_individual = 20)
for ind_count = 1:n_individual
   Predicted_factor = individual(ind_count,:);
   alpha = Predicted_factor;
   elements(:,6)=alpha(:);
   
       %   Init empty global matrices
    N_nd = size(nodes,1);
    M = zeros(2*N_nd, 2*N_nd);
    K = zeros(2*N_nd, 2*N_nd);
    U = zeros(2*N_nd,1);

    %   Count number of elements
    N_el = size(elements,1);
    
        %   Calculate [mb]& [kb] => [M]& [K]
    for iel = 1:N_el
        nds = elements(iel,1);  % start
        nde = elements(iel,2);  % end
        ro = elements(iel,3);   % density
        E = elements(iel, 4);   % YM
        A = elements(iel, 5);   % Cross section
        alpha2 = elements(iel, 6);   % reduction

        % nodes' coordinates
        xs = nodes(nds,1);
        ys = nodes(nds,2);
        xe = nodes(nde,1);
        ye = nodes(nde,2);

        % truss's length
        l = sqrt((xe-xs)^2 + (ye-ys)^2);
        S = (ye-ys)/l;  % sin
        C = (xe-xs)/l;  % cos
        % Stiffness matrix of a single truss element
        kb = [
            C^2, C*S, -C^2, -C*S;
            C*S, S^2, -C*S, -S^2;
            -C^2, -C*S, C^2, C*S;
            -C*S, -S^2, C*S, S^2]*alpha2*(E*A/l);
        % Mass matrix of a single truss element
        mb = [
            2*C^2+2*S^2, 0,2*C^2+2*S^2, 0;
            0,2*C^2+2*S^2, 0, C^2+S^2;
            C^2+S^2, 0,2*C^2+2*S^2, 0; 
            0, C^2+S^2, 0,2*C^2+2*S^2]*(A*ro*l/6);

        % assignment of local to global mass and stiffness matrices
        M(2*nds-1:2*nds,2*nds-1:2*nds) = M(2*nds-1:2*nds,2*nds-1:2*nds) + mb(1:2,1:2);
        M(2*nds-1:2*nds,2*nde-1:2*nde) = M(2*nds-1:2*nds,2*nde-1:2*nde) + mb(1:2,3:4);
        M(2*nde-1:2*nde,2*nds-1:2*nds) = M(2*nde-1:2*nde,2*nds-1:2*nds) + mb(3:4,1:2);
        M(2*nde-1:2*nde,2*nde-1:2*nde) = M(2*nde-1:2*nde,2*nde-1:2*nde) + mb(3:4,3:4);

        K(2*nds-1:2*nds,2*nds-1:2*nds) = K(2*nds-1:2*nds,2*nds-1:2*nds) + kb(1:2,1:2);
        K(2*nds-1:2*nds,2*nde-1:2*nde) = K(2*nds-1:2*nds,2*nde-1:2*nde) + kb(1:2,3:4);
        K(2*nde-1:2*nde,2*nds-1:2*nds) = K(2*nde-1:2*nde,2*nds-1:2*nds) + kb(3:4,1:2);
        K(2*nde-1:2*nde,2*nde-1:2*nde) = K(2*nde-1:2*nde,2*nde-1:2*nde) + kb(3:4,3:4);

    end

    % Vector of constrained nodes
    C = zeros(2*N_nd,1);
    for ind=1:size(nodes,1)
        C(2*ind-1)  = nodes(ind,3);
        C(2*ind)    = nodes(ind,4);
    end

    % filter index of constrained DOF from C array
    temp_key =zeros(2*N_nd,1);  % Allocate fixed size array for speed
    count = 0;
    for keyi = 1:size(C)
        if C(keyi) == 1
            count = count+1;
            temp_key(count) = keyi;
        end
    end

    % Trim the matrix of index of constraint to minimum
    key = temp_key(1:count);

    % Remove rows and columns of constrained degree
    % This code can be compressed but needed first to verify the size of M & K
    M_reduced = M;
    M_reduced(key,:)=[];
    M_reduced(:,key) = [];
    

    K_reduced = K;
    K_reduced(key,:)=[];
    K_reduced(:,key) = [];
    
    No_dof = 9;
    
    R_matrix = zeros(No_dof, No_dof);
    
    for i =1:No_dof;
        R_matrix(:,i) = -Exact_eig_value(i,i)*M_reduced*Exact_eig_vector(:,i)+K_reduced*Exact_eig_vector(:,i);
    end
    
    sum = 0;
    for i=1:No_dof;
        for j=1:No_dof;
            sum =sum+(R_matrix(i,j)*R_matrix(i,j));
        end
    end
    object_val(ind_count) = sqrt(sum);
end
object_val;

% truss_damage_detect_obj2()
function object_val = truss_damage_detect_obj2(Exact_eig_vector, Exact_eig_value, chrom_length, n_individual, individual)

% Calculate object_val of each individual ( n_individual = 20)
for ind_count = 1:n_individual
   Predicted_factor = individual(ind_count,:);
   %[eig_vec, eig_val, mass_reduced, stiffness_reduced] = vibrate2(damage_index, noise)
   %[eig_vec_x, eig_val_x, M_reduced, K_reduced] = vibrate2(Predicted_factor, 0);
   [~, ~, M_reduced, K_reduced] = vibrate2(Predicted_factor, 0);


    No_dof = 9;
    R_matrix = zeros(No_dof, No_dof);
    
    for i =1:No_dof;
        R_matrix(:,i) = -Exact_eig_value(i,i)*M_reduced*Exact_eig_vector(:,i)+K_reduced*Exact_eig_vector(:,i);
    end
    
    sum = 0;
    for i=1:No_dof;
        for j=1:No_dof;
            sum =sum+(R_matrix(i,j)*R_matrix(i,j));
        end
    end
    object_val(ind_count) = sqrt(sum);
end

% elitist
function [eli_individual, eli_fitness] = elitist(n_individual, individual, fitness, n_eli_individual)
n_remain_individual = n_individual;
remain_individual = individual;
remain_fitness = fitness;

for i = 1:n_eli_individual
   best_ind_index=1;
   best_fitness = remain_fitness(1);    % ?remain_fitness(i)
   for j=2:n_remain_individual
      if fitness(j)>best_fitness
         best_ind_index = j;
         best_fitness = fitness(j);
      end
   end
   
   eli_individual(i,:) = remain_individual(best_ind_index,:);
   eli_fitness(i) = best_fitness;
   remain_individual(best_ind_index,:) = remain_individual(n_remain_individual,:);
   fitness(best_ind_index) = fitness(n_remain_individual);
   n_remain_individual = n_remain_individual-1;   
end

% scale_fitness
function scale_fitness = fitness_scaling(n_individual, fitness)
% also possible with  max_obj = max(max(fitness)) min_obj = min(min(fitness))
min_obj = fitness(1);
max_obj = fitness(1);
for i=2:n_individual
   if fitness(i)<min_obj
       min_obj = fitness(i);
   end
   if fitness(i)>max_obj
       max_obj = fitness(i);
   end
end
normal_fitness = (fitness-min_obj)/(max_obj-min_obj);
min_obj = 0;
max_obj = 1;
sum = 0;
for i=1:n_individual
    sum = sum+normal_fitness(i);
end
avg_obj=sum/n_individual;
fmultiple=2.0;
if min_obj > ((fmultiple*avg_obj-max_obj)/(fmultiple-1.0))
    delta = max_obj - min_obj;
    a = (fmultiple-1.0)*avg_obj/delta;
    b = avg_obj*avg_obj/delta;
else
    delta = avg_obj-min_obj;
    a = avg_obj/delta;
    b = -min_obj*avg_obj/delta;
end

scale_fitness = a*normal_fitness+b;

%selection_sus
function [select_individual, select_fitness]=selection_sus(n_individual, individual, fitness, n_select_individual)
sum_fitness=0;
for i=1:n_individual;
    sum_fitness=sum_fitness + fitness(i);
end
target_samp_rate = n_select_individual*fitness/sum_fitness;
ptr = rand(1);
while ptr ==1
    ptr = rand(1);
end
select_ind_count = 0;
sum_fitness=0;
i=1;
while i<=n_individual & select_ind_count<n_select_individual
    sum_fitness = sum_fitness + target_samp_rate(i);
    while sum_fitness>ptr,
        if select_ind_count<n_select_individual
            select_individual(select_ind_count+1,:) = individual(i,:);
            select_fitness(select_ind_count+1) = fitness(i);
            select_ind_count = select_ind_count+1;
        end
        ptr=ptr+1.0;
    end
    i=i+1;
end

% real_crossover()
function cross_individual = real_crossover(chrom_length, p_cross, n_individual, individual)
n_remain_individual = n_individual;
remain_individual = individual;
crossover_iteration = n_remain_individual/2;
k = 1;
for i = 1:crossover_iteration
    
    prob_result = rand(1);
    
    j_pick = randi(n_remain_individual,1);
    
    first_parent = remain_individual(j_pick,:);
    remain_individual(j_pick,:) = remain_individual(n_remain_individual,:);
    n_remain_individual = n_remain_individual-1;
    
    j_pick = randi(n_remain_individual,1);
    
    second_parent = remain_individual(j_pick,:);
    remain_individual(j_pick,:) = remain_individual(n_remain_individual,:);
    n_remain_individual = n_remain_individual-1; 
    
    if prob_result <= p_cross
      
        [first_offspring second_offspring] = sbx_crossover(chrom_length, first_parent, second_parent);
        
        cross_individual(k,:) = first_offspring;
        cross_individual(k+1,:) = second_offspring;
        
    else
        
        cross_individual(k,:) = first_parent;
        cross_individual(k+1,:) = second_parent;

    end
    
    k = k+2;
    
end

% sbx_crossover()
function [first_offspring, second_offspring] = sbx_crossover(chrom_length, first_parent, second_parent)

% double coin_toss_prob;
yl=0.0;
yu=1.0;
% double u, alpha, beta, betaq;
eta_c = 15.0;
% double power_index;
% double parent1, parent2;
EPS = 1.0e-40;

power_index = 1.0/(eta_c+1.0);

for j = 1:chrom_length;
    
    if chrom_length == 1
        coin_toss_prob = 0.0;
    else
        coin_toss_prob = rand(1);
    end
        
    if coin_toss_prob <= 0.5
        
        parent1 = first_parent(j);
        parent2 = second_parent(j);
        
        if parent1 > parent2

            y1 = parent2;
            y2 = parent1;

        else

            y1 = parent1;
            y2 = parent2;
        end
        
        if abs(y2-y1) > EPS 
           
            u = rand(1);
			beta = 1.0+2.0*(y1-yl)/(y2-y1);
			alpha = 2.0-power(beta,-(eta_c+1));

            if u <= (1.0/alpha)

                betaq = power(u*alpha, power_index);

            else % u <= (1.0/alpha)
                
                betaq = power(1.0/(2.0-u*alpha), power_index);
           
            end % u <= (1.0/alpha)
            
            c1 = 0.5*((y1+y2)-betaq*(y2-y1));

            beta = 1.0 + (2.0*(yu-y2)/(y2-y1));
            alpha = 2.0 - power(beta,-(eta_c+1.0));

            if u <= (1.0/alpha)

                betaq = power( (u*alpha), power_index);

            else

                betaq = power(1.0/(2.0-u*alpha), power_index);
            end
            
            c2 = 0.5*((y1+y2)+betaq*(y2-y1));            

            if c1 < yl
                c1 = yl;
            elseif c1 > yu 
                c1 = yu;
            end

            if c2 < yl
                c2 = yl;
            elseif c2 > yu
                c2 = yu;   
            end
 
            coin_toss_prob = rand(1);

            if coin_toss_prob <= 0.5

                first_offspring(j) = c2;
                second_offspring(j) = c1;

            else

                first_offspring(j) = c1;
                second_offspring(j) = c2;
                
            end
            
            
        else % if abs(y2-y1) > EPS 
            
            first_offspring(j)  = first_parent(j);
			second_offspring(j) = second_parent(j);

        end % if abs(y2-y1) > EPS 
        
        
    else % if coin_toss_prob <= 0.5
                  
        first_offspring(j)  = first_parent(j);			
        second_offspring(j) = second_parent(j);
        
    end % if coin_toss_prob <= 0.5
    
    
end % for j = 1:chrom_length;

% real_mutation()
function mutate_individual = real_mutation(chrom_length, p_mutate, n_individual, individual)
for i=1:n_individual
    
    mutate_individual(i,:) = real_mutation_one_ind(chrom_length, p_mutate, individual(i,:));
    
end

% real_mutation_one_ind
function mutate_individual = real_mutation_one_ind(chrom_length, p_mutation, individual)

yl=0.0;
yu=1.0;

% double y, val, xy;

eta_m = 20.0;

for j = 1:chrom_length;
   
    prob_result = rand(1);
    
    if prob_result <= p_mutation
        
        y = individual(j);

        delta1 = (y-yl)/(yu-yl);
        delta2 = (yu-y)/(yu-yl);

        u = rand(1);

        mut_pow = 1.0/(eta_m+1.0);

        if u <= 0.5

            xy = 1.0-delta1;
            val = 2.0*u+(1.0-2.0*u)*power(xy,eta_m+1.0);
            deltaq =  power(val,mut_pow) - 1.0;

        else

            xy = 1.0-delta2;
            val = 2.0*(1.0-u)+2.0*(u-0.5)*power(xy,eta_m+1.0);
            deltaq = 1.0 - (power(val,mut_pow));
            
        end

        y = y + deltaq*(yu-yl);

        if y < yl
            
            y = yl;

        elseif y > yu
            
            y = yu;
           
        end

        mutate_individual(j) = y;      
        
    else
        
        mutate_individual(j) = individual(j);
              
    end    
    
end

% ccga_cal_fitness()
function [sub_fitness, new_best_ind, new_best_fit] = ccga_cal_fitness(...
    Measured_eig_vector, Measured_eig_value, ...
    chrom_length, species_index, n_individual, sub_individual,...
    best_individual, best_fitness)

for i = 1:n_individual;
    
    combine_individual(i,:) = best_individual;
    combine_individual(i,species_index) = sub_individual(i);

end

combine_object_val = truss_damage_detect_obj2(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, combine_individual);
combine_fitness = -combine_object_val;
sub_fitness = combine_fitness;

new_best_ind = best_individual;
new_best_fit = best_fitness;

for i = 1:n_individual;
    
    if combine_fitness(i) > new_best_fit
        
        new_best_ind = combine_individual(i,:);
        new_best_fit = combine_fitness(i);
        
    end

end

% vibrate()> can be removed now
function [Exact_eig_vector, Exact_eig_value] = vibrate(noise)
RO = 7860;  %   density
YM = 207e9; %   Young's modulus
L = 0.75;   %   Bay length
Area = 0.0011; %   Cross section

%   Exact damage index
alpha = ones(11,1); alpha(3)=0.3; alpha(6) = 0.7; % case 1
% alpha = ones(11,1); alpha(3)=0.5; alpha(6) = 0.7; % case 2
% alpha = ones(11,1); alpha(10) = 0.0;    % case 3

% ====================================================
% Include experiemental noise (x) > Wrong
% NOISE = 0.03;
% ERROR = (2*rand-1)*NOISE;
% alpha = alpha + ERROR;
% ====================================================

%   Nodes' properties
%   nodes = [x_pos, y_pos, x_fixed, y_fixed, x_force, y_force];
nodes = [
    0,  0,  1,  1, 0,   0;
    L, 0,   0,  0, 0,   0;
    2*L, 0, 0,  1, 0,   0;
    0,  L,  0,  0,  0,  0;
    L,  L,  0,  0,  0,  0;
    2*L, L, 0,  0,  0,  0];

%   elements = [start, end, density, E, A, alpha]
% elements = [1,2; 2,3; 3,6; 5,6; 4,5; 1,4; 1,5; 2,4; 2,5; 2,6; 3,5];
% elements = [elements, zeros(11,4)]; 
% elements(:,3) = RO; 
% elements(:,4) = YM; 
% elements(:,5) = Area; 
% elements(:,6) = alpha(:);

elements    = [
    1,  2, RO, YM, Area, alpha(1);
    2,  3, RO, YM, Area, alpha(2);
    3,  6, RO, YM, Area, alpha(3);
    5,  6, RO, YM, Area, alpha(4);
    4,  5, RO, YM, Area, alpha(5);
    1,  4, RO, YM, Area, alpha(6);
    1,  5, RO, YM, Area, alpha(7);
    2,  4, RO, YM, Area, alpha(8);
    2,  5, RO, YM, Area, alpha(9);
    2,  6, RO, YM, Area, alpha(10);
    3,  5, RO, YM, Area, alpha(11)];

%   Init empty global matrices
N_nd = size(nodes,1);
M = zeros(2*N_nd, 2*N_nd);
K = zeros(2*N_nd, 2*N_nd);
U = zeros(2*N_nd,1);

%   Count number of elements
N_el = size(elements,1);

%   Calculate [mb]& [kb] => [M]& [K]
for iel = 1:N_el
    nds = elements(iel,1);  % start
    nde = elements(iel,2);  % end
    ro = elements(iel,3);   % density
    E = elements(iel, 4);   % YM
    A = elements(iel, 5);   % Cross section
    alpha2 = elements(iel, 6);   % reduction
    
    % nodes' coordinates
    xs = nodes(nds,1);
    ys = nodes(nds,2);
    xe = nodes(nde,1);
    ye = nodes(nde,2);
    
    % truss's length
    l = sqrt((xe-xs)^2 + (ye-ys)^2);
    S = (ye-ys)/l;  % sin
    C = (xe-xs)/l;  % cos
    % Stiffness matrix of a single truss element
    kb = [
        C^2, C*S, -C^2, -C*S;
        C*S, S^2, -C*S, -S^2;
        -C^2, -C*S, C^2, C*S;
        -C*S, -S^2, C*S, S^2]*alpha2*(E*A/l);
    % Mass matrix of a single truss element
    mb = [
        2*C^2+2*S^2, 0,2*C^2+2*S^2, 0;
        0,2*C^2+2*S^2, 0, C^2+S^2;
        C^2+S^2, 0,2*C^2+2*S^2, 0; 
        0, C^2+S^2, 0,2*C^2+2*S^2]*(A*ro*l/6);
      
    % assignment of local to global mass and stiffness matrices
    M(2*nds-1:2*nds,2*nds-1:2*nds) = M(2*nds-1:2*nds,2*nds-1:2*nds) + mb(1:2,1:2);
    M(2*nds-1:2*nds,2*nde-1:2*nde) = M(2*nds-1:2*nds,2*nde-1:2*nde) + mb(1:2,3:4);
    M(2*nde-1:2*nde,2*nds-1:2*nds) = M(2*nde-1:2*nde,2*nds-1:2*nds) + mb(3:4,1:2);
    M(2*nde-1:2*nde,2*nde-1:2*nde) = M(2*nde-1:2*nde,2*nde-1:2*nde) + mb(3:4,3:4);
    
    K(2*nds-1:2*nds,2*nds-1:2*nds) = K(2*nds-1:2*nds,2*nds-1:2*nds) + kb(1:2,1:2);
    K(2*nds-1:2*nds,2*nde-1:2*nde) = K(2*nds-1:2*nds,2*nde-1:2*nde) + kb(1:2,3:4);
    K(2*nde-1:2*nde,2*nds-1:2*nds) = K(2*nde-1:2*nde,2*nds-1:2*nds) + kb(3:4,1:2);
    K(2*nde-1:2*nde,2*nde-1:2*nde) = K(2*nde-1:2*nde,2*nde-1:2*nde) + kb(3:4,3:4);
    
end

% Vector of constrained nodes
C = zeros(2*N_nd,1);
for ind=1:size(nodes,1)
    C(2*ind-1)  = nodes(ind,3);
    C(2*ind)    = nodes(ind,4);
end

% filter index of constrained DOF from C array
temp_key =zeros(2*N_nd,1);  % Allocate fixed size array for speed
count = 0;
for keyi = 1:size(C)
    if C(keyi) == 1
        count = count+1;
        temp_key(count) = keyi;
    end
end

% Trim the matrix of index of constraint to minimum
key = temp_key(1:count);

% Remove rows and columns of constrained degree
% This code can be compressed but needed first to verify the size of M & K
M_reduced = M;
size(M_reduced);
M_reduced(key,:)=[];
M_reduced(:,key) = [];
size(M_reduced);

K_reduced = K;
size(K_reduced);
K_reduced(key,:)=[];
K_reduced(:,key) = [];
size(K_reduced);

[Exact_eig_vector, Exact_eig_value] = eig(M_reduced\K_reduced);
% ====================================================
% Include experiemental noise, 
% Only mode shape and frequencies are measured
% NOISE = 0.03;
% ERROR = (2*rand-1)*NOISE;
% alpha = alpha + ERROR;
% eigvec = size(Exact_eig_vector)
% eigval = size(Exact_eig_value)
% ====================================================
% NOISE = 0.03;
size_eig = size(Exact_eig_vector,1);
for i = 1:size_eig
    for j = 1:size_eig
        err_vec = (2*rand-1)*noise;
        Exact_eig_vector(i,j) = (1+err_vec)*Exact_eig_vector(i,j);
        err_val = (2*rand-1)*noise;
        Exact_eig_value(i,j) = (1+err_val)*Exact_eig_value(i,j);
    end
end

% vibrate2(damage_index, noise)
function [eig_vec, eig_val, mass_reduced, stiffness_reduced] = vibrate2(damage_index, noise)
% eig_vec: mode shape (m x n)
% eig_val: freq     (m x n)
% damage_index: default alpha = ones(11,1)
% noise : 0.03 default

RO = 7860;  %   density
YM = 207e9; %   Young's modulus
L = 0.75;   %   Bay length
Area = 0.0011; %   Cross section

alpha = damage_index;
%   Nodes' properties
%   nodes = [x_pos, y_pos, x_fixed, y_fixed, x_force, y_force];
nodes = [
    0,  0,  1,  1, 0,   0;
    L, 0,   0,  0, 0,   0;
    2*L, 0, 0,  1, 0,   0;
    0,  L,  0,  0,  0,  0;
    L,  L,  0,  0,  0,  0;
    2*L, L, 0,  0,  0,  0];

%   elements = [start, end, density, E, A, alpha]
% elements = [1,2; 2,3; 3,6; 5,6; 4,5; 1,4; 1,5; 2,4; 2,5; 2,6; 3,5];
% elements = [elements, zeros(11,4)]; 
% elements(:,3) = RO; 
% elements(:,4) = YM; 
% elements(:,5) = Area; 
% elements(:,6) = alpha(:);

elements    = [
    1,  2, RO, YM, Area, alpha(1);
    2,  3, RO, YM, Area, alpha(2);
    3,  6, RO, YM, Area, alpha(3);
    5,  6, RO, YM, Area, alpha(4);
    4,  5, RO, YM, Area, alpha(5);
    1,  4, RO, YM, Area, alpha(6);
    1,  5, RO, YM, Area, alpha(7);
    2,  4, RO, YM, Area, alpha(8);
    2,  5, RO, YM, Area, alpha(9);
    2,  6, RO, YM, Area, alpha(10);
    3,  5, RO, YM, Area, alpha(11)];

%   Init empty global matrices
N_nd = size(nodes,1);
M = zeros(2*N_nd, 2*N_nd);
K = zeros(2*N_nd, 2*N_nd);
% U = zeros(2*N_nd,1);

%   Count number of elements
N_el = size(elements,1);

%   Calculate [mb]& [kb] => [M]& [K]
for iel = 1:N_el
    nds = elements(iel,1);  % start
    nde = elements(iel,2);  % end
    ro = elements(iel,3);   % density
    E = elements(iel, 4);   % YM
    A = elements(iel, 5);   % Cross section
    alpha2 = elements(iel, 6);   % reduction
    
    % nodes' coordinates
    xs = nodes(nds,1);
    ys = nodes(nds,2);
    xe = nodes(nde,1);
    ye = nodes(nde,2);
    
    % truss's length
    l = sqrt((xe-xs)^2 + (ye-ys)^2);
    S = (ye-ys)/l;  % sin
    C = (xe-xs)/l;  % cos
    % Stiffness matrix of a single truss element
    kb = [
        C^2, C*S, -C^2, -C*S;
        C*S, S^2, -C*S, -S^2;
        -C^2, -C*S, C^2, C*S;
        -C*S, -S^2, C*S, S^2]*alpha2*(E*A/l);
    % Mass matrix of a single truss element
    mb = [
        2*C^2+2*S^2, 0,2*C^2+2*S^2, 0;
        0,2*C^2+2*S^2, 0, C^2+S^2;
        C^2+S^2, 0,2*C^2+2*S^2, 0; 
        0, C^2+S^2, 0,2*C^2+2*S^2]*(A*ro*l/6);
      
    % assignment of local to global mass and stiffness matrices
    M(2*nds-1:2*nds,2*nds-1:2*nds) = M(2*nds-1:2*nds,2*nds-1:2*nds) + mb(1:2,1:2);
    M(2*nds-1:2*nds,2*nde-1:2*nde) = M(2*nds-1:2*nds,2*nde-1:2*nde) + mb(1:2,3:4);
    M(2*nde-1:2*nde,2*nds-1:2*nds) = M(2*nde-1:2*nde,2*nds-1:2*nds) + mb(3:4,1:2);
    M(2*nde-1:2*nde,2*nde-1:2*nde) = M(2*nde-1:2*nde,2*nde-1:2*nde) + mb(3:4,3:4);
    
    K(2*nds-1:2*nds,2*nds-1:2*nds) = K(2*nds-1:2*nds,2*nds-1:2*nds) + kb(1:2,1:2);
    K(2*nds-1:2*nds,2*nde-1:2*nde) = K(2*nds-1:2*nds,2*nde-1:2*nde) + kb(1:2,3:4);
    K(2*nde-1:2*nde,2*nds-1:2*nds) = K(2*nde-1:2*nde,2*nds-1:2*nds) + kb(3:4,1:2);
    K(2*nde-1:2*nde,2*nde-1:2*nde) = K(2*nde-1:2*nde,2*nde-1:2*nde) + kb(3:4,3:4);
    
end

% Vector of constrained nodes
C = zeros(2*N_nd,1);
for ind=1:size(nodes,1)
    C(2*ind-1)  = nodes(ind,3);
    C(2*ind)    = nodes(ind,4);
end

% filter index of constrained DOF from C array
temp_key =zeros(2*N_nd,1);  % Allocate fixed size array for speed
count = 0;
for keyi = 1:size(C)
    if C(keyi) == 1
        count = count+1;
        temp_key(count) = keyi;
    end
end

% Trim the matrix of index of constraint to minimum
key = temp_key(1:count);

% Remove rows and columns of constrained degree
% This code can be compressed but needed first to verify the size of M & K
M_reduced = M;
size(M_reduced);
M_reduced(key,:)=[];
M_reduced(:,key) = [];
size(M_reduced);

K_reduced = K;
size(K_reduced);
K_reduced(key,:)=[];
K_reduced(:,key) = [];
size(K_reduced);

[Exact_eig_vector, Exact_eig_value] = eig(M_reduced\K_reduced);

if noise~=0
    % NOISE = 0.03; % default
    % + or - 3% => total = 6%
    size_eig = size(Exact_eig_vector,1);
    for i = 1:size_eig
        for j = 1:size_eig
            err_vec = (2*rand-1)*noise;
            Exact_eig_vector(i,j) = (1+err_vec)*Exact_eig_vector(i,j);
            err_val = (2*rand-1)*noise;
            Exact_eig_value(i,j) = (1+err_val)*Exact_eig_value(i,j);
        end
    end
end

eig_vec = Exact_eig_vector;
eig_val = Exact_eig_value;
mass_reduced = M_reduced;
stiffness_reduced = K_reduced;

% __________________UNUSED__________________________________
% main
% % % % function detect_damage()
% % % % tic;
% % % % nb_of_run = 2; 
% % % % % 2 run >  22.379555 seconds.
% % % % % 3 run >  33.120292 seconds.
% % % % main_result = zeros(nb_of_run,11);
% % % % for i = 1:nb_of_run
% % % %     test = detect_damage2();
% % % %     main_result(i,:) = test;
% % % % end
% % % % filep = fopen('mainresult.txt','w');
% % % % for i = 1:nb_of_run
% % % %     temp=main_result(i,:)';
% % % %     fprintf(filep,'%.8f\t',temp);
% % % %     fprintf(filep, '\n');
% % % % end
% % % % 
% % % % fclose(filep);
% % % % main_result
% % % % toc;

%_VERSION____________________________________________________

% 0.0.1 
% - Combine all function in single file

% 0.0.2 
% - Add noise
% - One detection for one measurement only

% 0.0.3 
% - OK : split truss_damage_detect_obj into two section, add variables of mode shapes and frequencies 
% - OK : move the first top to function vibrate(noise)
% - OK : modify ccga_generation(), ccga_detect_damage2(), cal_fitness()
% - X : create loop in detect_damage2(), to predict multiple times from a single measurement
% - X : resize result_matrix to fit nb_measuremnet x nb_detection

% 0.0.4 
% - OK : [mod, freq, M_r, K_r] = vibrate2(alpha, noise)
% - OK : obj_val = obj_val_2(measured phi and freq, predicted, ..)







