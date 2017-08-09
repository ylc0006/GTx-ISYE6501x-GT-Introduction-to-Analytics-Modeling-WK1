# GTx-ISYE6501x-GT-Introduction-to-Analytics-Modeling

HW2-Q2

The iris data set contains 150 data points, each with four predictor variables and one categorical
response. The predictors are the width and length of the sepal and petal of flowers and the response is
the type of flower. The data is available from the R library datasets and can be accessed with iris once
the library is loaded. It is also available at the UCI Machine Learning Repository
(https://archive.ics.uci.edu/ml/datasets/Iris ). The response values are only given to see how well a
specific method performed and should not be used to build the model.

Use the R function kmeans to cluster the points as well as possible. Report the best combination of
predictors, your suggested value of k, and how well your best clustering predicts flower type.


HW2-Q3

Using crime data from http://www.statsci.org/data/general/uscrime.txt (description at
http://www.statsci.org/data/general/uscrime.html), test to see whether there is an outlier in the last
column (number of crimes per 100,000 people). Is the lowest-crime city an outlier? Is the highest-crime
city an outlier? Use the grubbs.test function in the outliers package in R.

HW2-Q5

1. Using July through October daily-high-temperature data for Atlanta for 1996 through 2015, use
a CUSUM approach to identify when unofficial summer ends (i.e., when the weather starts
cooling off) each year. That involves finding a good critical value and threshold to use across all
years. You can get the data that you need online, for example at
http://www.iweathernet.com/atlanta-weather-records or
https://www.wunderground.com/history/airport/KFTY/2015/7/1/CustomHistory.html . You can
use R if you’d like, but it’s straightforward enough that an Excel spreadsheet can easily do the
job too.

2. Use a CUSUM approach to make a judgment of whether Atlanta’s summer climate has gotten
warmer in that time (and if so, when).
