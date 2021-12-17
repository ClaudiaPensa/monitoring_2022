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
ggplot() + geom_raster(soilwaterindex20211211, mapping = aes(x=x, y=y, fill=Surface.State.Flag))
# ggplot with viridis
# scale_fill_viridis function is the function we use to change the colours 

ggplot() +geom_raster(soilwaterindex20211211, mapping = aes(x=x, y=y, fill=Surface.State.Flag )) + scale_fill_viridis(option="cividis") + ggtitle("cividis palette")

