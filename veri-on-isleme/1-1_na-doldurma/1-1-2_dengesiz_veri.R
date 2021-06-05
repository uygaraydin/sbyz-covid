cleanedDataFile = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/logreg_ile_doldurulmus.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)
cleanedDataFile<-cleanedDataFile[,-1]

# install.packages("caret") 
library(caret)
set.seed(10) 
trainIndisleri <- createDataPartition(y = completeData$corona_result, p = .70, list = FALSE)  

train <- completeData[trainIndisleri,] 
test <- completeData[-trainIndisleri,] 
table(train$corona_result)
table(test$corona_result)
nrow(train)

write.csv(train, "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv")
write.csv(test, "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv")