#### INTRO ####

# I decided to study the NDVI of the Po Valley, a highly cultivated area, to assess how NDVI varies over months and years
# using sentinel2 data

#### study area ####
# the study area under consideration is the Po Valley with particular focus on the area south of Cremona 
# I have defined the study area on qgis, including points of interest that I use to create a temporal series of NDVI 

#  First of all we need to install addictional packages usefull to run my project with the function install.packages
# packages usefull are "tidyr", "rgdal"* , "ggplot2"*, "terra"*, "leaflet", "rasterVis", "gridExtra"* , "RColorBrewer", "plotly"
# * = already imported in R during the lessons 

#### tidyr package #####
# tidyr package : Tidy Messy Data Tools to help to create tidy data, 
# where each column is a variable, each row is an observation, and each cell contains a single value
# link: https://cran.r-project.org/web/packages/tidyr/index.html

#### rgdal package ####
# rgdal package: Bindings for the 'Geospatial' Data Abstraction Library 
# Provides bindings to the 'Geospatial' Data Abstraction Library ('GDAL') (>= 1.11.4) 
# and access to projection/transformation operations from the 'PROJ' library. 
# link: https://cran.r-project.org/web/packages/rgdal/index.html

#### ggplot2 package ####
# ggplot2 package: Create Elegant Data Visualisations Using the Grammar of Graphics
# A system for 'declaratively' creating graphics, based on "The Grammar of Graphics". 
# You provide the data, tell 'ggplot2' how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.
# link: https://cran.r-project.org/web/packages/ggplot2/index.html

#### terra package ####
# terra package: Spatial Data Analysis
#replacement for the "raster" package
# Methods for spatial data analysis with vector (points, lines, polygons) and raster (grid) data.
# link: https://cran.r-project.org/web/packages/terra/index.html

#### leaflet package ####
# leaflet package: Create Interactive Web Maps with the JavaScript 'Leaflet' Library
# Create and customize interactive maps using the 'Leaflet' JavaScript library and the 'htmlwidgets' package
# link: https://cran.r-project.org/web/packages/leaflet/index.html

#### rasterVis package #### 
# rasterVis package: Visualization Methods for Raster Data
# Methods for enhanced visualization and interaction with raster data
# link: https://cran.r-project.org/web/packages/rasterVis/index.html

#### gridExtra package ####
# gridExtra package: Miscellaneous Functions for "Grid" Graphics
# Provides a number of user-level functions to work with "grid" graphics, notably to arrange multiple grid-based plots on a page, and draw tables.
# link: https://cran.r-project.org/web/packages/gridExtra/index.html

#### RColorBrewer package ####
# RColorBrewer package: ColorBrewer Palettes
# Provides color schemes for maps (and other graphics) designed by Cynthia Brewer as described at http://colorbrewer2.org.
# similar to ColorRampPalette used during the lessons
# link: https://cran.r-project.org/web/packages/RColorBrewer/index.html

#### plotly package ####
# plotly package Create Interactive Web Graphics via 'plotly.js'
# https://cran.r-project.org/web/packages/plotly/index.html

#### PROJECT ####

#install the packages 
install.packages("tidyr")
install.packages("rgdal")
install.packages("ggplot2")
install.packages("terra")
install.packages("leaflet")
install.packages("rasterVis")
install.packages("gridExtra")
install.packages("RColorBrewer")
install.packages("plotly")

# load the packages into R 
library(tidyr)
library(terra)
library(leaflet)
library(rasterVis)
library(gridExtra)
library(RColorBrewer)
library(plotly)
library(raster)
library(rgdal)
library(ggplot2)

# Now set the working directory 
setwd("/Users/account2/Desktop/exam_monitoring")

# load shp file of the study area and the shp file of the points of interest 

#try to "read" the study area in r 
Study_Area <- readOGR("Study_Area.shp")
points_SA <- readOGR("poi.shp")
Study_Area # to see the details
points_SA #to see the details

Study_Area2 <- spTransform(Study_Area, CRS("+proj=utm +zone=32 +datum=WGS84 +units=m"))
#points_SA2 <- spTransform(points_S_A, CRS("+proj=utm +zone=32 +datum=WGS84 +units=m"))
#try to plot an interactive map with the study area poligon using the leaflet package

map <- leaflet(sizingPolicy = leafletSizingPolicy(defaultHeight = 200, viewer.suppress = TRUE, knitr.figure = FALSE)) %>%
       addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
       addPolygons(data = Study_Area,
       stroke = FALSE,
       smoothFactor = 0.5
                 )
                 
map

#the leaflet function use the  magrittr pipe operator (%>%) 
#the equivalent without the  magrittr pipe operator (%>%) is: 
# map <- leaflet()
# map <- addProviderTiles()
# map <- addPolygons()


# IT WORKS #

# Load Sentinel-2 data of the study area that goes from june 2022 to nov 2022 (data of oct not available)
# setting the specific folder where the data are 
# the data used are derived from Sentinel-2 copernicus open access hub website and I decide to use 
# the level 2A of Sentinel - 2 that use the bottom of the atm reflectance 
# and create the variable S2 = sentinel2 

S2 <- "/Users/account2/Desktop/exam_monitoring/Sentinel2/"

# overwrite the variable S2 with a list by using the list.files function of R

S2 <- list.files(S2, recursive = TRUE, full.names = TRUE, pattern = "B0[2348]_10m.jp2$")

# S2 variable pointing to the path /Users/account2/Desktop/exam_monitoring/sentinel2
# recursive is important to go into the different subfolders within the sentinel2 folder
# look for files with a specific pattern that is = "B0[2348]_10m.jp2s" 
# 2348 are the bands

