# this is my first code in github
# here are the input data 
# Costanza data on streams
water <- c(100, 200, 300, 400, 500)
water

# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes

#plot the diversity of the fishes (y) versus the amount of water (x) (puoi separare dopo la virgola)
plot(water,fishes)


# The data we developed can be stored in a table
# a table in R is called data frame

streams <- data.frame(water, fishes)


# From now on, we are going to import and/or export data! 
# setwd (wd = working directory) 
setwd("/Users/account2/Desktop/lab/")


# Let's export our table! 
# with the function write.table( x = object to be written , file = string of character)
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table
# use quotes for object outside R 
write.table(streams, file="my_first_table.txt")

# Some colleagues did send us a table. How to import it in R?
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/read.table
read.table("my_first_table.txt") 
# let's assign it to an object inside R
claudiapensa <- read.table("my_first_table.txt") 

# the first statistics for lazy beautiful people 
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary
summary(claudiapensa) 

# Marta does not like water
# Marta wants to get info only on fishes
summary(claudiapensa$fishes)

# the histogram for lazy people
# https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/hist
hist(claudiapensa$fishes)
hist(claudiapensa$water)

