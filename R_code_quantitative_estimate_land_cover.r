##### 3/12/21 #####
#R_code_quantitative_estimate_land_cover.r

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra) 

setwd("/Users/account2/Desktop/lab/")
#Location : Rio Pexoto (Brasil)

# Import all the images with the lapply function 

# 1st list the files available
rlist <- list.files(pattern = "defor")
# defor1 = NIR , red , green (before deforestation) 
# defor2 = NIR, red, green (after defor)

# 2nd use the lapply function : apply a function to a list 
list_rast <- lapply(rlist, brick) #use the brick function to import all the images 
list_rast # two separate files in the list_rast

plot(list_rast[[1]]) # we don't use the $ symbol but [[ ]] symbols

# defor: NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=3, b=3)
# vegetation reflecting a lot in NIR so the images become all red 
# red everywhere we have vegetation

l1992 <- list_rast[[1]] #re-assign a simple name
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=3, b=3, stretch="lin")

# Unsupervised classification 
l1992c <- unsuperClass(l1992, nClasses=2) #unsuperClass(x, nClasses)
l1992c # value : 2, one is the forest and one is the agriculture

plot(l1992c$map) #plot a map
# value n 1 = forest 
# value n 2 = agricultural areas and water 

#### frequencies of the pixel ####
# How many pixel inside my map are forest/agricultrual areas? 
# % of forest/agricultural area in my map ?
# the function frequencies count how many pixel there are 
# https://www.rdocumentation.org/packages/questionr/versions/0.7.5/topics/freq

freq(l1992c$map)

# [1,]     1  306619
# [2,]     2   34673

# value 1 = forest = 306619
# value 2 = agricultrual areas = 34673

total <- 341292 #total amount of pixel that I found in R when I wrote l1992c
propforest <-  306619 / 341292     # value of the frequencies/tot number 
propagri <- 34673 / total          # value of the frequencies/tot number 

# propforest = 0.8984066 ~ 0.90 = 90% of forest 
# propagri = 0.1015934 ~ 0.10 = 10% of agri

##### build a dataframe #####
https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/data.frame

cover <- c("Forest", "Agriculture")
prop1992 <- c(0.8984066, 0.1015934) 
prop1992 <- c(propforest,propagri) # the same

proportion1992 <- data.frame(cover, prop1992) #prop of pixel in 1992

#         cover  prop1992
# 1      Forest 0.8984066 #highest value
# 2 Agriculture 0.1015934 

# Plot the proportion1992 with ggplot function 
# https://www.rdocumentation.org/packages/ggplot2/versions/3.3.5

ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")


# Do the same things for the image of 2006
l2006c <- unsuperClass(l2006, nClasses=2)
l2006c # value : 2, one is the forest and one is the agriculture
plot(l2006c$map) #plot a map
# value n 1 = forest 
# value n 2 = agricultural areas and water 

#### frequencies of the pixel ####
# How many pixel inside my map are forest/agricultrual areas? 
# % of forest/agricultural area in my map ?
# the function frequencies count how many pixel there are 
# https://www.rdocumentation.org/packages/questionr/versions/0.7.5/topics/freq

freq(l2006c$map)
#1 177817 = forest 
#2 164909= agricultural areas and water 

total <- 342726
propforest2006 <- 177817/ total
propagri2006 <- 164909/ total

#propforest 0.5188314
#propagri 0.4811686

cover <- c("Forest", "Agriculture")
prop1992 <- c(propforest,propagri)
prop2006 <- c(propforest2006,propagri2006)

proportion <- data.frame(cover, prop1992, prop2006)
proportion

#        cover  prop1992  prop2006
#1      Forest 0.8984066 0.5188314
#2 Agriculture 0.1015934 0.4811686

# Do the ggplot

ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
# we have lost a lot of forest 
# Agri from 10% to almost 50% of the land --> and continuing rising up while forest continuing reduce 
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")

# Now do a multiframe with gridExtra to pot the two ggplot together in one file 
library(gridExtra) #recall the library
p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrows=1)


p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
p1 <- ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
####arrangeGrob(p1, p2, nrows=1)???
