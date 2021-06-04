#install.packages("googledrive")
#install.packages("dplyr")
library(googledrive)
library(dplyr)
drive_deauth()
temp = tempfile(fileext = ".csv")
fileFromDrive = drive_download(as_id("1dua9DvoXqNuKadhZ6K_rOEmLOqBbZ3L1"), path = temp, overwrite = TRUE)

dataFile = read.csv(temp)
dataFile$test_date = NULL


#dataFile = filter(dataFile, corona_result != "other", age_60_and_above != "", gender != "")


dataFile = filter(dataFile, corona_result != "other")
dataFile$age_60_and_above[dataFile$age_60_and_above==""] = NA
dataFile$gender[dataFile$gender==""] = NA
# dataFile = dataFile[which(rowMeans(!is.na(dataFile)) > 0.7), ]

dataFile$corona_result = as.factor(dataFile$corona_result)
dataFile$age_60_and_above = as.factor(dataFile$age_60_and_above)
dataFile$gender = as.factor(dataFile$gender)
dataFile$test_indication = as.factor(dataFile$test_indication)
dataFile$cough = as.factor(dataFile$cough)
dataFile$fever = as.factor(dataFile$fever)
dataFile$sore_throat = as.factor(dataFile$sore_throat)
dataFile$shortness_of_breath = as.factor(dataFile$shortness_of_breath)
dataFile$head_ache = as.factor(dataFile$head_ache)

dataFile <- dataFile[, c(1,2,3,4,5,7,8,9,6)]

summary(dataFile)

#dataFile = filter(dataFile, !(cough == 0 & fever == 0 & sore_throat == 0 & shortness_of_breath == 0 & head_ache == 0 & corona_result == "negative"))

#temizlenmis veri setin bilgisayardaki proje klasorune eklendi
write.csv(dataFile, "./veri-on-isleme/genel-temizlik.csv", row.names = TRUE)


library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = dataFile$corona_result, p = .70, list = FALSE)  

genelTemizlikEgitim <- dataFile[egitimIndisleri,] 
genelTemizlikTest <- dataFile[-egitimIndisleri,] 
table(genelTemizlikEgitim$corona_result)
table(genelTemizlikTest$corona_result)


write.csv(genelTemizlikEgitim, "./veri-on-isleme/genel_temizlik_egitim.csv")
write.csv(genelTemizlikTest, "./veri-on-isleme/genel_temizlik_test.csv")
