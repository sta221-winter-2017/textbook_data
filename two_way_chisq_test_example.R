library(tidyverse)

# When you want to use R's chisq.test function for a test of independence or 
# homogeneity, you can either use two factor variables from an actual dataset,
# or you can use a contingency table made from those two variables.

# The Chapter 23 datasets come in both these formats, and also another format
# that is neither. Here is how to handle any of the types.

############
# Raw Data #
############

# Cranberry juice from question 29.

cran <- read_csv("Chapter_23/Cranberry_juice.csv")

# Look at the table
table(cran$Infection, cran$Treatment)

# Add the totals
addmargins(table(cran$Infection, cran$Treatment))

# On the raw data:
chisq.test(cran$Infection, cran$Treatment)

# Equivalent:
chisq.test(table(cran$Infection, cran$Treatment))

##########
# From a summary with all the counts, but not in a two-way table
###########

# Look at the titanic data.
# There are two columns with the combinations of factor levels and a
# third column with counts. This can be converted to a contingency table using
# R's xtabs function. For example, this makes a table of Counts with Survive as
# rows and `Ticket Class` as columns:

titanic <- read_csv("Chapter_23/Titanic.csv")

titanic_table <- xtabs(Counts ~ Survive + `Ticket Class`, data = titanic)

# Note that the variable name has a space in it, so it needs to be enclosed in
# backticks. Usually a bad idea to have special characters in variable names!

# Now we can perform the test, look at the results, and optionally look at some 
# of the details:

titanic_test <- chisq.test(titanic_table)
titanic_test

titanic_test$expected
titanic_test$observed
titanic_test$residuals

#####
# Only the table itself is available in the question
#####

# Sometimes the data are not available at all. How might you solve a textbook
# question "manually", which in this case means "using the computer entering the
# numbers yourself"? Here's how I do it.

# Table 23.5 from example in section 23.4; tattoos versus Hepatitis C. 

# First, note the names of the row variable levels. You don't have to keep
# exactly the same names.
row_levels <- c("Parlour", "Elsewhere", "None")
col_levels <- c("Positive", "Negative")

# Now to construct the table of counts, using the magic of expand.grid and some
# other stuff. Enter the counts by column, top to bottom then left to right.

tat_hepc_counts <- data.frame(
  expand.grid(Tattoo = row_levels, Hep_C = col_levels),
  Counts = c(17, 8, 22, 35, 53, 491)
)

# Now use xtabs. Note the warning from R about the chisq test! Have a look to
# see how serious it is.
tat_hepc_table <- xtabs(Counts ~ Tattoo + Hep_C, tat_hepc_counts)

chisq.test(tat_hepc_table)$residuals
