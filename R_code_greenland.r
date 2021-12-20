#### 20/12/21 ####

# Ice melt in Greenland 
# Proxy: LST
# Land surface temperature : is the radiative skin temperature of the land surface

library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

#Set the working directory 
setwd("/Users/account2/Desktop/lab/greenland/")

# First of all : list all the file
# with the pattern = "lst" 
rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist, raster)
import

# Now do a stack
tgr <- stack(import)
tgr

# Plot the all stack
# change the colorRampPalette 
# levelplot(tgr)

cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(tgr, col=cl)

# yellow = the highest temperature
# blue = low temperature 

#### Do the ggplot #####

# ggplot of the first and final images 2000 vs 2015

# ggplot of 2000
p1 <- ggplot() + 
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + 
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

#ggplot of 2015
p2 <- ggplot() + 
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) + 
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")
# the lowest value in temperature decrease in space --> higher temperature all around 

# plot the ggplot together 

p1 + p2

# temperature in 2000 was really lower with respect to the temperature in 2015
# Higher temperature are all around Greenland

# Do the distribution of lst
# build an histogram of the data
# plotting the frequency distributions of data
par(mfrow=c(1,2))
hist(tgr$lst_2000) # histogram in 2000
hist(tgr$lst_2015) # histogram in 2015

par(mfrow=c(2,2))
hist(tgr$lst_2000) # histogram in 2000
hist(tgr$lst_2005) # histogram in 2005
hist(tgr$lst_2010) # histogram in 2010
hist(tgr$lst_2015) # histogram in 2015

plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))  #xy graph
# y = bx + a , where the slope b= 1 and the intercept is a = 0 
abline(0,1, col="red") 
# 0 intercept and slope = 1

# make a plot with all the histogram and all the regressions for all the variable
par(mfrow=c(4,4))
hist(tgr$lst_2000) # histogram in 2000
hist(tgr$lst_2005) # histogram in 2005
hist(tgr$lst_2010) # histogram in 2010
hist(tgr$lst_2015) # histogram in 2015
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2000, tgr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2000, tgr$lst_2010, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2005, tgr$lst_2000, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2005, tgr$lst_2010, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2010, tgr$lst_2000, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2010, tgr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2015, tgr$lst_2000, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2015, tgr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2015, tgr$lst_2010, xlim=c(12500, 15000), ylim=c(12500, 15000))


# To not do all this plot, we can use pairs function that create Scatteplot Matrices
pairs(tgr)



