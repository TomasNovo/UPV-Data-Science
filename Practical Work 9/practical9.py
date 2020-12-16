import clusters
from clusters import *
from PIL import Image 

# LOAD DATA
(rownames,colnames,blogdata) = clusters.readfile("blogdata.txt") 
(rownames2,colnames2,zebodata) = clusters.readfile("zebo.txt") 

##############
# Exercise 1 #
##############

blogdata_hcluster = clusters.hcluster(blogdata)
clusters.drawdendrogram(blogdata_hcluster, rownames, "exercise1.jpg")
                                                          
img = Image.open('exercise1.jpg')
img.show() 

##############
# Exercise 2 #
############## 

blogdata_kcluster = clusters.kcluster(blogdata, distance = clusters.pearson, k = 10)
print(blogdata_kcluster)

##############
# Exercise 3 #
##############

clusters.draw2d( clusters.scaledown(blogdata, distance = clusters.pearson, rate = 0.01), rownames, "exercise3.jpg")

##############
# Exercise 4 #
##############

newdata = clusters.rotatematrix(blogdata)
newdata_hcluster = clusters.hcluster(newdata)
clusters.drawdendrogram(newdata_hcluster, colnames, "exercise4.jpg")

newdata_kcluster = clusters.kcluster(newdata, distance=clusters.pearson)
print(newdata_kcluster)

##############
# Exercise 5 #
##############

zebodata_hcluster = clusters.hcluster(zebodata, distance = clusters.tanamoto)
clusters.drawdendrogram(zebodata_hcluster, rownames2, "exercise5.jpg")

img = Image.open('exercise5.jpg')
img.show() 