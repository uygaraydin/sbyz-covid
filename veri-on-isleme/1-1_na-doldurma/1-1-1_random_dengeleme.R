cleanedDataFile = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/logreg_ile_doldurulmus.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)
cleanedDataFile<-cleanedDataFile[,-1]

l1= as.data.frame(completeData$corona_result[completeData$corona_result=="negative"])
l2=as.data.frame(completeData$corona_result[completeData$corona_result=="positive"])
fark=nrow(l1)-nrow(l2)

set.seed(1) 
samp = sample(which(completeData$corona_result=="negative"), size = fark)
completeData = completeData[-samp, ]
summary(completeData)

set.seed(10) 

trainIndisleri <- createDataPartition(y = completeData$corona_result, p = .70, list = FALSE)  

train_dengele <- completeData[trainIndisleri,] 
Test_dengele <- completeData[-trainIndisleri,] 
table(train_dengele$corona_result)
table(Test_dengele$corona_result)


write.csv(train_dengele, "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv")
write.csv(Test_dengele, "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv")




