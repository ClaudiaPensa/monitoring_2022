######### 26/11/21 ########


# R code for chemical cycling study
# Time series of NO2 change in Europe during the lockdown

library(raster)

# set the working directory 
setwd("/Users/account2/Desktop/lab/en/")

# Use raster function bcs the images have the same layer https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/raster

en01 <- raster("EN_0001.png") 

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)

#plot the NO2 values of January 
plot(en01, col=cl)

# Exercise : import the end of March NO2 and plot it
en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# Build a multiframe window with 2 rows and 1 column with the par function
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)
# the agricultural areas remain the same, but we see that all the Rome and Madrid area present a decrease of NO2 emission

# Import all the images 
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

# plot all the data together
par(mfrow=c(4,4))
plot(en01, col=cl)
plot(en02, col=cl)
plot(en03, col=cl)
plot(en04, col=cl)
plot(en05, col=cl)
plot(en06, col=cl)
plot(en07, col=cl)
plot(en08, col=cl)
plot(en09, col=cl)
plot(en10, col=cl)
plot(en11, col=cl)
plot(en12, col=cl)
plot(en13, col=cl)

# To plotting all the images together using the function stack 
# https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/stack

EN <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)

# plot the stack all together 
plot(EN, col=cl) # plot the all set all together

# a satellite image is a stack 

# plot only the first image from the stack 
# check the stack names in R
EN
plot(EN$EN_0001, col=cl) #the new name of the image is EN_0001

# rgb space or rgb colours 
# r = red
# g = green
# b = blue

# plot RGB with the function plotRGB(x, r=1, g=2, b=3, stretch="lin")
plotRGB(EN, r=1, g=7, b=13, stretch="lin") 
# red part = higher value of NO2 in Jen 
# green part = higher value of NO2 in the middle of the lockdown
# blue part = higher value of NO2 in March
# the yellow part is the area that mantain the emission of NO2 costant like the Pianura Padana


################# day 2 ################

# Importing all the data together with the lapply function 
# lapply function 
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply


# recall the library(raster)

library(raster)

# set the working directory ("path") 
setwd("/Users/account2/Desktop/lab/en/")

# first of all make a list of images with the function list.files 
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list.files
rlist <- list.files(pattern="EN")
rlist

list_rast <- lapply(rlist, raster) ##https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply
list_rast # all of the file ,one after the other, imported .

# Now use the stack function to plot all the images together 
EN_stack <- stack(list_rast)
EN_stack

#plot everything together 
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) # using this col
plot(EN_stack, col = cl) 

# Exercise : Plot only the first image of the stack
# first check the name of the first image on R and then plot this using the same colorRampPalette
plot(EN_stack$EN_0001, col = cl)

#difference 
# image of decrease 
ENdif <- (EN_stack$EN_0001 - EN_stack$EN_0013)
cldif <- colorRampPalette(c("blue", "white", "red"))(100)
plot(ENdif, col=cldif)
# red part --> high change between the two images --> higher decrease of NO2 

######################################

# automated processing source function 
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/source

source("R_code_automatic_source.txt") 
