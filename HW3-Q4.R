# -------------------- Code for HW 3 Question 4 -----------------------------
# Clear environment

rm(list = ls())

# install smooth packages

install.packages("smooth")
library("smooth")

# Read data
data <- read.table("uscrime.txt", stringsAsFactors = FALSE, header = TRUE)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)

set.seed(1)

# Regression model for unscale data
datalm<-lm(Crime~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time,data)

# Check the P-value for the regression model
summary(datalm)

#Create the test datapoint manually using dataframe
test <-data.frame(M = 14.0,So = 0, Ed = 10.0, Po1 = 12.0, Po2 = 15.5,LF = 0.640, M.F = 94.0, Pop = 150, NW = 1.1, U1 = 0.120, U2 = 3.6, Wealth = 3200, Ineq = 20.1, Prob = 0.040,Time = 39.0)

# Keep the factos w/ p-value smaller than 0.1
datalm0.1 <-lm(Crime~M+Ed+Po1+U2+Ineq+Prob,data)
summary(datalm0.1)

# keep the factos w/ p-value samller than 0.05
datalm0.05 <-lm(Crime~M+Ed+Ineq+Prob,data)
summary(datalm0.05)



# Scale the data
scdata <- data # initialize value/size of sdata
for (i in 1:15) { scdata[,i] <- (data[,i]-min(data[,i]))/(max(data[,i])-min(data[,i])) }

# Regression model for scale data
sclm <-lm(Crime~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time,scdata)


#remove predictors if their p values exceed a target alpha, say p > 0.05.