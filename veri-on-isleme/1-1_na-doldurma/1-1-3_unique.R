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

# Eksikleri knn kullanarak doldurmak:
#install.packages("DMwR2") 

library(DMwR2) 
uni_data <- knnImputation(uni_data, k=10) 
summary(uni_data)

nrow(uni_data[duplicated(uni_data)==TRUE,]) 
uni_data <- uni_data[!duplicated(uni_data),]

#cleanedDataFile<-cleanedDataFile[,-1]



# install.packages("caret") 
library(caret) 
set.seed(10) 

egitimIndisleri <- createDataPartition(y = uni_data$corona_result, p = .70, list = FALSE)  

EgitimUnique <- uni_data[egitimIndisleri,] 
TestUnique <- uni_data[-egitimIndisleri,] 
table(EgitimUnique$corona_result)
table(TestUnique$corona_result)
nrow(EgitimUnique)
nrow(unique(EgitimUnique))
nrow(unique(TestUnique))

write.csv(EgitimDengesiz, "knn_doldurulmus_unique_egitim_.csv")
write.csv(TestDengesiz, "knn_doldurulmus_unique_test.csv")
