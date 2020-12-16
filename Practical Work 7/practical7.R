# set Desktop as working directory
setwd("C:/Users/Utilizador/Desktop/UPV-Data-Science/Practical Work 7")
getwd()

# LOAD PACKAGES
# load caret package
if (!require("caret")) 
{install.packages("caret",dependencies=TRUE);
  library("caret")}

# install pbkrtest
if (!require("pbkrtest")) 
{install.packages("pbkrtest",dependencies=TRUE);
  library("pbkrtest")}

##############
# exercise 1 #
##############

# LOAD DATA
ttt <- read.table("tic-tac-toe.data.txt", header = F, sep = ",")

# change column names
t<- c("TL","TM","TR","ML","MM","MR","BL","BM","BR","Class")
colnames(ttt)<-make.names(t)
summary(ttt) # no missing values

##############
# exercise 2 #
##############
set.seed(300)
sample <- sample.int(n = nrow(ttt), size = floor(0.70*nrow(ttt)), replace = F)
train <- ttt[sample,]
test <- ttt[-sample,]
cat("Train dataset:")
train 
cat("Test dataset:")
test


##############
# exercise 3 #
##############

train_control <- trainControl(method = "cv", number = 10, classProbs =  TRUE)

# Naive Bayes
if (!require("klaR")) 
{install.packages("klaR",dependencies=TRUE);
  library("klaR")}

set.seed(3333)
model <- train(Class~., data = train,method = "nb",trControl = train_control)
model

# Decision Tree
if (!require("rpart")) 
{install.packages("rpart",dependencies=TRUE);
  library("rpart")}

set.seed(3333)
model2 <- train(Class ~., data = train, method = "rpart", trControl=train_control)
model2

# Neural Network
if (!require("nnet")) 
{install.packages("nnet",dependencies=TRUE);
  library("nnet")}

if (!require("randomForest")) 
{install.packages("randomForest",dependencies=TRUE);
  library("randomForest")}

set.seed(3333)
model3 <- train(Class~., data = train, method = "nnet", trControl = train_control)
model3

# Nearest Neighbor
set.seed(3333)
model4 <- train(Class~., data = train, method = "knn", trControl = train_control)
model4

# SVM
if (!require("kernlab")) 
{install.packages("kernlab",dependencies=TRUE);
  library("kernlab")}

set.seed(3333)
model5 <- train(Class~., data=train, method = "svmLinear", trControl = train_control)
model5

                  #########################
                  # Accuracy  #    Kappa  #
###########################################
#   Naive Bayes   # 0.6999667 # 0.30007388#
###########################################
# Decision Tree   # 0.7387720 # 0.28851939#
###########################################
# Neural Network  # 0.9761633 # 0.9449149 #
###########################################
# Nearest Neighbor# 0.8789868 # 0.6988977 #
###########################################
#     SVM         # 0.9791484 # 0.9514503 #
###########################################

##############
# exercise 4 #
##############

if (!require("AUC")) 
{install.packages("AUC",dependencies=TRUE);
  library("AUC")}

# Naive Bayes
pred <- predict(model, test)
confusionMatrix(table(pred, test$Class))
auc(roc(pred,as.factor(test$Class)))

# Decision Tree
pred2 <- predict(model2, test)
confusionMatrix(table(pred2, test$Class))
auc(roc(pred2,as.factor(test$Class)))


# Neural Network
pred3 <- predict(model3, test)
confusionMatrix(table(pred3, test$Class))
auc(roc(pred3,as.factor(test$Class)))

# Nearest Neighbor
pred4 <- predict(model4, test)
confusionMatrix(table(pred4, test$Class))
auc(roc(pred4,as.factor(test$Class)))

# SVM
pred5 <- predict(model5, test)
confusionMatrix(table(pred5, test$Class))
auc(roc(pred5,as.factor(test$Class)))

                  #######################################
                  #   Accuracy  #    Kappa  #   AUC     #
#########################################################
#   Naive Bayes   #   0.6806    #   0.3039  # 0.64622   #
#########################################################
# Decision Tree   #   0.6875    #   0.237   # 0.6017699 #
#########################################################
# Neural Network  #   0.9896    #   0.9781  # 0.9867257 #
#########################################################
# Nearest Neighbor#   0.8785    #   0.7321  # 0.848268  #
#########################################################
#     SVM         #   0.9896    #   0.9781  # 0.9867257 #
#########################################################


##############
# exercise 5 #
##############
if (!require("ROCR")) 
{install.packages("ROCR",dependencies=TRUE);
  library("ROCR")}

# 5A
# Naive Bayes
pred <- predict(model, test, type = "prob")

# Decision Tree
pred2 <- predict(model2, test, type = "prob")

# Neural Network
pred3 <- predict(model3, test, type = "prob")

# Nearest Neighbor
pred4 <- predict(model4, test, type = "prob")

# SVM
pred5 <- predict(model5, test, type = "prob")

# 5B
rocr_pred <- prediction(pred$positive, test$Class)
rocr_pred2 <- prediction(pred2$positive, test$Class)
rocr_pred3 <- prediction(pred3$positive, test$Class)
rocr_pred4 <- prediction(pred4$positive, test$Class)
rocr_pred5 <- prediction(pred5$positive, test$Class)

# 5C
perf <- performance(rocr_pred,'tpr','fpr')
perf2 <- performance(rocr_pred2,'tpr','fpr')
perf3 <- performance(rocr_pred3,'tpr','fpr')
perf4 <- performance(rocr_pred4,'tpr','fpr')
perf5 <- performance(rocr_pred5,'tpr','fpr')

# 5D
plot(perf, col = "pink")
plot(perf2, add = TRUE, col = "red")
plot(perf3, add = TRUE, col = "blue")
plot(perf4, add = TRUE, col = "green")
plot(perf5, add = TRUE, col = "yellow")

# 5E
# I would discard the Naive Bayes and Decision Tree models because of the low area under the curve compared with 
# the other methods: their accuracy is no so good as in the other methods.

