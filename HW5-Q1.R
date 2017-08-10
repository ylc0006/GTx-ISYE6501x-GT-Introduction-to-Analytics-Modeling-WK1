# -------------------- Code for HW 5 Question 1 -----------------------------
# Clear environment
rm(list = ls())

# Read data
data <- read.table("uscrime.txt", stringsAsFactors = FALSE, header = TRUE)

# Install packages
install.packages("MASS") # for setpwise regression
library(MASS)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)
set.seed(1)

# Run stepwise regression model
datalm <- lm(Crime~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time, data)
datalmstep <- stepAIC(datalm, direction = "both")
datalmstep$anova

# Question 1-2
# Install packages
install.packages("glmnet") # for LASSO and Elastic net
library(glmnet)

# Scale the data
datascale<-scale(data)

# set x & y for Lasso 
x <- as.matrix(datascale[,1:15])
y <- datascale[,16]

# Split data into train (2/3) and test (1/3) sets
train_rows <- sample(1:47, .66*47)
x.train <- x[train_rows, ]
x.test <- x[-train_rows, ]

y.train <- y[train_rows]
y.test <- y[-train_rows]

# Run Lasso on training set
Model_Lasso <- glmnet(x.train, y.train, alpha = 1, family = "mgaussian")

# cross validation can also be used to select lambda
cv.Model_Lasso <- cv.glmnet(x.train, y.train, alpha=1)
plot(cv.Model_Lasso)

(best.lambda <- cv.Model_Lasso$lambda.min)

coef(cv.Model_Lasso, s = "lambda.min")

# Check MSE
yhat <- predict(cv.Model_Lasso, s=cv.Model_Lasso$lambda.min, newx=x.test)
mse <- mean((y.test - yhat)^2)

# Question 1-3
# Run Elastic net, alpha=0.5
Model_EN0.5 <- glmnet(x.train, y.train, alpha = 0.5, family = "mgaussian")


# cross validation can also be used to select lambda
cv.Model_EN0.5 <- cv.glmnet(x.train, y.train, alpha=0.5)
plot(cv.Model_EN0.5, main="alpha0.5")

(best.lambda <- cv.Model_EN0.5$lambda.min)

coef(cv.Model_Lasso, s = "lambda.min")

# Check MSE
yhatEN <- predict(cv.Model_EN0.5, s=cv.Model_EN0.5$lambda.min, newx=x.test)
mseEN <- mean((y.test - yhatEN)^2)
mseEN
