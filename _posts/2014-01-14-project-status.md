---
layout: post
title:  "Project status"
date:   2014-01-02 14:28:00
---

## Back to the main objective

The research aims to predict damage indexes in truss structures using CCGA. Truss structures can be 2D and 3D. Case of 2D structure is based on Rao, 2004, 3D structure is based on Nam Il Kim, 2013. Test cases will verify the prediction with undamaged structures and partially damaged. Comparison can be done in 2D structure because the prediction was availabe from Rao et al., 2004. However, 3D case has no based line to compare. It intends therefore the result to be as accurate as possible. Next, experimental noise will be included in the simulation of measurement of modal properties. Test statistics will not be needed to reject the result because it can be done anytime as long as the data of the predicted damage is available. There will be a summary table of residual, or sum of sqared differences between predicted damage indexes ($$ \beta $$ and $$ \alpha $$ ) in function of varied noise (from -3% to + 3% in $$ \lambda $$ and $$ \phi $$ ).

## Objective 1

> *To predict damage indexes in 2D and 3D truss structures*

### Completed
* Programming 2D + test case + conference
* Programming 3D + [test case of undamaged structure](http://vireax.github.io/vibration/truss36bars/)

### Task: to do
* Check if the program for 3D truss can be used with 2D truss data, by adding z-direction
* Test cases for partially damaged 3D structures
* Visualize data
* Recheck if any test statistics are suitable for these data

## Objective 2

> *To predict damage level, while introducing experimental noise*

### Completed
* Programming 3D
* Source available to vary noise manually

### Task: to do
* Run each case ( undamaged and damaged ) with variation of noise, then summarize in a single table.
* What else?...

## What's next?
* verify methodology
* discussion
* writing draft
* rewrite literature review
