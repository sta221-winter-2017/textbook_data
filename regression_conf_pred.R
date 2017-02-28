library(tidyverse)

# Load the data
bodyfat <- read_csv("Chapter_24/Body_fat.csv")

# Fit the model and save it.
bf_wt_lm <- bodyfat %>% 
  lm(`Pct BF` ~ Weight, data = .)

# Let's make a 95% confidence interval for the mean bodyfat percentage at a 
# weight of 200. We use the `predict.lm` function for this (even though we're
# not making a prediction in this case, that's the name of the function.)
# 
# The "new" values need to be stored in an actual dataframe, which is 
# inconvenient for one-off calculations, but there's no way around the 
# requirement.

# To make a one-off calculation:
predict.lm(bf_wt_lm, newdata = data.frame(Weight=200), interval = "confidence")

# The textbook asks for different confidence levels in many questions, which I 
# think is a bit silly, but anyway there's nothing mathematically wrong, and you
# might want to check solutions. Here's the 90% confidence interval:
predict.lm(bf_wt_lm, newdata = data.frame(Weight=200), 
           interval = "confidence", level = 0.9)

# You can make a bunch of confidence intervals at once.
new_x_values <- data.frame(Weight = c(180, 200, 220))
predict.lm(bf_wt_lm, newdata = new_x_values, interval = "confidence")

# For prediction intervals, one at a time and all at once:
predict.lm(bf_wt_lm, newdata = data.frame(Weight=200), interval = "prediction")
predict.lm(bf_wt_lm, newdata = new_x_values, interval = "prediction")




