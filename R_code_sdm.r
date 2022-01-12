#### 22/12/21 ####
# SDM
## R code for species distribution modelling, namely the distribution of individuals of a population in space

install.packages("sdm")

library(sdm)
library(raster) # predictors are environmental variable, predict where the species can be found over space
library(rgdal) # species for coordinate data, vector data #OSGeo website
# species : an array of x,y coordinate
# Species at higher temperature do not resist
# or : install.packages(c("sdm","rgdal")

# Now use the system file function in R that showing all the files in a certain packages
#https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/system.file

# species data 
file <- system.file("external/species.shp", package="sdm")
file # path in which you have the data

# Let's plot the species data
# re-creating a shape file in R with the shape file function 
# https://www.rdocumentation.org/packages/raster/versions/3.5-9/topics/shapefile that read or write a shapefile
# shapefile = points in space --> coordinates for the species so the presence of absence of species 
# shapefile is the correspondent of raster function 

species <- shapefile(file) #exactly as the raster function for raster files
# 200 points inside the dataset 
# 1 variable = occurrence that can be 0 or 1 
# 1 = means that there is the species 
# 0 = means that there is not the species 

# looking the occurrence
species$Occurrence

# how many occurrence are there? Subset a Dataframe
presences <- species[species$Occurrence == 1,] 
# == 1 number of occurrence = 1 (real occurrence) 

absences <- species[species$Occurrence == 0,] 
# == 0 means no species 


# plot all of the species

plot(species, pch=19)

# plot the presences (occurrence == 1)
plot(presences, pch=19, col="blue") #lower amount of point with respect to the species plot
# plot presences and absences with the function "Points"
# https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/points
points(absences, pch=19, col="red") 

# let's look at the predictors 
path <- system.file("external", package="sdm") 

lst <- list.files(path, pattern="asc", full.names=TRUE) #asc extension is the common pattern
# You can use the lapply function with the raster function, 
# but in this case it is not needed since the data are inside the package and they have an asc extension
preds <- stack(lst) # preds = predictor

# plot preds
cl <- colorRampPalette(c("blue","orange","red","yellow")) (100)
plot(preds, col=cl)

# plot only elevation and on top of elevation the presences 
plot(preds$elevation, col=cl)
points(presences, pch=19)
# the species are mainly at low elevation

# plot only temperature and on top of T° the presences
plot(preds$temperature, col=cl)
points(presences, pch=19)

# same for vegetation
plot(preds$vegetation, col=cl)
points(presences, pch=19)

# same for precipitation
plot(preds$precipitation, col=cl)
points(presences, pch=19)


# pch argument in r
# points scattered in space

# day 2 # 11/01/22 #
# importing the source script

# Set the working directory, not to upload the data but the entire script
setwd("/Users/account2/Desktop/lab/")
# with the source function: read R code from a file
source("R_code_source_sdm.r")

# in the theoretical slide of SDMs we should use individuals of a species and predictors
preds 
# these are the predictors : elevation, precipitation, temperature, vegetation (environmental variables)

# Let's explain to the model what are the training and the predictors
datasdm <- sdmData(train = species, predictors = preds) 
datasdm
#species is the dataset imported which contains presences and absences
# class = description of a certain object and in this case is sdmdata
# number of species = 1
# species names = Occurrence
# number of features = 4 (n. of predictors)
# type of data = Presence-Absence

# MODEL 1 #
m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, method="glm") 
# generalized linear model
# where the y variable = Occurrence , x variable = all the preds 

# use the model to make the prediction : probability of presence based on this model 
# apply the formula to every single predictor
p1 <- predict(m1, newdata = preds) 
p1

# now make the plot of the prediction (p1) : map probability
plot(p1, col=cl)
# probability of presence of a species 
# plot the presence on top of this (add)
points(presences, pch=19)
# this is the final map
# prediction of presence of a species : quite good 

# finally stack with everything all together 

s1 <- stack(preds, p1) 
plot(s1, col=cl)

# change the names in the plot of the stack with the function "names"
names(s1) <- c("Elevation", "Precipitation", "Temperature", "Vegetation", "Probability")
plot(s1, col=cl)

