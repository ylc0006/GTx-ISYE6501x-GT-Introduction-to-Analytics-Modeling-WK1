# -------------------- Code for HW 5 Question 3 -----------------------------
# Clear environment
rm(list = ls())

# install package
install.packages("FrF2")
library(FrF2)

# fractional factorial design, 10 factors, 16 runs
FrF2(16, 10)
