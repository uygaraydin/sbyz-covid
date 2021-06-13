cleanedDataFile = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/logreg_ile_doldurulmus.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)
cleanedDataFile<-cleanedDataFile[,-1]

uni_data <- cleanedDataFile[!duplicated(cleanedDataFile),]
summary(uni_data)

# nrow(uni_data[duplicated(uni_data)==TRUE,]) 
library(caret)
set.seed(10) 

trainIndisleri <- createDataPartition(y = uni_data$corona_result, p = .70, list = FALSE)  

trainUnique <- uni_data[trainIndisleri,] 
TestUnique <- uni_data[-trainIndisleri,] 
table(trainUnique$corona_result)
table(TestUnique$corona_result)
nrow(trainUnique)
nrow(unique(trainUnique))
nrow(unique(TestUnique))

write.csv(trainUnique, "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv")
write.csv(TestUnique, "./veri-on-isleme/1-1_na-doldurma/unique_test.csv")
