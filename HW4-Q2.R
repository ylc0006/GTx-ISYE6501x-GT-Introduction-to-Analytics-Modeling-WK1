# -------------------- Code for HW 4 Question 2 -----------------------------
# Clear environment
rm(list = ls())

# Install packages
install.packages("tree")
install.packages("rpart")
install.packages("randomForest")
library(tree)
library(rpart)
library(randomForest)

# Read data
data <- read.table("uscrime.txt", stringsAsFactors = FALSE, header = TRUE)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)
set.seed(1)

# run a regression tree model
datatree<- tree(Crime~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time,data)
summary(datatree)
plot(datatree)
text(datatree)

# run a randomforest model 
datarF<-randomForest(Crime~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time,data)
summary(datarF)
plot(datarF)
datarF$ntree
datarF$importance
