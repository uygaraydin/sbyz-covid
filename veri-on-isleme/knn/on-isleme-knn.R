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

ek <- c(0,0,0,0,0,"negative",NA,NA,"Abroad")
cleanedDataFile <-rbind(cleanedDataFile,ek)
tail(cleanedDataFile)

# Eksikleri knn kullanarak doldurmak:
#install.packages("DMwR2") 
library(DMwR2) 
cleanedDataFile <- knnImputation(cleanedDataFile, k=3) 
summary(cleanedDataFile)

nrow(cleanedDataFile[duplicated(cleanedDataFile)==TRUE,]) 
VS <- cleanedDataFile[!duplicated(cleanedDataFile),] 


# install.packages("caret") 
library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = cleanedDataFile$corona_result, p = .70, list = FALSE)  

EgitimDengesiz <- cleanedDataFile[egitimIndisleri,] 
TestDengesiz <- cleanedDataFile[-egitimIndisleri,] 
table(EgitimDengesiz$corona_result)
table(TestDengesiz$corona_result)



write.csv(EgitimDengesiz, "knn_doldurulmus_egitim_dengesiz.csv")
write.csv(TestDengesiz, "knn_doldurulmus_test.csv")

#OverSampling
library(ROSE) 


over_norws <-nrow(EgitimDengesiz[EgitimDengesiz$corona_result=="positive",])*2
EgitimDengli <- EgitimDengesiz

EgitimDengli <- ovun.sample(corona_result ~ ., data = EgitimDengli, method="over",N=over_norws)$data


summary(EgitimDengli)
str(EgitimDengli)

table(EgitimDengli$corona_result)

head(EgitimDengli)
write.csv(EgitimDengli, "knn_doldurulmus_egitim_dengeli.csv")
