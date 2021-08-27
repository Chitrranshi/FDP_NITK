##### Install the ggplot2 packages
#install.packages("ggplot2")

### load the library to the environment
library(ggplot2)

#### Load the diamond dataset
data("mpg")

str(mpg)
 
#### Plot the relationship between Engine size and Mileage

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()

##### Adding color option and show the difference with class
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point()

###### Faceting ###############

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)


######### Smooth ##############
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth()

####### Over-plotting issue ######

ggplot(mpg, aes(drv, hwy)) + 
  geom_point()

##### Avoid overlotting #####
ggplot(mpg, aes(drv, hwy)) + geom_jitter() # adds a little random noise to the data

ggplot(mpg, aes(drv, hwy)) + geom_boxplot() #summarise the shape of the distribution

ggplot(mpg, aes(drv, hwy)) + geom_violin() #show a compact representation of the "density" of the distribution

####### Barplot #######
ggplot(mpg, aes(manufacturer)) + 
  geom_bar()


######## Plot and axis titles ##########

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = factor(cyl))) + 
  labs(
    x = "Engine displacement (litres)", 
    y = "Highway miles per gallon", 
    colour = "Number of cylinders",
    title = "Mileage by engine size and cylinders",
    subtitle = "Source: http://fueleconomy.gov"
  )