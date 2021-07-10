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


#temizlenmis veri setin bilgisayardaki proje klasorune eklendi
#write.csv(dataFile, "genel-temizlik.csv")

nrow(dataFile[duplicated(dataFile)==TRUE,])
df=dataFile
df <- df[!duplicated(df),] 
summary(df)
#veri seti tekrar gözlem olmadan
write.csv(df, "./Veri -on-isleme -2/TekrarOlmadan_tam.csv")
