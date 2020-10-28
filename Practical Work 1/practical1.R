# exercise 1
x<-1:12
v<-c(x)
cat("Vector: ", v)

# exercise 2
cat("4 repetitions of 6,2,4 :")
rep(c(6,2,4),4)
  
# exercise 3
s<-c(rep(9,6), rep(2,5), rep(5,4))
cat("Generated sequence: ", s)
cat("Generated matrix: ")
matrix(s,5,3,byrow=TRUE)

# exercise 4
set.seed(100)
n<-rnorm(20)
cat("Generated vector: ")
n
mean <- mean(n)
cat("Mean: ", mean)
median <- median(n)
cat("Median: ", median)
variance <- var(n)
cat("Variance: ", variance)
stddeviation <- sd(n)
cat("Standard deviation: ", stddeviation)

# exercise 5
# set Desktop as working directory
setwd("C:/Users/Utilizador/Desktop")
getwd()

# 5 a)
students <- read.table("data1.txt", header = FALSE, sep = " ", dec = ".")
students

# 5 b)
colnames(students) <- c("height","shoesize", "gender", "population")
students

# 5 d)
names <- colnames(students)
cat("Column names: ", names)

# 5 e)
heightColumn <- students$height
cat("Height column: ", heightColumn)

# 5 f)
genderFreq <- table(students$gender)
barplot(genderFreq, ylab="Frequency", xlab="Gender", main="Gender Distribution", col=c("pink","darkblue"), ylim=c(0,10))
populationfreq <- table(students$population)
barplot(populationfreq, ylab="Frequency", xlab="Polulation", main="Population Distribution", col=c("red","green"), ylim=c(0,10))

# 5 g)
cat("Contigency table:")
table(students$gender, students$population)

# 5 h)
# data frame operations
femaleSubset1 <- students[students$gender =="female",]
maleSubset1 <- students[students$gender =="male",]
cat("First female subset: ")
femaleSubset1
cat("First male subset: ")
maleSubset1
#subset function
femaleSubset2 <- subset(students, gender=="female")
cat("Second female subset: ")
femaleSubset2
maleSubset2 <- subset(students, gender=="male")
cat("Second male subset: ")
maleSubset2

# 5 i)
medianHeight <- median(heightColumn)
cat("Median Height: ", medianHeight)
# data frame operations
subsetBelow1 <- students[students$height < medianHeight,]
subsetAbove1 <- students[students$height > medianHeight,]
subsetEqual1 <- students[students$height == medianHeight,]
cat("Subset below median height: ")
subsetBelow1
cat("Subset above median height: ")
subsetAbove1
cat("Subset with median height: ")
subsetEqual1
#subset function
subsetBelow2 <- subset(students, height < medianHeight)
subsetAbove2 <- subset(students, height > medianHeight)
subsetEqual2 <- subset(students, height == medianHeight)
cat("Subset below median height: ")
subsetBelow2
cat("Subset above median height: ")
subsetAbove2
cat("Subset with median height: ")
subsetEqual2

# 5 j)
# 1st way - primitives
students$height <- students$height/100
students

# 2nd way - for loop
entries <- length(students$height)
for(i in 0:entries)
{ 
  students$height[i] <- students$height[i]/100
}
students

# 3rd way - apply
convertion = function(x)
{
  x <- x/100
}
students$height <- apply(students[1],2, convertion)
students

# 5 k)
plot(students$height, 
     students$shoesize, 
     xlab="Height", 
     ylab="Shoesize", 
     main="Height VS Shoesize", 
     col = ifelse(students$gender == "male", 
            'blue', 
            'magenta'),
     pch = ifelse(students$gender == "male", 
                  1, 
                  4)
     )

