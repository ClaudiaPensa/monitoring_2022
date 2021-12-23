#### 22/12/21 ####
# SDM
## R code for species distribution modelling, namely the distribution of individuals of a population in space

install.packages("sdm")

library(sdm)
library(raster) #predictors
library(rgdal) #species

#Set the working directory 
#setwd("/Users/account2/Desktop/lab/")

# Now use the system file function in R that showing all the files in a certain packages
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/system.file
file <- system.file("external/species.shp", package="sdm")
file #path in which you have the data

# Let's plot the species data
# re-creating a shape file in R with the shape file function 
# https://www.rdocumentation.org/packages/raster/versions/3.5-9/topics/shapefile that read or write a shapefile
# shapefile = points in space --> coordinates for the species so the presence of absence of species 

species <- shapefile(file) #exactly as the raster function for raster files

# plot species

plot(species, pch=19, col="red")
# pch argument in r
# points scattered in space



