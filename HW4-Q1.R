# -------------------- Code for HW 4 Question 1 -----------------------------
# Clear environment

rm(list = ls())

# Read data
data <- read.table("uscrime.txt", stringsAsFactors = FALSE, header = TRUE)
xbar <- colMeans(data[,-16]) # for transfer back to unscaled coefficients
std   <- apply(data[,-16], 2, sd) # for transfer back to unscaled coefficients

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)

set.seed(1)

# Run Principal Component Analysis model
datapca <-prcomp(~M+So+Ed+Po1+Po2+LF+M.F+Pop+NW+U1+U2+Wealth+Ineq+Prob+Time,data, scale=TRUE)
summary(datapca)
screeplot(datapca, type="lines")
biplot(datapca)

# Run regression model using the first 4 principal components
datapca4lm <-lm(data[,16]~datapca$x[,1]+datapca$x[,2]+datapca$x[,3]+datapca$x[,4], data)
summary(datapca4lm)

#initialize original coefficients
orig_coefficients <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
names(orig_coefficients) <-c("M", "So", "Ed", "Po1", "Po2", "LF", "M.F", "Pop","NW", "U1", "U2", "Wealth", "Ineq", "Prob", "Time")

# iterate through the top four principal components 
for (k in 4) {
  for (name in names(orig_coefficients)) {
    add <- datapca4lm$coefficients[k+1] * datapca$rotation[,k][[name]] #b(k)v(jk)
    orig_coefficients[[name]] <- orig_coefficients[[name]] + add
  }
}

orig_coefficients

# Original Coefficients - Scaled
(b0 <- coef(datapca4lm)[1])
(bs <- datapca$rotation[,1:4] %*% as.matrix(coef(datapca4lm)[-1]))

# Compute Original Coefficients - Unscaled
# Reference:https://stats.stackexchange.com/questions/74622/converting-standardized-betas-back-to-original-variables
accum <- 0
bs_unscaled <- rep(0,15)
for(i in 1:15){
  accum <- accum + bs[i]*xbar[i]/std[i]
  bs_unscaled[i] <- bs[1]/std[i] 
}
(b0_unscaled <- b0 - accum)
bs_unscaled

