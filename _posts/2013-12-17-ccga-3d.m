---
layout: post
title: CCGA 3D
date: 2013-12-17
---

Source: [17](https://github.com/Vireax/vibration/blob/master/201312/17_ccga_3d.m), 
[21](https://github.com/Vireax/vibration/blob/master/201312/21_ccga_3d.m), 
[21b](https://github.com/Vireax/vibration/blob/master/201312/21b_ccga_3d.m)


This program conclude all function for vibration based damage detection but still does not converge because vibrate() retrieve sqare root of eigenvalue.

## Programming steps
<pre><code>
    [K, M, lambda, phi] = vibrate( mbs, nds, alpha)
    [lambda_measured, phi_measured] = measure(lambda, phi, noise)
    obj_val = obj_val( lambda_measeured, phi_measured, mbs, nds, beta)
    [best_individual, best_fitness] = ccga_run( gen, species, ind=beta, mbs, nds, alpha, )
</code></pre>

## Top down design
<pre><code>
    Read nodes and members files into two array
    Optional: induce damage index to some members
    Calculate modal properties of the structure
    Simulate measured modal properties with noise
    Initialize a random matrix of damage index (beta)
    Start CCGA_run
        Push generation to species level
        Evaluate the objective value
        Select
        Xover
        Mutate
        Cal_fitness for next generation
        Optional: verify if the predicted fitness can be accepted
        Write solution of each iteration into file
    Retrive predicted damage indexes from file
    Plot
</pre></code>   

## Plot the result

{% highlight matlab lineos %}
result = dlmread('best_ind.txt','\t');
%result(size(result)) = [];
result2 = reshape(result,chrom_length*n_generation, []);
disp(size(result2));
plot(result2);
axis([0 Inf 0 1.05])
{% endhighlight %}