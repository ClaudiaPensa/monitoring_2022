# R code for uploading and visualizing Copernicus data in R

# install.packages("ncdf4")
library(ncdf4)
library(raster)

# Set the working directory 
setwd("/Users/account2/Desktop/lab/copernicus/")

soilwaterindex20211211 <- raster("c_gls_SWI1km_202112121200_CEURO_SCATSAR_V1.0.1.nc")
soilwaterindex20211211

plot(soilwaterindex20211211)

