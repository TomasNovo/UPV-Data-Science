# set Desktop as working directory
setwd("C:/Users/Utilizador/Desktop/UPV-Data-Science/Practical Work 6")
getwd()

# LOAD PACKAGES
# load lattice package
if (!require("lattice"))
{install.packages("lattice",dependencies=TRUE); library("lattice")}

# load rpart package
if (!require("rpart")) 
{install.packages("rpart",dependencies=TRUE);
  library("rpart")}

# load nnet package
if (!require("nnet")) 
{install.packages("nnet",dependencies=TRUE);
  library("nnet")}

# load Metrics package
if (!require("Metrics")) 
{install.packages("Metrics",dependencies=TRUE);
  library("Metrics")}

# load caret package
if (!require("caret")) 
{install.packages("caret",dependencies=TRUE);
  library("caret")}

# LOAD DATA
house_prices <- read.csv("HousePricesData-Address-City-Features_fromZillow.csv", header=TRUE, sep=';')
cat("House prices info:")
house_prices

##############
# exercise 1 #
##############

# anonymise data by removing street column
house_prices <- subset(house_prices, select = -street)
cat("House prices info:")
house_prices

# data explore
str(house_prices)
summary(house_prices)

##############
# exercise 2 #
##############
attach(house_prices)
forplot<-make.groups(bath=data.frame(value=bath,zipcode,city,state,price),year=data.frame(value=year,zipcode,city,state,price),bed=data.frame(value=bed,zipcode,city,state,price),rooms=data.frame(value=rooms,zipcode,city,state,price),SqFt=data.frame(value=SqFt,zipcode,city,state,price))
detach(house_prices)
xyplot(price~value|which, data=forplot,scales=list(relation="free"))

##############
# exercise 3 #
##############
set.seed(300)
sample <- sample.int(n = nrow(house_prices), size = floor(0.75*nrow(house_prices)), replace = F)
train <- house_prices[sample,]
test <- house_prices[-sample,]
cat("Train dataset:")
train 
cat("Test dataset:")
test

##############
# exercise 4 #
##############

# linear model 
linear_model <- lm(price~zipcode+year+bath+bed+rooms+SqFt, data = train)
linear_model


# regression tree CART
cart_tree <- rpart(price~zipcode+year+bath+bed+rooms+SqFt, data=train, method = "anova")
cart_tree

# neural network
neural_network <- nnet(price~zipcode+year+bath+bed+rooms+SqFt, data = train, size = 12, skip = TRUE, linout = TRUE)
neural_network

##############
# exercise 5 #
##############

# linear model 
summary(linear_model)

# regression tree CART
summary(cart_tree)
plot(cart_tree, main="Regression tree (CART)")
text(cart_tree, use.n=TRUE, all=TRUE, cex=.8)

# neural network
summary(neural_network)

# As expected, the less informative is the neural network because of the training

##############
# exercise 6 #
##############
printcp(cart_tree)
plotcp(cart_tree)

pruned_tree <- prune(cart_tree, cp = 0.0317)
pruned_tree

printcp(pruned_tree)
plotcp(pruned_tree)

plot(pruned_tree, main="Pruned Regression tree (CART)")
text(pruned_tree, use.n=TRUE, all=TRUE, cex=.8)

##############
# exercise 7 #
##############

# linear model
# test
prediction <- predict(linear_model, test)
rmse(prediction, test$price)
mae(prediction, test$price)
# train
prediction2 <- predict(linear_model, train)
rmse(prediction2, train$price)
mae(prediction2, train$price)

# regression tree CART
# test
prediction3 <- predict(cart_tree, test)
rmse(prediction3, test$price)
mae(prediction3, test$price)
# train
prediction4 <- predict(cart_tree, train)
rmse(prediction4, train$price)
mae(prediction4, train$price)

# neural_network
# test
prediction5 <- predict(neural_network, test)
rmse(prediction5, test$price)
mae(prediction5, test$price)
# train
prediction6 <- predict(neural_network, train)
rmse(prediction6, train$price)
mae(prediction6, train$price)

# The model that performs better for both training and test data is the CART tree

##############
# exercise 8 #
##############
model <- train(
  price~zipcode+year+bath+bed+rooms+SqFt,
  data = train,
  method = "knn"
)

# test
prediction7 <- predict(model, test)
rmse(prediction7, test$price)
mae(prediction7, test$price)
# train
prediction8 <- predict(model, train)
rmse(prediction8, train$price)
mae(prediction8, train$price)

