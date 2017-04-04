# Similar to simple regression. The only difference is the formula has more than
# one term to the right of the ~

library(tidyverse)
library(readxl)

pizza <- read_excel("Chapter_28/pizza.xls")

pizza_fit <- pizza <- lm(Score ~ Cost + Calories + Fat, data=.)
summary(pizza_fit)

# It's a good idea to tell R specifically if something is to be treated as an indicator.

pizza$Cheese <- factor(pizza$Cheese)

pizza %>% lm(Score ~ Calories + Cheese, data=.) %>% summary

# Interaction

pizza %>% lm(Score ~ Calories * Cheese, data=.) %>% summary

# Adding a "square" term wrapped in I()

pizza %>% lm(Score ~ Calories + I(Calories^2), data=.) %>% summary

# Everything else (plots, etc.) is the same as in simple regression.
