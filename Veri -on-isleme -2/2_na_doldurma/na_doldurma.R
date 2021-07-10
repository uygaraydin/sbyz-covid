
doldurmak = read.csv("./Veri -on-isleme -2/TekrarOlmadan_tam.csv",header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(doldurmak)
doldurmak$X=NULL


#Eksikleri doldurmak
#install.packages("mice")
library(mice)
imputed_Data<-mice(data = doldurmak, m = 3, method = "logreg", maxit = 5, seed = 500)

completeData <- complete(imputed_Data,3)
summary(completeData)


#eksikleri doldurduktan sonra tekrar gozlem kontrol etmek
nrow(completeData[duplicated(completeData)==TRUE,]) 
#number of duplicates is 515.


#1. yontem: tekrar gozlem tum verisetinden yeniden silmek - df1
#2. yontem tekrak gozlem sadece test setinden silmek - df2


df1=completeData[!duplicated(completeData)==TRUE,]
summary(df1)


library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = df1$corona_result, p = .70, list = FALSE)  

doldurulmus_1_Egitim <- df1[egitimIndisleri,] 
doldurulmus_1_Test <- df1[-egitimIndisleri,] 

nrow(doldurulmus_1_Egitim[duplicated(doldurulmus_1_Egitim)==TRUE,])
nrow(doldurulmus_1_Test[duplicated(doldurulmus_1_Test)==TRUE,])
summary(doldurulmus_1_Egitim)
summary(doldurulmus_1_Test)


write.csv(doldurulmus_1_Egitim, "./Veri -on-isleme -2/2_na_doldurma/2_1_tekrar_silme/doldurulmus_1_egitim.csv")
write.csv(doldurulmus_1_Test, "./Veri -on-isleme -2/2_na_doldurma/2_1_tekrar_silme/doldurulmus_1_test.csv")


#2. yontem

df2= completeData

library(caret) 
set.seed(10) 
egitimIndisleri2 <- createDataPartition(y = df2$corona_result, p = .70, list = FALSE)

doldurulmus_2_Egitim <- df2[egitimIndisleri2,] 
doldurulmus_2_Test <- df2[-egitimIndisleri2,] 

nrow(doldurulmus_2_Egitim[duplicated(doldurulmus_2_Egitim)==TRUE,])
nrow(doldurulmus_2_Test[duplicated(doldurulmus_2_Test)==TRUE,])
summary(doldurulmus_2_Egitim)
summary(doldurulmus_2_Test)

#Tekrar gozlem test setinden silmek
doldurulmus_2_Test<-doldurulmus_2_Test[!duplicated(doldurulmus_2_Test)==TRUE,]



write.csv(doldurulmus_2_Egitim, "./Veri -on-isleme -2/2_na_doldurma/2_2_tekrar_testten_silme/doldurulmus_2_egitim.csv")
write.csv(doldurulmus_2_Test, "./Veri -on-isleme -2/2_na_doldurma/2_2_tekrar_testten_silme/doldurulmus_2_test.csv")
