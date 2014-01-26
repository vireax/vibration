---
layout: post
title: Prototype
date: 2013-08-15
---

<pre><code>

% 20130815
% prototype structuring the programming flow
% MAIN PROGRAM
% global noise, loop_alpha, loop_beta, nb_members
% 1. read input
% 2. generate random damage index (alpha)
% 3. calculate mode shape and frequency
% 4. beta1 = evolve GA from the given mode and freq
% 5. beta2 = evolve CCGA from the given mode
% 6. output the comparison
% TEST PROGRAM
%
function prog_rand_0815()
clear; clc; tic

g_noise = 1;    % specify noise level 1-10% to test
truss = 1;      % read truss.txt
loop_alpha =1;  % number of test for assignment of damage index
loop_beta = 5;  % number of time of evolution

a = rand(1,10)      % generate random number
b = CCGA(loop_beta) % retrieve from CCGA sub function
c = GA(loop_beta)   % retrieve from GA sub function

plot(a,'r');hold on
plot(b','g');
plot(c','b');
hold off

% testing statistics
% mean_b = mean(b)
% std_b = std(b)
% % std_b2 = std(b') > wrong
% std_c = std(c)
toc
return;

function f01 = CCGA(loop)
% CCGA(..
%  
% return the output
f01 = rand(loop,10);

function f02 = GA(loop)

% f02 = 'test_f02';
f02 = rand(loop,10)
</cod></pre>

<img src="http://vibration.ximplex.info/_/rsrc/1376557090371/notes/20130815prototype/20130815_fig1.png" />

<img src="http://vibration.ximplex.info/_/rsrc/1376557090401/notes/20130815prototype/20130815_fig2.png" />
