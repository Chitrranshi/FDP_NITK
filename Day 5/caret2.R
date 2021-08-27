#Calling libraries
 library(AppliedPredictiveModeling)
 library(caret)

## Loading required package: lattice

## Loading required package: ggplot2

 library(pROC)

#Prepare the dataset
 data(iris)
 
 summary(iris)
 
 head(iris)
 
 nrow(iris)
 
 #Visualising the dataset
  transparentTheme(trans = .4)
  featurePlot(x = iris[, 1:4], 
               y = iris$Species, 
               plot = "ellipse",
               auto.key = list(columns = 3))
  
  #Split into train and test dataset
   trainIndex <- createDataPartition(iris$Species, p = .8,
                                      list = FALSE,
                                      times = 1)
   train <- iris[ trainIndex,]
   test  <- iris[-trainIndex,]
  
   nrow(train)

   nrow(test)
  
  
  #Cross validation
  fitControl <- trainControl(
    method = "repeatedcv",
    number = 10,
    repeats = 5)
  
  
  ### Decision tree
  dt.fit <- train(Species ~ ., data = train,
                  method = "rpart",
                  trControl = fitControl,
                  preProcess=c("center", "scale"))
  
  dt.fit
  
  predictions <- predict(dt.fit, test)
  
  confusionMatrix(predictions, test$Species)
  
  
  #### k-NN
  
  knn.fit <- train(Species ~ ., data = train,
                   method = "knn",
                   trControl = fitControl,
                   preProcess=c("center", "scale"))
  knn.fit
  
  predictions <- predict(knn.fit, test)
  
  confusionMatrix(predictions, test$Species)
  
  #### random forest
  rf.fit <- train(Species ~ ., data = train,
                  method = "rf",
                  trControl = fitControl,
                  preProcess=c("center", "scale"))
  
  rf.fit
  
  predictions <- predict(rf.fit, test)
  
  confusionMatrix(predictions, test$Species)