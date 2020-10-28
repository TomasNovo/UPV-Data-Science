# set Desktop as working directory
  setwd("C:/Users/Utilizador/Desktop")
  getwd()

# install ggplot2
  install.packages('ggplot2')
  library('ggplot2')


# read file
  Keratoconus <- read.csv("queratocono.csv", header=TRUE, sep=',')
  cat("Keratoconus info:")
  Keratoconus

# EXERCISE 1
  # default
    K1 <- Keratoconus$K1
    K2 <- Keratoconus$K2
    qplot(K1, K2, data = Keratoconus, geom = c("point", "smooth") , xlab="K1", 
          ylab="K2")

  # linear regression
    ggplot(Keratoconus, aes(K1,K2), xlab="K1", ylab="K2") + geom_point() + geom_smooth(se=TRUE, method = "lm")


# EXERCISE 2
    na <- Keratoconus$na
    ggplot(Keratoconus, aes(K1,K2, col = factor(na))) + ggtitle("Relation between K1 and K2") + geom_point() + geom_smooth(se=TRUE, method = "lm")
    
# EXERCISE 3
    K1.salida <- Keratoconus$K1.salida
    qplot(K1, K1.salida, data = Keratoconus, xlab="K1", 
          ylab="K1.salida")
    
# EXERCISE 4 
    grosor <- Keratoconus$grosor
    ggplot(Keratoconus, aes(factor(grosor), fill=factor(na))) + geom_bar()
    
# EXERCISE 5 
    diam <- Keratoconus$diam
    ggplot(Keratoconus, aes(x=K1, y=K2, fill=factor(grosor))) +
      facet_grid(diam~na) +
      geom_point(aes(colour = factor(grosor)), alpha = 1/3)

# EXERCISE 6
    boxplot1 <- ggplot(Keratoconus, aes(factor(grosor), K1)) + 
      geom_boxplot()
    boxplot2 <- ggplot(Keratoconus, aes(factor(grosor), K2)) + 
      geom_boxplot()
    
    # install library to add graphics
    install.packages('patchwork')
    library(patchwork)
    boxplot1 + boxplot2
    