###### 19/11/21 ############ Deforestation in Moto Grosso, Brazil #############
# R code for estimating energy in ecosystems 
# first always run library)raster)
library(raster)

# set the working directory 
setwd("/Users/account2/Desktop/lab/")

# Import the data from the lab folder with the brick function
l1992 <- brick("defor1_.jpg") # image of 1992
l2006 <- brick("defor2_.jpg") # image of 2006

l1992
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
