
### Temizlenmis veri setinin cagirilmasi 
########################################

#install.packages("googledrive")
#install.packages("dplyr")
library(googledrive)
library(dplyr)
drive_deauth()
temp = tempfile(fileext = ".csv")
fileFromDrive = drive_download(as_id("1GKcJ1sVfPN3QabDDvVs7fGHKUm1MOmP2"), path = temp, overwrite = TRUE)

cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(cleanedDataFile)

ek <- c(319946,0,0,0,0,0,"negative","Yes","female","Abroad")
ek1 <- c(319947,0,0,0,0,0,"negative","Yes","male","Abroad")
ek2 <- c(319948,0,0,0,0,0,"negative","No","female","Abroad")
ek3 <- c(319949,0,0,0,0,0,"negative","No","male","Abroad")

cleanedDataFile <-rbind(cleanedDataFile,ek,ek1,ek2,ek3)
tail(cleanedDataFile)

### Eksiklerin silinmesi
########################

summary(cleanedDataFile)
cleanedDataFile = filter(cleanedDataFile, age_60_and_above != "NA")
cleanedDataFile = filter(cleanedDataFile, gender != "NA")
cleanedDataFile<-cleanedDataFile[,-1]
nrow(cleanedDataFile[duplicated(cleanedDataFile)==TRUE,]) 
#write.csv(cleanedDataFile, "ekstra-temizlenmis-veri-seti.csv", row.names = TRUE)


#Hold Out

library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = cleanedDataFile$Class, p = .70, list = FALSE)  

EgitimDengesiz <- cleanedDataFile[egitimIndisleri,] 
TestDengesiz <- cleanedDataFile[-egitimIndisleri,] 
table(EgitimDengesiz$corona_result)
table(TestDengesiz$corona_result)



write.csv(EgitimDengesiz, "eksikleri_silindi_egitim_dengesiz.csv")
write.csv(TestDengesiz, "eksikleri_silindi_test.csv")



### OverSampling
################



library(ROSE) 
over_norws <-nrow(EgitimDengesiz[EgitimDengesiz$corona_result=="positive",])*2
EgitimDengli <- EgitimDengesiz
EgitimDengli <- ovun.sample(corona_result ~ ., data = EgitimDengli, method="over",N=over_norws)$data

summary(EgitimDengli)
str(EgitimDengli)
table(EgitimDengli$corona_result)
write.csv(DengliData, "eksikleri_silindi_egitim_dengeli.csv")
