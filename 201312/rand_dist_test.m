% 20131215
% test distribution of random number


clear all;
close all;
a = randi([0,100], 1000,1);
figure;
subplot(2,2,1);
plot(a);
b = sort(a);
subplot(2,2,2);
plot(b);
subplot(2,2,3);
hist(b);
subplot(2,2,4);
hist(b,50);
