# set Desktop as working directory
setwd("C:/Users/Utilizador/Desktop")
getwd()

# EXERCISE 1
titanic <- read.csv("titanic.csv",header=TRUE, sep=',')
cat("Titanic info:")
titanic

# show column names
cat("Column names: ", colnames(titanic))

# remove column X
titanic<-subset(titanic,select=-X)

# commands to try
titanic
head(titanic)
summary(titanic)
plot(titanic)

# QUESTION : Which variables are quantitative and which variables are categorical? How can we know it?

# ANSWER: The variables Class, Sex, Age and Survived are categorical, while the variable Freq is quantitative. 
#         We can know it with the function summary(), which shows the type of the variables. As "Class", "Sex", "Age" 
#         and "Survived" are of the type "character" they are categorical. The variable "Freq" assumes numerical values, 
#         so we can classify it as a quantitative variable


# EXERCISE 2
cars <- read.csv("cars.csv",header=TRUE, sep=',')
cat("Cars info:")
cars

# remove column X
cars<-subset(cars,select=-X)
cars

# open PDF
pdf("cars-plots.pdf") 
cat("Saving plots on pdf named 'cars-plots.pdf'")


# 2.1
plot(cars$dist, 
     cars$speed, 
     xlab="Distance", 
     ylab="Speed",
     col.main="red", col.lab="blue",
     main="Distance in terms of Speed", 
     col = "blue", 
     pch = 16 )
cat("Saved plot 'Distance in terms of Speed' ")

# 2.2
distance <- table(cars$dist)
barplot(distance, ylab="Value", xlab="Distance", main="Distance Histogram", col=rainbow(35), col.main="magenta", col.lab="red")

cat("Saved plot 'Distance Histogram' ")

# 2.3
speed <- table(cars$speed)
barplot(speed, ylab="Value", xlab="Speed", main="Speed Histogram", col=rainbow(20), col.main="red", col.lab="blue")
cat("Saved plot 'Speed Histogram' ")

# Save to PDF
dev.off()
cat("Pdf 'cars-plots.pdf' saved")


# EXERCISE 3
# already removed the column on exercise 2 with function subset()
cars

# 3.1 
newCars <- data.frame(c(21,34), c(47,87))
colnames(newCars) <- c("speed","dist")
newCars

# 3.2
cars <- rbind(cars,newCars)
cars

# 3.3
# order()
cars <- cars[order(cars$speed),]
cars
# with and order()
cars <- with(cars, cars[order(cars$speed),])
cars

# EXERCISE 4
air <- read.csv("airquality.csv",header=TRUE, sep=',')
cat("Air Quality info:")
air
summary(air)

# 4.1
firstTwoRows <- air[1:2,]
cat("First Two Air Quality rows info:")
firstTwoRows

# 4.2
cat("Total of observations: ", nrow(air))

# 4.3
cat("Ozone at 40th row: ", air$Ozone[40])

# 4.4
subsetNA <- air[air$Ozone == "NA",]
cat("Number of NA's in Ozone column: ", length(subsetNA$Ozone))

# 4.5
subsetOzone <- subset(air, air$Ozone != "NA")
cat("Mean of Ozone column: ", mean(subsetOzone$Ozone))

# 4.6
subsetConditional <- subset(air, air$Ozone > 31 & air$Temp > 90)
subsetConditional
cat("Mean of Solar.R in subset: ", mean(subsetConditional$Solar.R))


# EXERCISE 5
# 5.1
breakpoints <- c(1, 34.4, 67.8, 101.2, 134.6, 168)
cat("Breakpoints: ", breakpoints)
(bins <- cut(airquality$Ozone, breaks = breakpoints, labels = c("bin1", "bin2", "bin3", "bin4", "bin5")))
air$ozoneBins <- bins
levels <- levels(air$ozoneBins)
levels[length(levels)+1] <- "binNA"
cat("Bin levels: ", levels)
air$ozoneBins <- factor(air$ozoneBins, levels = levels)
air$ozoneBins[is.na(air$ozoneBins)] <- "binNA"
air

# 5.2
breakpoints <- c(7, 88.75, 170.5, 252.25, 334)
cat("Breakpoints: ", breakpoints)
(bins <- cut(air$Solar.R, breaks = breakpoints, labels = c("bin1", "bin2", "bin3", "bin4")))
air$Solar.RBins <- bins
levels <- levels(air$Solar.RBins)
levels[length(levels)+1] <- "binNA"
cat("Bin levels: ", levels)
air$Solar.RBins <- factor(air$Solar.RBins, levels = levels)
air$Solar.RBins[is.na(air$Solar.RBins)] <- "binNA"
air

# 5.3
countDays <- function(data, colname, month, day){
        data[[colname]] <- ((data[[month]] - 5)*30) + (data[[day]]-1)
}
air$AbsDay <- countDays(air, "AbsDay", "Month", "Day")
air

# EXERCISE 6
# 6.1
for(i in 1: length(titanic$Class))
{ 
        if(titanic[i,1] == "Crew")
        {
        titanic[i,1] <- 4
        } else if(titanic[i,1] == "1st")
        {
        titanic[i,1] <- 3
        } else if(titanic[i,1] == "3rd")
        {
        titanic[i,1] <- 1
        } else if(titanic[i,1] == "2nd")
        {
        titanic[i,1] <- 2
        } 
}
titanic

# 6.2
titanic2 <- data.frame(titanic)
titanic2 <- subset(titanic2, titanic2$Freq != 0)
row.names(titanic2) <- 1:nrow(titanic2) # to order first column 1,2,3,4,etc
titanic2
for(i in 1: length(titanic2$Freq))
{
        for(i in 1: titanic$Freq[i])
        {
                newRow <- data.frame(titanic2$Class[i], 
                                     titanic2$Sex[i],
                                     titanic2$Age[i],
                                     titanic2$Survived[i],
                                     titanic2$Freq[i])
                
                colnames(newRow) <- c("Class",
                                       "Sex",
                                       "Age",
                                       "Survived",
                                       "Freq")
                
                titanic2 <- rbind(titanic2,newRow)
        }
}
titanic2

#6.3
pdf(file = "titanic_plots.pdf")
plot(titanic, main="Titanic", col="green")
plot(titanic2, main="Titanic 2", col="green")
dev.off()
# The plots are equal

# EXERCISE 7
# 7.1
plot(air)
airCor = cor(air)
airCor # no pair of redundant attributes

# 7.2
plot(cars)
carsCor = cor(cars)
carsCor # speed and distance are a pair of redundant attributes

# 7.3
set.seed(50)
(randomSample <- air[sample(1:nrow(air), 50),])
randomSample

# 7.4
install.packages("dplyr")
library(dplyr)
set.seed(1)
(stratSample <- air %>% group_by(Month) %>% sample_n(5, replace = FALSE))
stratSample

