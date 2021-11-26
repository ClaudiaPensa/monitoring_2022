###### 19/11/21 ############ Deforestation in Moto Grosso, Brazil #############
# R code for estimating energy in ecosystems 
# first always run library)raster)
library(raster)

# Then run the library (rgdal)
library(rgdal)

# set the working directory 
setwd("/Users/account2/Desktop/lab/")

# Import the data from the lab folder with the brick function
# First import the image of 1992
l1992 <- brick("defor1_.jpg") # image of 1992
l1992

# Bands : defor1_.1 , defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

# plotting the imported image with the plotRGB function
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
# since we are put the NIR band in the red channel, everything which reflecting the NIR a lot (like vegetation) should become red
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")

####### 22/11/21 ########
# Now see the new image of 2006 
# Import the data from the lab folder with the brick function
l2006 <- brick("defor2_.jpg") # image of 2006
l2006

# plotting the imported image with the plotRGB function
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") 

# Bands : defor1_.1 , defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green


# Now plot the two images together with the par function
par(mfrow = c(2,1)) #mfrow function with 2=row and 1=column
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") 

dev.off() # Close a plotting device

# Let's calculate energy in 1992
# Calculate the DVI index for each pixel
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
# the layer defor1_.1 containing the different NIR reflectances, defor1_.2 containing the different red reflectances
# now set the color of the palette 
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black'))(100) 
plot(dvi1992, col=cl)

# Calculate energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black'))(100) 
plot(dvi2006, col=cl)

# differencing two images of energy in two different times
dvidif <- dvi1992 - dvi2006 
# plot the results
cld <- colorRampPalette(c('blue', 'white', 'red'))(100)
plot(dvidif, col=cld) 

# Final plot : original images, dvis, final dvi difference
# we have the original image of 1992, of 2006, the dvi of 1992, dvi of 2006 and finally the dvi difference
# plot all together with the par function (3=row, 2=column)
par(mfrow = c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") 
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld) # final result of how energy was lost in the system 
# Create a pdf
pdf("energy.pdf") # save all the stuff in a pdf
par(mfrow = c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin") 
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()

pdf("dvi.pdf") # save all the stuff in a pdf
par(mfrow = c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()


########## day 3 #######
install.packages("ggplot2") # for new graphical properties

install.packages("gridExtra") # for new multiframe properties

install.packages("ncdf4") # for managing Copernicus data

or simply

install.packages(c("ggplot2","gridExtra","ncdf4"))

install.packages("RStoolbox") # install the package RStoolbox (https://cran.r-project.org/web/packages/RStoolbox/index.html)





