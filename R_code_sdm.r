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



