# This file will eventually have everything you need to do an ANOVA in R.

# The issue of factor variables in R can be tricky. R can usually (but not
# always) figure out when you intend for a variable to be treated as a factor
# with levels. But, if the variable uses levels such as 1, 2, 3, etc., then R
# will assume these are the numbers themselves, and not labels. So it's a good
# habit to make sure factor variables are being stored properly.

yeast <- read.csv("Chapter_25/Activating_yeast.csv", check.names = FALSE)

# I've turned off variable name "checking". If you don't do this, the column
# name "Activiation Times" is changed to "Activation.Times" to get rid of the
# space. I don't consider that good practice.

# Look at the "structure" of 'yeast' using the str function:
str(yeast)

# You can see the Recipe variable is indeed stored as a 'Factor' variable. So 
# we're good to go. See the next example below for a case where you need to
# change something.

# 1. Plot the data
yeast %>% 
 ggplot(aes(x=Recipe, y=`Activation Times`)) + geom_boxplot()

# 1a. Numerical summaries - good to get sample sizes, means, and standard
# deviations for each group:
yeast %>% 
  group_by(Recipe) %>% 
  summarize(n = n(), means = mean(`Activation Times`), sd = sd(`Activation Times`))

# 2. Do the ANOVA. The formula notation using the ~ is similar to regression. As
# usual, best to save the analysis and look at a summary of it.
yeast_fit <- yeast %>% 
  aov(`Activation Times` ~ Recipe, data=.)

summary(yeast_fit)

# 3. Verify the model assumptions (will be discussed 2017-03-06)

library(broom)
yeast_fit_aug <- augment(yeast_fit)

# Normality assumption normal quantile plot.
yeast_fit_aug %>% 
  ggplot(aes(sample=.resid)) + geom_qq()

# Equal variance assumption with residuals versus fitted values.
yeast_fit_aug %>% 
  ggplot(aes(x=.fitted, y=.resid)) + geom_point()

# Also look at the table of standard deviations above.


##########################################
# Example with confusing factor variable #
##########################################

fuel <- read.csv("Chapter_25/Fuel_economy.csv", check.names = FALSE)
str(fuel)

# Number of cylinders is stored as an integer, not a factor. So if you try to
# make boxplots, it doesn't work:
fuel %>% 
  ggplot(aes(x=Cylinders, y=`Fuel Efficiency (mpg)`)) + geom_boxplot()

# Simply change the variable to be of a factor type:

fuel$Cylinders <- as.factor(fuel$Cylinders)

# Now this works:
fuel %>% 
  ggplot(aes(x=Cylinders, y=`Fuel Efficiency (mpg)`)) + geom_boxplot()

# Numerical summary
fuel %>% 
  group_by(Cylinders) %>% 
  summarize(n = n(), means = mean(`Fuel Efficiency (mpg)`), sd = sd(`Fuel Efficiency (mpg)`))

# Hmmm...sample size of only 1 for 5 cylinders. That won't work. I don't 
# actually see a question on this dataset in our version of the textbook. Also, 
# this is an unbalanced dataset and the group standard deviations aren't very
# close. Best not to proceed with an ANOVA.

