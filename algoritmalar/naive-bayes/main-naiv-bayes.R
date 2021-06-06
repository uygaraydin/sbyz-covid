# system.time({
  
# library(doParallel)
# cl <- makeCluster(detectCores())
# registerDoParallel(cl)

# train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train$X = NULL
test$X = NULL

# dataClean = cleanedDataFile

# library(googledrive)
# library(dplyr)
# drive_deauth()
# temp = tempfile(fileext = ".csv")
# fileFromDrive = drive_download(as_id("1dua9DvoXqNuKadhZ6K_rOEmLOqBbZ3L1"), path = temp, overwrite = TRUE)
# dataFile = read.csv(temp)
# dataFile$test_date = NULL
# data = dataFile[!duplicated(dataFile), ]


train$corona_result = as.factor(train$corona_result)
train$cough = as.factor(train$cough)
train$fever = as.factor(train$fever)
train$sore_throat = as.factor(train$sore_throat)
train$shortness_of_breath = as.factor(train$shortness_of_breath)
train$head_ache = as.factor(train$head_ache)
train$corona_result = as.factor(train$corona_result)
train$age_60_and_above = as.factor(train$age_60_and_above)
train$gender = as.factor(train$gender)
train$test_indication = as.factor(train$test_indication)
train$corona_result = as.factor(train$corona_result)

test$cough = as.factor(test$cough)
test$fever = as.factor(test$fever)
test$sore_throat = as.factor(test$sore_throat)
test$shortness_of_breath = as.factor(test$shortness_of_breath)
test$head_ache = as.factor(test$head_ache)
test$corona_result = as.factor(test$corona_result)
test$age_60_and_above = as.factor(test$age_60_and_above)
test$gender = as.factor(test$gender)
test$test_indication = as.factor(test$test_indication)

summary(train)
summary(test)

# library(caret)
# set.seed(1)
# trainIndex=createDataPartition(data$corona_result, p=0.7, list = FALSE)
# train=data[trainIndex, ]
# test=data[-trainIndex, ]

print(table(test$corona_result))
print(table(train$corona_result))


# copyDataForCorrelation = rbind(train, test)
# 
# copyDataForCorrelation$cough = as.numeric(copyDataForCorrelation$cough)
# copyDataForCorrelation$fever = as.numeric(copyDataForCorrelation$fever)
# copyDataForCorrelation$shortness_of_breath = as.numeric(copyDataForCorrelation$shortness_of_breath)
# copyDataForCorrelation$age_60_and_above = as.numeric(copyDataForCorrelation$age_60_and_above)
# copyDataForCorrelation$gender = as.numeric(copyDataForCorrelation$gender)
# copyDataForCorrelation$sore_throat = as.numeric(copyDataForCorrelation$sore_throat)
# copyDataForCorrelation$head_ache = as.numeric(copyDataForCorrelation$head_ache)
# copyDataForCorrelation$test_indication = as.numeric(copyDataForCorrelation$test_indication)
# copyDataForCorrelation$corona_result = NULL
# 
# 
# correlationMatrix = cor(copyDataForCorrelation)
# correlationMatrix
# #install.packages("corrplot")
# library(corrplot)
# #korelansyon matrisi gorsellestirildi.
# corrplot(correlationMatrix)
# ###korelasyon bolumu bitisi


library(e1071)
NBclassfier=naiveBayes(corona_result~cough+fever+sore_throat+shortness_of_breath+head_ache+test_indication+age_60_and_above+gender, data=train, laplace = 0)
print(NBclassfier)



library(gmodels)
testPred=predict(NBclassfier, newdata=test, type="class")
message("Test Datasinin Matrisi")
CrossTable(testPred, test$corona_result, prop.chisq = FALSE, chisq = FALSE, 
           prop.t = FALSE,
           dnn = c("Predicted", "Actual"))

confusionMatrix(data = testPred, reference = test$corona_result, mode = "everything", positive = "positive")

library(e1071)
#install.packages("ROSE")
library(ROSE) 
RF_RocAll <- roc.curve(test[,9],testPred,plotit=TRUE,main="RF ROC-Naive Bayes Silinmiş Dengeli", col= "red")
print(RF_RocAll)

# 
# stopCluster(cl)
# })[[3]]
