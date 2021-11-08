# R code for ecosystem monitoring by remote sensing
# First of all we need to install addictional packages 
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages 
# https://cran.r-project.org/web/packages/raster/raster.pdf

install.packages("terra")

# we need to use quotes for things there are not in R
install.packages("raster")

# how to use library in r 
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/library
# with the function library we can use packages

library(raster)

# now we import data in R
# https://www.rdocumentation.org/packages/raster/versions/3.4-13/topics/brick 
# we use the function brick 

# first set the working directory 
# setwd("/Users/name/lab/") # mac

setwd("/Users/account2/Desktop/lab/")

# grd graphic file and 
# gri index file 

# we are going to import satellite data
# l for landsat satellite (object in R can't be number)
# l2011 is a raster brick file 
# the brick function imports all the layers
l2011 <- brick("p224r63_2011.grd")

l2011

plot(l2011)

# B1 is the reflectance in the blue band 
# B2 is the reflectance in the green band 
# B3 is the reflectance in the red band 
# B4 is the reflectance in the NIR band

# We can change the color palette
# https://www.rdocumentation.org/packages/dichromat/versions/1.1/topics/colorRampPalette
# black correspond to the lowelest value 
# ( black, grey,...) is an array so we write c before the parentheses, 100 means how many tones/colors we use
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl) 

# We maching the bands in the RGB components 
# https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/plotRGB

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
# the result is a natural color image 

# We want to plot each band (for eg. the bend n1 called B1_sre (spectral reflectance) and so on.. )
# Let's plot the green band 
# We link the dataset (l2011) with the band (B2_sre) with the symbol"$"
# plot(l2011 $ B2_sre) where: "plot" is the function and the "parentheses" is the argument
plot(l2011$B2_sre)

# We can change the color (so the values of reflectance) 
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011$B2_sre, col=cl) #plot the data with different colors

# B2
#change the colorRampPalette with dark green, green, light green
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col=clg)
# All pixels inside the image absorbing the green light are dark green, all the pixels reflecting the green light are light green 

# Now do the same job for the blue band using "dark blue", "blue", "light blue" for the band n.1 B1
# B1
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)

# par function https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/par
# plot both images in just one multiframe graph where 1=row 2=column 
par(mfrow=c(1,2)) 
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# Now plot both images in just one multiframe graph with two rows and one column
par(mfrow=c(2,1)) #the first number is the number of rows in the multiframe, while the seccond is the number of column
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

#---- day 3 recap
# plot only the blue band 
plot(l2011$B1_sre)
# plot only the blue band using a blue colorRampPalette
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)

# plot both images and creating a multiframe
# plot the blue and the green band besides with the funcion "par", with different colorRampPalette
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col=clg)
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# Exercise: put the plots one on top of the other (blue band on top, green band at bottom)
# invert the number of rows and the number of columns 
par(mfrow=c(2,1)) # two rows and just one column
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# Exercise : plot the first four bands with two rows and two columns
# the order is (from left to right) B1 , B2 , B3 , B4
# the colorRampPalette for the the nir is "red","orange","yellow" 

# First define the colorRampPalette for the B3 (red band)
#B3
clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
plot(l2011$B3_sre, col=clr)

# Do the same for the B4 band (nir band) 
#B4
clnir <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(l2011$B4_sre, col=clnir)

par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)

# plot rgb function https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/plotRGB
# first function to clean dev.off() function that close the plotting device ( the windows) 
dev.off()
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") #real colours
# the result image is in a visible spectre 

# now we want to extend this in the nir spectre but where put the B4? 
# change the composition to r = B4, g = B3 , b = B2 (shift by one)
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") #false colours
# vegetation is red bcs in the nir is the band where vegetations reflect a lot 

# now change the nir component and put it in the green component
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") 

plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")
# all the parts in yellow are areas where there has been the distribution of forests 

# plot all the images togheter 
par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") #real colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") #false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") #false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") #false colours

