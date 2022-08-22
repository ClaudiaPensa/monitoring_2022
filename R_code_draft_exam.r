# R code for uploading and visualizing Copernicus data in R

# install.packages("ncdf4")
library(ncdf4)
library(raster)


# Set the working directory 
setwd("/Users/account2/Desktop/lab/SMI/")

# Import all the data 

smi22 <- raster("sminx_m_euu_20220101_20220801_t.nc")
smi21 <- raster("sminx_m_euu_20210101_20211221_t.nc")
smi20 <- raster("sminx_m_euu_20200101_20201221_t (1).nc")
smi19 <- raster("sminx_m_euu_20190101_20191221_t.nc")
smi18 <- raster("sminx_m_euu_20180101_20181221_t.nc")
smi17 <- raster("sminx_m_euu_20170101_20171221_t.nc")
smi16 <- raster("sminx_m_euu_20160101_20161221_t.nc")
smi15 <- raster("sminx_m_euu_20150101_20151221_t.nc")
smi14 <- raster("sminx_m_euu_20140101_20141221_t.nc")
smi13 <- raster("sminx_m_euu_20130101_20131221_t.nc")
smi12 <- raster("sminx_m_euu_20120101_20121221_t.nc")

smi22
smi21
smi20
smi19
smi18
smi17
smi16
smi15
smi14
smi13
smi12

smindex11y <- c(smi22, smi21, smi20, smi19, smi18, smi17, smi16, smi15, smi14, smi13, smi12) 


# plot all the data together

par(mfrow=c(5,5))
plot(smi22)
plot(smi21)
plot(smi20)
plot(smi19)
plot(smi18)
plot(smi17)
plot(smi16)
plot(smi15)
plot(smi14)
plot(smi13)
plot(smi12)



##### day 2 #####
# recalling the libraries in R and setting the working directory 


# colorRampPalette to see the snow coverage at higher latitues 
cl <- colorRampPalette (c('dark blue','blue','light blue'))(100)
plot(sminx, col=cl)


# viridis package used to change the colour
# it directly uses a series of colours 
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties
install.packages("viridis")
library(viridis)
library(RStoolbox) 
library(ggplot2)
library(patchwork)

# ggplot and add geom raster, the geometry we want to use (e.g. histograms) 
ggplot() + 
geom_raster(sminx, mapping = aes(x=x, y=y, fill=sminx))
# ggplot with viridis
# scale_fill_viridis function is the function we use to change the colours 

ggplot() +
geom_raster(sminx, mapping = aes(x=x, y=y, fill=sminx )) + 
scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")

#### day 3 #####
# list the file
rlist <- list.files(pattern= "sminx") 
rlist

# apply the "lapply" function to the list (rlist)
list_rast <- lapply(rlist, raster)
list_rast # in the list_rast I can see the characteristics of the file, such as the dimension, the name...

# stack all the file stack together 
smistack <- stack(list_rast)
smistack

# assign the variable to a simple name
swisummer <- swistack$Surface.State.Flag.1
swiwinter <- swistack$Surface.State.Flag.2

# plot of SWI in summer
p1 <- ggplot() +
geom_raster(swisummer, mapping = aes(x=x, y=y, fill=Surface.State.Flag.1 )) + 
scale_fill_viridis(option="viridis") +
ggtitle("Soil water index in summer") #fill = variable name 

# plot of SWI in winter 
p2 <- ggplot() +
geom_raster(swiwinter, mapping = aes(x=x, y=y, fill=Surface.State.Flag.2 )) + 
scale_fill_viridis(option="viridis") +
ggtitle("Soil water index in winter") #fill = variable name 

# let's patchwork them together
p1 / p2 


### You can crop your image on certain area ####

# longitude from 0 to 20
# latitude from 30 to 50
ext <- c(0, 20, 30, 50)

# stack_cropped <- crop(swistack, ext) # this will crop the whole stack, and then single variables (layers) can be extracted

swisummer_cropped <- crop(swisummer,ext)
swiwinter_cropped <- crop(swiwinter,ext)

plot(swisummer_cropped)
plot(swiwinter_cropped)

p1_cropped <- ggplot() +
geom_raster(swisummer_cropped, mapping = aes(x=x, y=y, fill=Surface.State.Flag.1 )) + 
scale_fill_viridis(option="viridis") +
ggtitle("Soil water index in summer") #fill = variable name 

p2_cropped <- ggplot() +
geom_raster(swiwinter_cropped, mapping = aes(x=x, y=y, fill=Surface.State.Flag.2 )) + 
scale_fill_viridis(option="viridis") +
ggtitle("Soil water index in winter") #fill = variable name

#plot together the two plot cropped
p1_cropped / p2_cropped
