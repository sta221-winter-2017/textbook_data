library(tidyverse)

pi_digits <- read_csv("Chapter_23/Pi.csv")

# If we apply the chisq.test function to the counts, by default it does the test
# with null hypothsis "the probabilities are all the same"
chisq.test(pi_digits$Count)

# But it would nice to be able access the expected cell counts and other things.
# To do that save the results of the chisq test

pi_test <- chisq.test(pi_digits$Count)

# Now you can access things as follows

pi_test$observed  # Just the data.
pi_test$expected  # In scientific notation! 1e+05 is 100000
pi_test$residuals # We'll talk about these.
pi_test$p.value
