% 20131215 Recombine all function for evolution
% 20131217 Unifinished
% 201312191357 Finish all codes, but fitness value cannot converge
% 20131221 Completed, previous problem was caused by 
% eig_val = sqrt(diag(w2)); There's no need find the root
% 20131221 Add summary graph of predicted damage
% 20130105 Test extreme cases of noise -3% and + 3%
    % cases noise_val noise_vec
    %   0       0       0
    %   1    -0.03   -0.03
    %   2    -0.03   +0.03
    %   3    +0.03   -0.03
    %   4    +0.03   +0.03
    %   5    -0.02   -0.02
    %   6    -0.01   -0.01
    %   7    +0.01   +0.01
    %   8    +0.02   +0.02
    

% Vibration based damage detection for 3D truss structures

function ccga_3d()
% main function
clear all;
close all;
clc
% 3 bars structure
nds = csvread('nds36bars.txt');
mbs = csvread('mbs36bars.txt');

% % 3 bars structure
% nds = csvread('nodes.txt');
% mbs = csvread('members.txt');
noise_vec = 0;
noise_val = 0;
chrom_length = size(mbs,1);
n_individual = 20;
n_generation = 25;

% assign damage indexes
alpha = ones(size(mbs,1),1);
%disp(alpha);
% init random individual (/beta)
individual = rand(n_individual, chrom_length);
% disp(individual);

[eig_vec, eig_val, ~, ~ ] = ...
    vibrate(mbs, nds, alpha);

[Measured_eig_vector, Measured_eig_value] = ...
    measure(eig_vec, eig_val, noise_vec, noise_val);


% disp('individual = '); disp(individual);
[~, Best_Fitness] = ccga_generation(...
    Measured_eig_vector, Measured_eig_value, ...
    chrom_length, n_individual, individual, n_generation, mbs, nds);

%disp(Best_Ind);
disp(Best_Fitness);
%best_ind_filep = fopen('dyn_ccga_best_ind_out.txt','w');
%result = csvread('dyn_ccga_best_ind_out.txt');
result = dlmread('data.txt','\t');
%result(size(result)) = [];
result2 = reshape(result,chrom_length*n_generation, []);
disp(size(result2));
figure;
plot(result2);
axis([0 Inf 0 1.05])

figure;
plot(dlmread('fitness.txt'));
end

% ccga_generation
function [best_individual, best_fitness] = ccga_generation(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, individual, n_generation, mbs, nds)

%   Parameters
n_eli_individual = 2;   % to keep the best for reproduction
n_select_individual = n_individual-n_eli_individual;
p_cross = 1.0;
p_mutate = 0.4;

% object_val = truss_damage_detect_obj(Measured_eig_vector, Measured_eig_value, chrom_length, n_individual, individual,mbs, nds);
object_val = truss_damage_detect_obj(Measured_eig_vector, Measured_eig_value, n_individual, individual,mbs, nds);
% disp('object_val = '); disp(object_val);
% disp('size of object_val = '); disp(size(object_val));
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

best_ind_filep = fopen('data.txt','w');
best_fitness_filep = fopen('fitness.txt', 'w');
% fprintf(best_ind_filep, '%.8f\n', best_fitness);
% disp('fitness'); disp(fitness);
% disp('best_fitness'); disp(best_fitness);
% disp('best_ind_index'); disp(best_ind_index);
% ========================================

no_species = chrom_length;
%no_species = 5;
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
fig_fitness=zeros(n_generation*no_species,1);
fig_fitness_index=1;
for gen = 1:n_generation        %   1-25
    %disp('generation = '); disp(gen);
   % eval each specie
   for species=1:no_species     %   1-11
%       disp('generation species'); disp([gen species]);
  
      % eval each individual
      for i = 1:n_individual    %   1-20 => total = 20*11*25 = 5500
          sub_individual(i,1) = species_individual(species,i);
          sub_fitness(i) = species_fitness(species,i);
      end
      
%      [eli_individual, eli_fitness] = elitist(n_individual, sub_individual, sub_fitness, n_eli_individual);
      [eli_individual, ~] = elitist(n_individual, sub_individual, sub_fitness, n_eli_individual);
      
