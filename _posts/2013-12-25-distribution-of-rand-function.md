---
layout: post
title: Distribution of rand function
date: 2013-12-25
---

In Matlab, rand() generates a uniform distribution no matter how large the requested number is.

## Sample Code

{% highlight matlab lineos %}
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
{% endhighlight %}

## What's next?

* Suitable for Monte Carlo simulation/method
* Generate large number of measurement withing a range of error to evaluate the next step
