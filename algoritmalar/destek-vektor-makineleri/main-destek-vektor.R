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

#install.packages("parallelSVM")
#install.packages("doSNOW")

library(e1071)
library(parallelSVM)
library(parallel)
library(doSNOW)
library(foreach)
library(caret)

numOfCores <- detectCores() - 2

set.seed(1) 
# samp = sample(nrow(train), 290000)
# trainSamp = train[-samp, ]
svmModel = parallelSVM(corona_result~.,data = train, coresNumber = numOfCores)
svm_predictions = predict(svmModel, test)



# cl=makeCluster(numOfCores)
# registerDoSNOW(cl)
# num_splits = 4
# split_testing = sort(rank(1:nrow(test))%%4)
# unique(split_testing)
# predictions = foreach(i=0,.combine=c,.packages=c("e1071")) %dopar% {
#                         as.numeric(predict(svmModel,.GlobalEnv$test))
#   
# }
# print(predictions)
# stopCluster(cl)
# 
# start=proc.time()
# # predictions=parallel_predictions(svmModel,test)
# print(predictions)
# dopar_loop=proc.time()-start


table(svm_predictions, test[[9]], dnn = c("Tahmini Siniflar", "Gercek Siniflar"))
confusionMatrix(data = svm_predictions, reference = test[[9]], mode = "everything", positive = "positive")

library(e1071)
#install.packages("ROSE")
library(ROSE) 
RF_RocAll <- roc.curve(test[,9],svm_predictions,plotit=TRUE,main="RF ROC-Destek Vektör Makineleri Silinmiş Dengesiz", col= "pink")
print(RF_RocAll)