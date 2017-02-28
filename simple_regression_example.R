# The situation is much simpler with regression exercises, because the example
# datasets are all actual datasets, and not a summary (as was sometimes the case
# with the chi-square goodness of fit chapter.)

# Here's how to to the basic analysis of some variables in the body fat dataset.
# 
# I did some poking around and apparently the dataset is an old classic. A 
# complete description of it is here:
# 
# http://lib.stat.cmu.edu/datasets/bodyfat
# 
# tl;dr Weight is in pounds, Height and waist are in inches, other body parts
# are circumferences in centimetres.


# The tidyverse packages contain most of the tools you'll need.

library(tidyverse)

# Load the data
bodyfat <- read_csv("Chapter_24/Body_fat.csv")

# Scatterplots

bodyfat %>%    # the RStudio keyboard shortcut for this symbol is ctrl + shift + m
  ggplot(aes(x=Weight, y=`Pct BF`)) + 
  geom_point()
  
# To make any other scatterplots just change the variable names.

# Scatterplots with regression line. 

bodyfat %>%    
  ggplot(aes(x=Weight, y=`Pct BF`)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE) 

# Try without se=FALSE. Also try without method="lm". It produces a smooth curve
# with "error bars", which is cool but not simple regression.

# Estimating the model parameters.

# This uses an R function called "lm" (which stands for "linear model"). There
# is something in R called a "formula", which is where you have your output
# variable on the left and the input variable(s) on the right with a ~ in the
# middle.

# Here is one way to get the estimates. As usual, it's best to save the results
# and then look at them directly.

bf_wt_lm <- lm(`Pct BF` ~ Weight, data = bodyfat)
bf_wt_lm

# To see more details use the following. Right now all we know about are the numbers in the "Estimate" column. 

summary(bf_wt_lm)

# OPTIONAL BUT EFFECTIVE AND RECOMMENDED
# 
# Another way to type the command to get the regression analysis. This takes 
# advantage of RStudio's ability to suggest variable names, which saves typing 
# and prevents errors. I always do things this way.
# 
# What you do is type the dataset name followed by the "pipe" symbol %>% using
# the ctrl + shift + m shortcut, and wherever you put a single period '.'
# (without quotes) R understands you to mean "put the dataset name here".

bodyfat %>% 
  lm(`Pct BF` ~ Weight, data = .)

# Here's how to save the results when you use this method.

bf_wt_lm <- bodyfat %>% 
  lm(`Pct BF` ~ Weight, data = .)

## NEW 2017-02-06: Residual plots

# A simple way to make the residual plots, except you have to be there to hit 
# <enter> to see them one at a time. But, simple. Also, the plots I provide will
# look a little different.

plot(bf_wt_lm, which = 1:2)

# Here's how I make the plots. It requies the broom package which is installed
# as part of the tidyverse but not loaded by default. Load it now.

library(broom)

# First, make a data_frame with the data along with residuals, and some other
# stuff we might see later on.

bf_wt_lm_aug <- augment(bf_wt_lm)

# Normal quantile plot of residuals
bf_wt_lm_aug %>% 
  ggplot(aes(sample = .resid)) + geom_qq()

# Residuals versus fitted values
bf_wt_lm_aug %>% 
  ggplot(aes(x= .fitted, y=.resid)) + geom_point()



