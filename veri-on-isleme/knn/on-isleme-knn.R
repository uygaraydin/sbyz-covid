#install.packages("googledrive")
#install.packages("dplyr")
library(googledrive)
library(dplyr)
drive_deauth()
temp = tempfile(fileext = ".csv")
fileFromDrive = drive_download(as_id("1GKcJ1sVfPN3QabDDvVs7fGHKUm1MOmP2"), path = temp, overwrite = TRUE)

cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)


ek <- c(319946,0,0,0,0,0,"negative",NA,NA,"Abroad")
cleanedDataFile <-rbind(cleanedDataFile,ek)
tail(cleanedDataFile)

# Eksikleri knn kullanarak doldurmak:
#install.packages("DMwR2") 
library(DMwR2) 
cleanedDataFile <- knnImputation(cleanedDataFile, k=5) 
summary(cleanedDataFile)

nrow(cleanedDataFile[duplicated(cleanedDataFile)==TRUE,]) 

write.csv(cleanedDataFile, "temizlenmis-knn_ile_doldurulmus_dengesiz.csv", row.names = TRUE)




#SMOTE sampling
library(ROSE) 

over_norws <-nrow(cleanedDataFile[cleanedDataFile$corona_result=="positive",])*2
DengliData <- cleanedDataFile
DengliData<-DengliData[,-1]

DengliData <- ovun.sample(corona_result ~ ., data = DengliData, method="over",N=over_norws)$data


summary(DengliData)
str(DengliData)

table(DengliData$corona_result)

head(DengliData)
head(cleanedDataFile)
write.csv(DengliData, "temizlenmis-knn_ile_doldurulmus_dengeli.csv", row.names = TRUE)
