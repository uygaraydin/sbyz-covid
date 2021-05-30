
### Temizlenmis veri setinin cagirilmasi 
########################################

#install.packages("googledrive")
#install.packages("dplyr")
library(googledrive)
library(dplyr)
drive_deauth()
temp = tempfile(fileext = ".csv")
fileFromDrive = drive_download(as_id("1gf3_b_1qxT46GegUEKjnAerKNdgBDRim"), path = temp, overwrite = TRUE)
cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)

cleanedDataFile<-cleanedDataFile[,-1]
uni_data <- cleanedDataFile[!duplicated(cleanedDataFile),]

ek <- c(0,0,0,0,0,"negative",NA,NA,"Abroad")

#Tekrarlari olan silmek
uni_data <-rbind(uni_data,ek)
tail(uni_data)


### Eksiklerin silinmesi
########################

summary(uni_data)
uni_data = filter(uni_data, age_60_and_above != "NA")
uni_data = filter(uni_data, gender != "NA")
uni_data<-uni_data[,-1]
nrow(uni_data[duplicated(uni_data)==TRUE,]) 
#write.csv(cleanedDataFile, "ekstra-temizlenmis-veri-seti.csv", row.names = TRUE)


#Hold Out

library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = uni_data$corona_result, p = .70, list = FALSE)  

EgitimUnique <- uni_data[egitimIndisleri,] 
TestUnique <- uni_data[-egitimIndisleri,] 
table(EgitimUnique$corona_result)
table(TestUnique$corona_result)


write.csv(EgitimUnique, "eksikleri_silindi_egitim_dengesiz.csv")
write.csv(TestUnique, "eksikleri_silindi_test.csv")
