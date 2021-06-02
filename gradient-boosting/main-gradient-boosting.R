# install.packages("tidyverse")
# install.packages("xgboost")
library(tidyverse)
library(caret)
library(xgboost)

train = read.csv(file = "./veri-on-isleme/eksikleri-silme/eksikleri_silindi_egitim_dengesiz-emrah.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/eksikleri-silme/eksikleri_silindi_test-emrah.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
train$X = NULL
test$X = NULL


set.seed(112233)
library(parallel) 
# Calculate the number of cores
no_cores <- detectCores() - 1

library(doParallel)
# create the cluster for caret to use
cl <- makePSOCKcluster(no_cores)


registerDoParallel(cl)

  # Fit the model on the training set
  model <- train(
    corona_result ~., data = train, method = "xgbTree",
    trControl = trainControl("cv", number = 10, allowParallel = TRUE)
  )
  # Best tuning parameter
  model$bestTune
  
stopCluster(cl)
registerDoSEQ()


library(gmodels)
testPred=predict(model, newdata=test, type="raw")
message("Test Datasinin Matrisi")
CrossTable(testPred, test$corona_result, prop.chisq = FALSE, chisq = FALSE, 
           prop.t = FALSE,
           dnn = c("Predicted", "Actual"))

confusionMatrix(data = testPred, reference = test$corona_result, mode = "everything", positive = "positive")
