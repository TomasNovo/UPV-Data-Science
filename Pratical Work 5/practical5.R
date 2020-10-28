# LOAD DATA
# set Desktop as working directory
setwd("C:/Users/Utilizador/Desktop")
getwd()

# read file
wine <- read.table("wine.data.txt", header = F, sep = ",")
str(wine)

# LOAD PACKAGES
# load ggplot2 package
if (!require("ggplot2"))
{install.packages("ggplot2",dependencies=TRUE); library("ggplot2")}

# load rpart package
if (!require("rpart")) 
{install.packages("rpart",dependencies=TRUE);
  library("rpart")}

# load caret package
if (!require("caret")) 
{install.packages("caret",dependencies=TRUE);
  library("caret")}

# load ggplot2 package
if (!require("ggplot2"))
{install.packages("ggplot2",dependencies=TRUE); library("ggplot2")}

# load e1071 package
if (!require("RWeka")) 
{install.packages("RWeka",dependencies=TRUE);
  library("RWeka")}

# Load java for RWeka
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre7') # for 64-bit version
Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\jre7') # for 32-bit version
library(rJava)


# change column names
t<-
  c("class","alco","ma","ash","alc","mg","tp","flav","noflav","proa","co
l","hue","od","prol")
colnames(wine)<-make.names(t)
wine$class=as.factor(wine$class)
head(wine)


# show plots
qplot(alco,mg,data=wine,col=class, xlab="Alcohol",ylab="Magnesium")
pairs(wine[,2:6], col=wine$class)

# classification tree for wine dataset
model<-rpart(class~.,data=wine,method="class")
plot(model, main="Classification Tree for Wine dataset")
text(model,use.n=TRUE, all=TRUE, cex=.8)

# display the model
printcp(model)

##############
# exercise 1 #
##############
set.seed(500)
sample <- sample.int(n = nrow(wine), size = floor(0.75*nrow(wine)), replace = F)
train <- wine[sample,]
test <- wine[-sample,]
cat("Train dataset:")
train 
cat("Test dataset:")
test

##############
# exercise 2 #
##############
train_model <- rpart(class~., data=train, method = "class")

##############
# exercise 3 #
##############
plot(train_model, main="Wine Traning dataset Classification Tree ")
text(train_model,use.n=TRUE, all=TRUE, cex=.8)

# display the model
printcp(train_model)

# Comparations:
# - number of observations decreased
# - the variables used in tree construction changed
# - The root node error increased

##############
# exercise 4 #
##############
pred1 <- predict(train_model, test)
pred1
pred2 <- predict(train_model, test, type = "class") # factor of classifications based on the responses.
pred2
pred3 <- predict(train_model, test, type = "vector") # predicted class (as a number).
pred3
pred4 <- predict(train_model, test, type = "prob") # matrix of class probabilities.
pred4
pred5 <- predict(train_model, test, type = "matrix") # concatenation of at least the predicted class, the class counts at that node in the fitted tree
pred5

##############
# exercise 5 #
##############
confusionMatrix(pred2, test$class)

##############
# exercise 6 #
##############
model2 <- LMT(class~., data = train)
pred_improved <- predict(model2, test)
confusionMatrix(pred_improved, test$class)

model3 <- J48(class~.,data = train)
pred_improved <- predict(model3, test)
confusionMatrix(pred_improved, test$class)

model4 <- J48(class~.,data = train)
pred_improved <- predict(model4, test)
confusionMatrix(pred_improved, test$class)

# minsplit - the minimum number of observations that must exist in a node in order for a split to be attempted.
# cp - complexity parameter.
# xval - number of cross-validations
model5 <- rpart(class~., data=train, control=rpart.control(minsplit=10,cp=0.01, xval=3))
pred_improved <- predict(model5, test, type="class")
confusionMatrix(test$class, pred_improved)