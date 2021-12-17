# R code for uploading and visualizing Copernicus data in R

# install.packages("ncdf4")
library(ncdf4)
library(raster)

# Set the working directory 
setwd("/Users/account2/Desktop/lab/copernicus/")

soilwaterindex20211211 <- raster("c_gls_SWI1km_202112121200_CEURO_SCATSAR_V1.0.1.nc")
soilwaterindex20211211

plot(soilwaterindex20211211)

##### day 2 #####
# recalling the libraries in R and setting the working directory 


# colorRampPalette to see the snow coverage at higher latitues 
cl <- colorRampPalette (c('dark blue','blue','light blue'))(100)
plot(soilwaterindex20211211, col=cl)


# viridis package used to change the colour
# it directly uses a series of colours 
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties
install.packages("viridis")
library(viridis)
library(RStoolbox) 
library(ggplot2)

# ggplot and add geom raster, the geometry we want to use (e.g. histograms) 
ggplot() + 
geom_raster(soilwaterindex20211211, mapping = aes(x=x, y=y, fill=Surface.State.Flag))
# ggplot with viridis
# scale_fill_viridis function is the function we use to change the colours 

ggplot() +
geom_raster(soilwaterindex20211211, mapping = aes(x=x, y=y, fill=Surface.State.Flag )) + 
scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")

#### day 3 #####
# importing data with lapply function
rlist <- list.files(pattern= "SWI") 
rlist

list_rast <- lapply(rlist, raster)
list_rast

swistack <- stack(list_rast)
swistack

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
library(patchwork)
p1 / p2 


### You can crop your image on certain area ####

# longitude from 0 to 20
# latitude from 30 to 50
ext <- c(0, 20, 30, 50)
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