%       disp('elistist');disp(eli_individual); disp(eli_fitness');
      scale_fitness = fitness_scaling(n_individual, sub_fitness);
      
%     [select_individual, select_fitness] = selection_sus(n_individual, sub_individual, scale_fitness, n_select_individual);
      [select_individual, ~] = selection_sus(n_individual, sub_individual, scale_fitness, n_select_individual);
      
      sub_chrom_length = 1;
      cross_individual = real_crossover(sub_chrom_length, p_cross, n_select_individual, select_individual);
      child_individual = real_mutation(sub_chrom_length, p_mutate, n_select_individual, cross_individual);
      sub_individual = [eli_individual; child_individual];
      
%       disp(size(sub_individual));
      transpose(sub_individual); % no effect
%       disp('sub_individual'); 
%       disp(sub_individual);
      for i=1:n_individual
          species_individual(species, i) = sub_individual(i,1);
%           disp('species_individual(species, i)');
%           disp(species_individual(species, i));
      end
%       disp(species_individual);
      
      % retrieve fitness and individual from a species
      [species_fitness(species,:),new_best_individual, new_best_fitness] = ...
          ccga_cal_fitness(Measured_eig_vector, Measured_eig_value, ...
          species, n_individual, species_individual(species,:), best_individual, best_fitness, mbs, nds);
      best_individual = new_best_individual;
      best_fitness = new_best_fitness;
      %best_fitness, best_individual, gen, species          
      %disp([gen species best_fitness]);
      disp(best_fitness);
      %disp(best_individual);
       fig_fitness(fig_fitness_index)=best_fitness;
      fig_fitness_index=fig_fitness_index+1;
      for j=1:chrom_length
            fprintf(best_ind_filep, '%.8f \t', best_individual(j));
      end
        %fprintf(best_ind_filep, '%.8f\n',best_fitness);
        fprintf(best_ind_filep,'\n');
        fprintf(best_fitness_filep,'%.8f \n', best_fitness);
   end
%    disp(best_fitness);
end
plot(fig_fitness);
fclose('all');
%axis([-Inf Inf -200 Inf]);
end

% function elitist()
function [eli_individual, eli_fitness] = elitist(n_individual, individual, fitness, n_eli_individual)
n_remain_individual = n_individual;
remain_individual = individual;
remain_fitness = fitness;

% eli_individual = zeros(size(remain_individual));


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
% disp('eli_individual'); disp(eli_individual);%disp(size(eli_individual));
% disp('size of eli_fitness'); disp(size(eli_fitness));
end

% function fitness_scaling()
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
end

% % function selection_sus()
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
end 

% % function real_crossover()
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
    end
end

% % function real_mutation()
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
    end
end

% % function ccga_cal_fitness()
function [sub_fitness, new_best_ind, new_best_fit] = ccga_cal_fitness(...
    Measured_eig_vector, Measured_eig_value, ...
    species_index, n_individual, sub_individual,best_individual, best_fitness,mbs,nds)
% disp('best_individual');
% disp(size(best_individual));
% disp(size(sub_individual));
%disp(best_individual);
% disp('best_individual'); disp(size(best_individual));
combine_individual=zeros(n_individual, size(best_individual,2));
for i = 1:n_individual;
     combine_individual(i,:) = best_individual; % modified
     combine_individual(i,species_index) = sub_individual(i);
end
% disp('size combine_individual'); disp(size(combine_individual));

combine_object_val = truss_damage_detect_obj(...
    Measured_eig_vector, Measured_eig_value, ...
    n_individual, combine_individual,mbs,nds);

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
end

function object_val = truss_damage_detect_obj(...
    Measured_eig_vector, Measured_eig_value,...
    n_individual, individual, mbs, nds)

object_val=zeros(n_individual,1);
% disp('individual'); disp(individual);
for ind_count = 1:n_individual
    %Predicted_factor = individual(ind_count,:);
    %beta = rand(size(mbs,1),1); 
    %disp('individual'); disp(individual);
    beta = individual(ind_count,:);
%     disp('beta'); disp(beta); 
    %disp('size beta'); disp(size(beta));
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

function [measured_eig_vec, measured_eig_val] = measure2...
    (exact_eig_vec, exact_eig_val, noise)

n = size(exact_eig_vec,1);
% NOISE = 0.03; % default
% + or - 3% => total = 6%
err_val = ones(n,1) + (2*rand(n,1)-1)*noise;
err_vec = ones(n) + (2*rand(n)-1)*noise;

measured_eig_val = err_val.*exact_eig_val;
measured_eig_vec = err_vec.*exact_eig_vec;
end

function [measured_eig_vec, measured_eig_val] = measure...
    (exact_eig_vec, exact_eig_val, noise_vec, noise_val)

n = size(exact_eig_vec,1);
% NOISE = 0.03; % default
% + or - 3% => total = 6%
err_val = 1 + noise_val;
err_vec = 1 + noise_vec;

measured_eig_val = err_val.*exact_eig_val;
measured_eig_vec = err_vec.*exact_eig_vec;
end

function [eig_vec, eig_val, M, K] = vibrate...
    (mbs, nds, alpha)
%disp('size alpha'); disp(size(alpha));
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
% eig_val = sqrt(diag(w2)); => Wrong
eig_val = diag(w2);
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

% 20131218 problem with combine_individual, cannot understand
