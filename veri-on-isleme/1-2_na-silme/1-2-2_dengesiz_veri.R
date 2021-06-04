cleanedDataFile = read.csv(file = "./veri-on-isleme/genel-temizlik.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
cleanedDataFile<-cleanedDataFile[,-1]
cleanedDataFile = na.omit(cleanedDataFile)
summary(cleanedDataFile)

cleanedDataFile$age_60_and_above = as.factor(cleanedDataFile$age_60_and_above)
cleanedDataFile$gender = as.factor(cleanedDataFile$gender)
cleanedDataFile$test_indication = as.factor(cleanedDataFile$test_indication)
cleanedDataFile$cough = as.factor(cleanedDataFile$cough)
cleanedDataFile$fever = as.factor(cleanedDataFile$fever)
cleanedDataFile$sore_throat = as.factor(cleanedDataFile$sore_throat)
cleanedDataFile$shortness_of_breath = as.factor(cleanedDataFile$shortness_of_breath)
cleanedDataFile$head_ache = as.factor(cleanedDataFile$head_ache)
cleanedDataFile$corona_result = as.factor(cleanedDataFile$corona_result)

summary(cleanedDataFile)

library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = cleanedDataFile$corona_result, p = .70, list = FALSE)  

dengesizEgitim <- cleanedDataFile[egitimIndisleri,] 
dengesizTest <- cleanedDataFile[-egitimIndisleri,] 
table(dengesizEgitim$corona_result)
table(dengesizTest$corona_result)


write.csv(dengesizEgitim, "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv")
write.csv(dengesizTest, "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv")
