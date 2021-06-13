#install.packages("googledrive")
#install.packages("dplyr")
# library(googledrive)
# library(dplyr)
# drive_deauth()
# temp = tempfile(fileext = ".csv")
# fileFromDrive = drive_download(as_id("1gf3_b_1qxT46GegUEKjnAerKNdgBDRim"), path = temp, overwrite = TRUE)
# cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
# summary(cleanedDataFile)

cleanedDataFile = read.csv(file = "./veri-on-isleme/genel-temizlik.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)
cleanedDataFile<-cleanedDataFile[,-1]


#install.packages("mice")
library(mice)
imputed_Data<-mice(data = cleanedDataFile, m = 3, method = "logreg", maxit = 5, seed = 500)

completeData <- complete(imputed_Data,3)
summary(completeData)


duplicates=nrow(completeData[duplicated(completeData)==TRUE,]) 

write.csv(completeData, "./veri-on-isleme/1-1_na-doldurma/logreg_ile_doldurulmus.csv")
# 


##################### Ayni islem 3 dosyaya ayrildi ##################### 
# 
# # install.packages("caret") 
# library(caret) 
# set.seed(10) 
# 
# egitimIndisleri <- createDataPartition(y = completeData$corona_result, p = .70, list = FALSE)  
# 
# Egitim <- completeData[egitimIndisleri,] 
# Test <- completeData[-egitimIndisleri,] 
# table(Egitim$corona_result)
# table(Test$corona_result)
# nrow(Egitim)
# 
# write.csv(Egitim, "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv")
# write.csv(Test, "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv")
# 
# #dengeleme
# 
# l1= as.data.frame(completeData$corona_result[completeData$corona_result=="negative"])
# l2=as.data.frame(completeData$corona_result[completeData$corona_result=="positive"])
# fark=nrow(l1)-nrow(l2)
# 
# set.seed(1) 
# samp = sample(which(completeData$corona_result=="negative"), size = fark)
# completeData = completeData[-samp, ]
# summary(completeData)
# 
# set.seed(10) 
# 
# egitimIndisleri <- createDataPartition(y = completeData$corona_result, p = .70, list = FALSE)  
# 
# Egitim_dengele <- completeData[egitimIndisleri,] 
# Test_dengele <- completeData[-egitimIndisleri,] 
# table(Egitim_dengele$corona_result)
# table(Test_dengele$corona_result)
# 
# 
# write.csv(Egitim_dengele, "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv")
# write.csv(Test_dengele, "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv")
# 
# 
# 
# #Tekrarlari olan silmek
# uni_data <- completeData[!duplicated(completeData),]
# summary(uni_data)
# 
# 
# 
# 
# nrow(uni_data[duplicated(uni_data)==TRUE,]) 
# 
# 
# set.seed(10) 
# 
# egitimIndisleri <- createDataPartition(y = uni_data$corona_result, p = .70, list = FALSE)  
# 
# EgitimUnique <- uni_data[egitimIndisleri,] 
# TestUnique <- uni_data[-egitimIndisleri,] 
# table(EgitimUnique$corona_result)
# table(TestUnique$corona_result)
# nrow(EgitimUnique)
# nrow(unique(EgitimUnique))
# nrow(unique(TestUnique))
# 
# write.csv(EgitimUnique, "./veri-on-isleme/1-1_na-doldurma/unique_egitim_.csv")
# write.csv(TestUnique, "./veri-on-isleme/1-1_na-doldurma/unique_test.csv")
