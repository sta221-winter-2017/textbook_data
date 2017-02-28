library(tidyverse)

# Load the data
bodyfat <- read_csv("Chapter_24/Body_fat.csv")

# Matrix of sample correlations among all variables (in this case, unwieldly):
cor(bodyfat)

# For the hypothesis testing, there are a few ways to do it. This syntax looks
# strange but I think is the easiest. Put in any variables you like. 

cor.test(~ Ankle + Hip, data=bodyfat)

# Alternatively:
bodyfat %>% cor.test(~ Ankle + Hip, data=.)

# Always a good idea to look at the plot as well. A few interesting points in this case!

bodyfat %>% 
  ggplot(aes(x=Ankle, y=Hip)) + geom_point()

# A heuristic way to see what impact those points have would be to exclude them
# and see what difference it makes:

bodyfat %>% 
  filter(Ankle < 30) %>% 
  cor.test(~ Ankle + Hip, data=.)

# Makes a massive difference!