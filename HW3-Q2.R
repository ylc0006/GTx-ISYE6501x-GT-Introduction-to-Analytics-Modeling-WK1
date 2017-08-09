# -------------------- Code for HW 3 Question 2 -----------------------------
# Clear environment

rm(list = ls())

# install smooth, forecast packages

install.packages("smooth")
library("smooth")
install.packages("forecast")
library("forecast")

# Read data
data <- read.table("temps.txt", header = TRUE)

# Avg daily temp each year
d_avg  <- colMeans(data[,2:21], na.rm = TRUE)

# Trasform to time series
d_avg.ts<-ts(d_avg)

# Setting the random number generator seed so that our results are reproducible
# (Your solution doesn't need this, but it's usually good practice to do)

set.seed(1)

# Plot the data.ts
plot.ts(d_avg.ts)

# Exponential Smoothing
d_avg.ts_forecasts<-HoltWinters(d_avg.ts, beta = FALSE, gamma = FALSE)

# plot 
plot(d_avg.ts_forecasts)

d_avg.ts_forecasts$fitted

# Forecast
d_avg.ts_forecasts2<-forecast.HoltWinters(d_avg.ts_forecasts, h=5)

# Plot forecast
plot.forecast(d_avg.ts_forecasts2)
