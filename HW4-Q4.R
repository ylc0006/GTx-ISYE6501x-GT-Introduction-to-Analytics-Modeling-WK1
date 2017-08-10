# -------------------- Code for HW 4 Question 4 -----------------------------
# Clear environment
rm(list = ls())

# Read data
data <- read.table("germancredit.txt", stringsAsFactors = FALSE, header = FALSE)

# Install packages
install.packages("pscl")
library(pscl)
install.packages("gmodels")
library(gmodels)
install.packages("ROCR")
library(ROCR)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)
set.seed(1)

# covert the last column good or bad into 1 or 0 (for logistic regression)
data$V21 <- as.integer(as.logical(data$V21 < 2))

# run logistic regression
datalr<-glm(V21 ~ V1+V2+V3+V4+V5+V6+V7+V8+V9+V10+V11+V12+V13+V14+V15+V16+V17+V18+V19+V20, family=binomial(link="logit"), data)
summary(datalr)

# run logistic regression w/ factors p-value smaller than 0.05
datalr0.05<- glm(V21~V1+V2+V3+V4+V5+V6+V8+V9+V10+V14+V20, family=binomial(link="logit"), data)
summary(datalr0.05)

# run logistic regression w/ factors p-value smaller than 0.1
datalr0.1<-glm(V21 ~ V1+V2+V3+V4+V5+V6+V7+V8+V9+V10+V12+V14+V15+V20, family=binomial(link="logit"), data)
summary(datalr0.1)

# Check the quality of model by Pseudo R^2 (McFadden)
# Reference (https://www.r-bloggers.com/evaluating-logistic-regression-models/)
pR2(datalr)
pR2(datalr0.05)
pR2(datalr0.1)

# Coefficients of the model
coef(datalr0.05)

sum(data[,21])


# Reference (https://onlinecourses.science.psu.edu/stat857/node/217)
# 50-50 training data & test data  
indexes = sample(1:nrow(data), size=0.5*nrow(data)) #Random sample of 50% of row numbers created
Train50 <- data[indexes,] # Training data contains created indices
Test50 <- data[-indexes,] # Test data contains the rest

# Using training data to run logsitic regression
LogisticModel50 <- glm(V21 ~ V1+V2+V3+V4+V5+V6+V7+V8+V9+V10+V11+V12+V13+V14+V15+V16+V17+V18+V19+V20, family=binomial(link="logit"), data = Train50)
summary(LogisticModel50)

# keep the attributes where p-value lower than 0.1 and run logistic regression as model_1
LogisticModel50_1 <- glm(V21 ~ V1+V2+V3+V4+V6+V8+V10+V12+V14+V16, family=binomial(link="logit"), data = Train50)
summary(LogisticModel50_1)

# Keep the attributes where p-value lower than 0.1 and run logistic regressoin as model_2
LogisticModel50_2 <- glm(V21 ~ V1+V2+V3+V4+V6+V10+V14+V16, family=binomial(link="logit"), data = Train50)
summary(LogisticModel50_2)
pR2(LogisticModel50_2)


# Try Threshold set >= 0.5, then consider good to provide credit
fit50 <- fitted.values(LogisticModel50_2)
Threshold50 <- rep(0,500) 

for (i in 1:500){
  if(fit50[i] >= 0.5) Threshold50[i] <- 1
}

CrossTable(Train50$V21, Threshold50, digits=1, prop.r=F, prop.t=F, prop.chisq=F, chisq=F, data=Train50)


# Total Cost if threshold set at 0.5
Totalcost50 <- 68* 5 + 35 * 1 
Totalcost50


# Try Threshold set >=0.7,then consider good to provide credit
fit50 <- fitted.values(LogisticModel50_2)
Threshold70 <- rep(0,500) 

for (i in 1:500){
  if(fit50[i] >= 0.7) Threshold70[i] <- 1
}

CrossTable(Train50$V21, Threshold70, digits=1, prop.r=F, prop.t=F, prop.chisq=F, chisq=F, data=Train50)

# Total Cost if threshold set at 0.7
Totalcost70 <- 38* 5 + 85 * 1 
Totalcost70
