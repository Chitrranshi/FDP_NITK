# Install the dplyr package
#install.packages("dplyr")
#install.packages("modeest")


#Load Library dplyrinto our R session
library(dplyr)
library(modeest)


#After unzipping the archive, you can load the data into R using the readRDS() function.
chicago <- readRDS("C:\\Users\\91883\\Documents\\Workshop-Python for datascience\\Dataset & Scripts\\Day 2\\chicago.rds")

#see the dimension of our dataset
dim(chicago)

#see the structure of the dataset
str(chicago)

head(chicago)

statmode <- mlv(chicago$pm25tmean2, method = "mfv",na.rm = TRUE)
statmode
########################## SELECT ###################################

#chicago[1:5,city:dptp] - Will give error
#Way to take the first three columns in a dataset by using : for strings in select()
names(chicago)[1:3]
subset <- select(chicago, city:dptp)
head(subset)

# Ways to remove the first three columns using negative sign
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

subset <- select(chicago, -(city:dptp))
head(subset)

#options in select()
subset <- select(chicago, starts_with("d"))
head(subset)

subset <- select(chicago, ends_with("2"))
head(subset)

subset <- select(chicago, contains("pm"))
head(subset)

#subset <- filter(chicago,pm25tmean2==11.3)
#subset

####################### FILTER ####################################

#select rows where pm2.5 value is greater than 30
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)

summary(chic.f$pm25tmean2)

# Select rows with logical conditions
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

################## ARRANGE #####################################
chic.wa <- chicago[order(chicago$date),] # without arrange function
#chic.wa <- chicago[order(as.Date(chicago$date,format="%Y-%m-%d")),] # without arrange and date is not in the format
head(chic.wa)


chic.a <- arrange(chicago, date)
head(chic.a)

chic.a <- arrange(chicago, desc(date))
head(chic.a)

####################### RENAME #################################

head(chicago[, 1:5],3)  # Forcing the head to print only first 3 three rows of the data with first 5 columns

chic.rn <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2) # Renaming two column names in the dataset
head(chic.rn[, 1:5],3)

## Another way of renaming inside the select function() but remaining columns chopped-off
chic.rn <- select(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chic.rn[, 1:2],3)

################# PIPELINE ######################################
str(mtcars)
mtcars %>%
  filter(carb > 1)%>%
  group_by(cyl) %>%
  summarize(Avg_mpg = mean(mpg))

factor(mtcars$cyl)





