# ------------------------ Code for Question 2 -------------------------------------
# Clear environment
rm(list = ls())

# Import the data
data <- read.table("iris.txt", header = TRUE, row.names = 1)

# Set the random number generator seed
set.seed(0213)

# Explore the data by ggplot (2 variable at a time)
ggplot(data, aes(Petal.Length, Petal.Width, color= Species)) + geom_point()
ggplot(data, aes(Sepal.Length, Sepal.Width, color= Species)) + geom_point()
ggplot(data, aes(Petal.Length, Petal.Width, color= Species)) + geom_point()
ggplot(data, aes(Sepal.Length, Petal.Length, color= Species)) + geom_point()
ggplot(data, aes(Sepal.Length, Petal.Width, color= Species)) + geom_point()
ggplot(data, aes(Sepal.Width, Petal.Width, color= Species)) + geom_point()
ggplot(data, aes(Sepal.Width, Petal.Length, color= Species)) + geom_point()


# Use kmeans to cluster 
model<- kmeans(data[,3:4], 3)

# we expect k = 3 to be a good cluster number, but we will look at k from 2 to 5 to see how more clusters affect clustering the points, 
#and since the starting assignments are random, we specify nstart = 20. This means that R will try 
#20 different random starting assignments and then select the one with the lowest within cluster variation.





# This is with unscaled data.  It's usually good practice to
# scale the data:

scdata <- data # initialize value/size of sdata
for (i in 1:4) { scdata[,i] <- (data[,i]-min(data[,i]))/(max(data[,i])-min(data[,i])) }

# Compare clusters with acutal species
table(model$cluster, data$Species)

# Plot the clusters
model$cluster<-as.factor(model$cluster)
ggplot(data, aes(Petal.Length, Petal.Width, color=model$cluster)) + geom_point()
ggplot(data, aes(Sepal.Width, Petal.Length, color=model$cluster)) + geom_point()
ggplot(data, aes(Sepal.Width, Petal.Width, color=model$cluster)) + geom_point()
ggplot(data, aes(Sepal.Length, Petal.Length, color=model$cluster)) + geom_point()
ggplot(data, aes(Sepal.Length, Petal.Length, color=model$cluster)) + geom_point()
ggplot(data, aes(Sepal.Length, Petal.Width, color=model$cluster)) + geom_point()
