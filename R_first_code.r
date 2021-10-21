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
