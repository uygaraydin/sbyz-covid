system.time({
  
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)

# cleanedDataFile = read.csv(file = "./veri-on-isleme/temizlenmis-veri-seti.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# cleanedDataFile$X = NULL
# dataClean = cleanedDataFile

library(googledrive)
library(dplyr)
drive_deauth()
temp = tempfile(fileext = ".csv")
fileFromDrive = drive_download(as_id("1dua9DvoXqNuKadhZ6K_rOEmLOqBbZ3L1"), path = temp, overwrite = TRUE)
dataFile = read.csv(temp)
dataFile$test_date = NULL
# data = dataFile[!duplicated(dataFile), ]
dataClean = dataFile
data = dataClean[!duplicated(dataClean), ]

data$corona_result = as.factor(data$corona_result)
data$cough = as.factor(data$cough)
data$fever = as.factor(data$fever)
data$sore_throat = as.factor(data$sore_throat)
data$shortness_of_breath = as.factor(data$shortness_of_breath)
data$head_ache = as.factor(data$head_ache)
data$corona_result = as.factor(data$corona_result)
data$age_60_and_above = as.factor(data$age_60_and_above)
data$gender = as.factor(data$gender)
data$test_indication = as.factor(data$test_indication)

dataClean$corona_result = as.factor(dataClean$corona_result)
dataClean$cough = as.factor(dataClean$cough)
dataClean$fever = as.factor(dataClean$fever)
dataClean$sore_throat = as.factor(dataClean$sore_throat)
dataClean$shortness_of_breath = as.factor(dataClean$shortness_of_breath)
dataClean$head_ache = as.factor(dataClean$head_ache)
dataClean$corona_result = as.factor(dataClean$corona_result)
dataClean$age_60_and_above = as.factor(dataClean$age_60_and_above)
dataClean$gender = as.factor(dataClean$gender)
dataClean$test_indication = as.factor(dataClean$test_indication)

dataClean$gender = NULL
dataClean$age_60_and_above = NULL
dataClean$test_indication = NULL
summary(dataClean)

data$gender = NULL
data$age_60_and_above = NULL
data$test_indication = NULL

summary(data)
summary(dataClean)

# library(caret)
# set.seed(1)
# trainIndex=createDataPartition(data$corona_result, p=0.7, list = FALSE)
# train=data[trainIndex, ]
# test=data[-trainIndex, ]
# 
# print(table(data$corona_result))
# print(table(train$corona_result))


library(e1071)
NBclassfier=naiveBayes(corona_result~cough+fever+sore_throat+shortness_of_breath+head_ache, data=data, laplace = 0)
print(NBclassfier)



library(gmodels)
testPred=predict(NBclassfier, newdata=dataClean, type="class")
message("Test Datasinin Matrisi")
CrossTable(testPred, dataClean$corona_result, prop.chisq = FALSE, chisq = FALSE, 
           prop.t = FALSE,
           dnn = c("Predicted", "Actual"))

confusionMatrix(data = testPred, reference = dataClean$corona_result, mode = "everything", positive = "positive")



stopCluster(cl)
})[[3]]
