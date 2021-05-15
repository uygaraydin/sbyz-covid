cleanedDataFile = read.csv(file = "./veri-on-isleme/temizlenmis-veri-seti.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)

library(caret)
set.seed(1)
trainIndex=createDataPartition(cleanedDataFile$corona_result, p=0.7, list = FALSE)
train=cleanedDataFile[trainIndex, ]
test=cleanedDataFile[-trainIndex, ]

library(randomForest)
