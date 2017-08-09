# ------------------------ Code for Question 3 -------------------------------------
# Clear environment
rm(list = ls())

# Install outliers package and use outliers library
install.packages("outliers")
library(outliers)

# Import the data
data <- read.table("uscrime.txt", header = TRUE)

# Check outlier by grubbs.test
grubbs.test(data$Crime, type=11)

#Grubbs test for two opposite outliers

#G = 4.26880, U = 0.78103, p-value = 1
#alternative hypothesis: 342 and 1993 are outlier 

grubbs.test(data$Crime, type=10)
