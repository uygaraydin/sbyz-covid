

df = read.csv("./Veri -on-isleme -2/TekrarOlmadan_tam.csv",header = T, sep = ",", dec = ".", stringsAsFactors = T)
summary(df)
df$X=NULL


df = na.omit(df)
summary(df)



library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = df$corona_result, p = .70, list = FALSE)  

silinmisEgitim <- df[egitimIndisleri,] 
silinmisTest <- df[-egitimIndisleri,] 
table(silinmisEgitim$corona_result)
table(silinmisTest$corona_result)
nrow(silinmisEgitim[duplicated(silinmisEgitim)==TRUE,])
nrow(silinmisTest[duplicated(silinmisTest)==TRUE,])



write.csv(silinmisEgitim, "./Veri -on-isleme -2/1_na_silme/1-silinmis_egitim.csv")
write.csv(silinmisTest, "./Veri -on-isleme -2/1_na_silme/1-silinmis_test.csv")
