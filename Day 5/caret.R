# install.packages(c('caret', 'skimr', 'RANN', 'randomForest', 'fastAdaboost', 'gbm', 'xgboost', 'caretEnsemble', 'C50', 'earth'))

# Load the caret package
library(caret)

# Import dataset using weblink
#orange <- read.csv('https://raw.githubusercontent.com/selva86/datasets/master/orange_juice_withmissing.csv')
orange <- read.csv('C:\\Users\\91883\\Documents\\Workshop-Python for datascience\\Dataset & Scripts\\Day 2\\orange_juice_withmissing.csv')


# Structure of the dataframe
str(orange)

# See top 6 rows and 10 columns
head(orange[, 1:10])

########### Data Preparation and preprocessing  ###############

# Create the training and test datasets
set.seed(100)

# Step 1: Get row numbers for the training data, set list=FALSE, to prevent returning the result as a list.

trainRowNumbers <- createDataPartition(orange$Purchase, p=0.8, list=FALSE)
trainRowNumbers

# Step 2: Create the training  dataset
trainData <- orange[trainRowNumbers,]

# Step 3: Create the test dataset
testData <- orange[-trainRowNumbers,]

# Store X and Y for later use.
x = trainData[, 2:18]
y = trainData$Purchase

######################## Impute missing values ####################
anyNA(trainData)

preProcess_missingdata_model <- preProcess(trainData, method='knnImpute')
preProcess_missingdata_model

#centered - subtract by mean, used k=5 (considered 5 nearest neighbors) to predict the missing values 
#and scaled - divide by standard deviation)

library(RANN)  # required for knnInpute
trainData <- predict(preProcess_missingdata_model, newdata = trainData)

anyNA(trainData)


########## One hot encoding ####################
# convert the categorical variable with as many binary (1 or 0) variables as there are categories.

# One-Hot Encoding
# Creating dummy variables is converting a categorical variable to as many binary variables as here are categories.
dummies_model <- dummyVars(Purchase ~ ., data=trainData)

# Create the dummy variables using predict. The Y variable (Purchase) will not be present in trainData_mat.
trainData_mat <- predict(dummies_model, newdata = trainData)

# # Convert to dataframe
trainData <- data.frame(trainData_mat)

# # See the structure of the new dataset
str(trainData)

