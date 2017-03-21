library(tidyverse)

# Things are similar to what was in the analysis_of_variance.R document. We also
# need interaction plots and ways to specify additive vs. general model.

# Let's use the Chromatography dataset from question 26.16

chr <- read.csv("Chapter_26/Chromatography.csv")


# There is a built-in interaction plot function
interaction.plot(chr$Concentration, chr$Flow.Rate, chr$Counts)

# Would be nice to put the Concentration levels in a nicer order. You can do
# this simply by specifying the levels in the order you want:
 
chr$Concentration <- factor(chr$Concentration, 
                            levels = c("Low", "Medium", "High"))

# Better plot:
interaction.plot(chr$Concentration, chr$Flow.Rate, chr$Counts)

# a table of numerical summaries is nice
chr %>% 
  group_by(Concentration, Flow.Rate) %>% 
  summarize(means=mean(Counts), sds=sd(Counts), n=n())


# Now, fit the two-way ANOVA model. You use the "formula" notation with the y
# variable on the left, and the input variables on the right.

# In this example I explicitly ask for the main effects and the interaction
# term, which is entered as the variable names with ':' in between:

chr %>% aov(Counts ~ Concentration + Flow.Rate + Concentration:Flow.Rate, 
            data=.) %>% summary()

## There's a more efficient way, which is just put the main effects with a '*' 
## in between. That does the interaction with all main effects too. This time
## I'll save the result and print it on a separate line.

chr_fit <- chr %>% aov(Counts ~ Concentration * Flow.Rate, 
            data=.)
summary(chr_fit)

## Assumptions

## Levene's test OK for these data.

library(car)
chr %>% leveneTest(Counts ~ Concentration * Flow.Rate, data=.)

## Or a plot of residuals versus fitted values can be used. But this plot looks
## worse than what Levene's test suggested.
library(broom)
augment(chr_fit) %>%
  ggplot(aes(x=.fitted, y=.resid)) + geom_point()

## Normal quantile plot
augment(chr_fit) %>%
  ggplot(aes(sample=.resid)) + geom_qq()
