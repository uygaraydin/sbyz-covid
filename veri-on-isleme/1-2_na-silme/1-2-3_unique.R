
### Temizlenmis veri setinin cagirilmasi 
########################################

#install.packages("googledrive")
#install.packages("dplyr")
# library(googledrive)
# library(dplyr)
# drive_deauth()
# temp = tempfile(fileext = ".csv")
# fileFromDrive = drive_download(as_id("1gf3_b_1qxT46GegUEKjnAerKNdgBDRim"), path = temp, overwrite = TRUE)
# cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
# summary(cleanedDataFile)
# 
# cleanedDataFile<-cleanedDataFile[,-1]
# uni_data <- cleanedDataFile[!duplicated(cleanedDataFile),]
# 
# ek <- c(0,0,0,0,0,"negative",NA,NA,"Abroad")

cleanedDataFile = read.csv(file = "./veri-on-isleme/genel-temizlik.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
cleanedDataFile<-cleanedDataFile[,-1]
cleanedDataFile = na.omit(cleanedDataFile)


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

#Tekrarlari olan silmek
# uni_data <-rbind(uni_data,ek)
# tail(uni_data)


### Eksiklerin silinmesi
########################

# summary(uni_data)
# uni_data = filter(uni_data, age_60_and_above != "NA")
# uni_data = filter(uni_data, gender != "NA")
# uni_data<-uni_data[,-1]
cleanedDataFile <- cleanedDataFile[!duplicated(cleanedDataFile),]
#write.csv(cleanedDataFile, "ekstra-temizlenmis-veri-seti.csv", row.names = TRUE)


#Hold Out

library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = cleanedDataFile$corona_result, p = .70, list = FALSE)  

egitimUnique <- cleanedDataFile[egitimIndisleri,] 
testUnique <- cleanedDataFile[-egitimIndisleri,] 
table(egitimUnique$corona_result)
table(testUnique$corona_result)


write.csv(egitimUnique, "./veri-on-isleme/1-2_na-silme/unique_egitim.csv")
write.csv(testUnique, "./veri-on-isleme/1-2_na-silme/unique_test.csv")