S2 <- lapply(1:length(S2), function (x) {raster(S2[x])})
# input = 1 : length(S2) = list of file and I want to apply to each element of the list a specific funcion to load the file into r (with the raster function)
# raster function load raster file into r 

S2 # visualize the product 

# setting the layout 
# create a stack and putting in together the raster list file 

S2_stack <- stack(S2) 

# Plot True/False images 
# using the plotRGB of the raster package 
# plotRGB has a multilayer stack where each layer is a band 
# I need to specify in which layer I have the red, green and blue band
# since the file are imported in the order 2348, 
# the blue band (=2 in Sentinel2) is in the index 1
# the green band (=3 in Sentinel2) is in the index 2
# the red band (=4 in sentinel2) is in the index 3

par(mfrow=c(1,2)) #to divide the frame into the desired grid
plotRGB (S2_stack, r=3, g=2, b=1, scale=maxValue(S2[[2]]), stretch='hist') #TrueColor image 
plot(Study_Area2, add=TRUE, border='yellow', lwd=5) #add the study area on the previous plot with add=TRUE
plotRGB (S2_stack, r=4, g=3, b=2, scale=maxValue(S2[[2]]), stretch='hist') #FalseColor image
plot(Study_Area2, add=TRUE, border='yellow', lwd=5)

#crop the data so that I use only the data within the study area  
S2_stack_crop <- crop(S2_stack, Study_Area2)
#jpeg(file="S2_stack_crop.jpg") #create a jpg file into the main folder
par(mfrow=c(1,2))
#plotRGB (S2_stack_crop, r=3, g=2, b=1, scale=maxValue(S2[[2]]),stretch='hist')
#plotRGB (S2_stack_crop, r=4, g=3, b=2, scale=maxValue(S2[[2]]),stretch='hist')

#try to plot both graph with a title but without the x and y axes --> fail
#plotRGB (S2_stack_crop, r=3, g=2, b=1, scale=maxValue(S2[[2]]), axes=TRUE,  main="True Color", col.axis="white",col.lab="white",tck=0,stretch='lin')
#plotRGB (S2_stack_crop, r=4, g=3, b=2, scale=maxValue(S2[[2]]),axes=TRUE, main="False Color", col.axis="white",col.lab="white",tck=0, stretch='lin')

plotRGB (S2_stack_crop, r=3, g=2, b=1, scale=maxValue(S2[[2]]),stretch='lin')
plotRGB (S2_stack_crop, r=4, g=3, b=2, scale=maxValue(S2[[2]]),stretch='lin')

#dev.off() #to save the jpg file

#Derive NDVI with for loop  
# I have 5 products so I expect 5 NDVI 
NDVI <- list() #create a variable that will be a list containing all the NDVI 

# for every elements (i) that goes from 1 to length of S2(=20)/4 = 5 (prods) I want that for the first element of my list ->
# NDVI[[i]] I overlay ((i-1)*4+3) for example: when i = 1 --> ((i-1)*4+3) is equal to (1-1)*4+3 = 3 --> has to take the S2_stack_crop in position n.3 (Red band)
# and than the same thing with the formula (i - 1)*4+4) that allows me to take the S2_stack_crop in position n.4 that correspond to the Band8 = NIR
# the function (y-x)/(y+x) is the formula for the NDVI (NIR-R)/(NIR+R)

for (i in 1:(length(S2)/4)) {
  NDVI[[i]] <- overlay(S2_stack_crop[[((i-1)*4+3)]], S2_stack_crop[[((i - 1)*4+4)]], fun = function(x,y) (y-x)/(y+x))
  names(NDVI[[i]]) <- paste0("NDVI_", strsplit(strsplit(names(S2_stack_crop[[(i-1)*4+4]]), "_")[[1]][2], "T")[[1]][1])
}
NDVI

# NDVI are normalized from -1 to 1

#### IT WORKS #####

#custom color

breaks <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
pal <- brewer.pal(11, "RdYlGn")
mapTheme <- rasterTheme(region = pal)
mapTheme$fontsize$text = 15


# Plot NDVI & points of interest

points_SA2 <- spTransform(points_SA, CRS("+proj=utm +zone=32 +datum=WGS84 +units=m")) #change the csr

#jpeg(file="NDVI_&_points.jpg") #create a jpg file into the main folder

levelplot(stack(NDVI), scales=list(draw=FALSE), colorkey=FALSE, par.settings=mapTheme ) +
latticeExtra::layer(sp.points(points_SA2, pch=13, col=69, bg='red', cex=1, lwd=1 ))

#pch,col,bg, cex and lwd  are index for the visualization
#latticeExtra::layer bcs geom is not defined

#dev.off()

#extract pixel value from the point of interest
#the points are used as reference to extract specific NDVI value and plot temple series 
NDVI_points <- lapply(NDVI, FUN=function (NDVI) {extract(NDVI, points_SA2, method='bilinear', df=TRUE)})
NDVI_points[1] #example to see the details

NDVI_points_df <- do.call("cbind", NDVI_points)

#Clean df -> remove duplicate columns
NDVI_points_df <- NDVI_points_df[, !duplicated(colnames(NDVI_points_df))]
NDVI_points_df

#arrange df
write.table(NDVI_points_df, file="NDVI_points_dftxt") # to export a file txt with the value of df
NDVI_points_df <- gather(NDVI_points_df, key = Date, value = value, -ID)
NDVI_points_df

#Plot NDVI temporal series
jpeg(file="ndvi_plot.jpg")
ndvi_plot <- ggplot(data=NDVI_points_df, aes(x=Date, y=value, group=ID, color=ID)) + 
  geom_line() +
  geom_point()

ndvi_plot
dev.off()
 
# embed_notebook(ggplotly(), height="500") #I tried to load the package and to put labels on the different trends plotted on the graph #fail




