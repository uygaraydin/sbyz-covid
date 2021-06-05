train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train$X = NULL
test$X = NULL

train$corona_result = as.factor(train$corona_result)
train$age_60_and_above = as.factor(train$age_60_and_above)
train$gender = as.factor(train$gender)
train$test_indication = as.factor(train$test_indication)
train$cough = as.factor(train$cough)
train$fever = as.factor(train$fever)
train$sore_throat = as.factor(train$sore_throat)
train$shortness_of_breath = as.factor(train$shortness_of_breath)
train$head_ache = as.factor(train$head_ache)

test$corona_result = as.factor(test$corona_result)
test$age_60_and_above = as.factor(test$age_60_and_above)
test$gender = as.factor(test$gender)
test$test_indication = as.factor(test$test_indication)
test$cough = as.factor(test$cough)
test$fever = as.factor(test$fever)
test$sore_throat = as.factor(test$sore_throat)
test$shortness_of_breath = as.factor(test$shortness_of_breath)
test$head_ache = as.factor(test$head_ache)


# veriDosyasi <- "heart.csv"
# kalp <- read.csv(veriDosyasi, header = TRUE, sep=",", stringsAsFactors = TRUE)
# 
# summary(kalp)
# 
# # Hedef nitelik factor veri tipine donusturulur (factor R dilindeki kategorik degiskenler icin kullanilir)
# kalp$output <- as.factor(kalp$output)
# 
# # Hedef niteligin kategorileri
# levels(kalp$output)
# 
# # Hedef niteligin frekans degerleri
# table(kalp$output)
# 
# #"0" dusuk kalp krizi riski "1" yuksek kalp krizi riski
# 
# #Hedef nitelikteki kategorileri yeniden adlandirma install.packages("plyr") Eger bilgisayarda plyr paketi yuklu degilse, bu kod yard?m? ile yuklenir
# library(plyr) # Calisma icinden paket cagirilir
# kalp$output <- revalue(kalp$output, c("0"="Dusuk", "1"="Yuksek"))
# summary(kalp)
# 
# 
# colnames(kalp)[3] <- "chest pain type" # Sutun adi degistirme
# colnames(kalp)[4] <- "resting blood pressure" # Sutun adi degistirme
# colnames(kalp)[5] <- "cholestoral" # Sutun adi degistirme
# colnames(kalp)[6] <- "fasting blood sugar" # Sutun adi degistirme
# colnames(kalp)[7] <- "resting ECG" # Sutun adi degistirme
# colnames(kalp)[8] <- "max heart rate" # Sutun adi degistirme
# colnames(kalp)[9] <- "exercise induced angina" # Sutun adi degistirme
# # str(kalp)
# 
# #install.packages("dplyr")
# library(dplyr)
# kalp <- kalp %>% select(sex, `chest pain type`,`fasting blood sugar`,`resting ECG`,`exercise induced angina`, output)
# 
# kalp$sex <- as.factor(kalp$sex)
# kalp$`chest pain type` <- as.factor(kalp$`chest pain type`)
# kalp$`fasting blood sugar` <- as.factor(kalp$`fasting blood sugar`)
# kalp$`resting ECG` <- as.factor(kalp$`resting ECG`)
# kalp$`exercise induced angina` <- as.factor(kalp$`exercise induced angina`)
# 
# kalp$`chest pain type` <- revalue(kalp$`chest pain type`, c("0" = "typical", "1" = "atypical", "2" = "non-anginal", "3" = "asymptomatic"))
# kalp$sex <- revalue(kalp$sex, c("0" = "female", "1" = "male"))
# kalp$`fasting blood sugar` <- revalue(kalp$`fasting blood sugar`, c("0" = "false", "1" = "true"))
# kalp$`resting ECG` <- revalue(kalp$`resting ECG`, c("0" = "normal", "1" = "stt", "2" = "hypertrophy"))
# kalp$`exercise induced angina` <- revalue(kalp$`exercise induced angina`, c("0" = "no", "1" = "yes"))
# summary(kalp)


#latest R version
#install.packages("installr")
#library(installr)
#updateR()

#applying CHAID
#install.packages("CHAID", repos="http://R-Forge.R-project.org")
library("CHAID")
#install.packages("mvtnorm")
library(mvtnorm)
library(caret)

# set.seed(1)
# trainIndex=createDataPartition(kalp$output, p=0.7, list = FALSE)
# train=kalp[trainIndex, ]
# test=kalp[-trainIndex, ]

control <- chaid_control(minbucket = 1000, maxheight = 5)
model <- chaid(corona_result~ .,
               data = train,
               control = control)


#plotting CHAID output
plot(model)
#plot(model, type="simple")


########## to test the model #########
testPred=predict(model, newdata=test)
#install.packages("gmodels")
library(gmodels)
message("Test Datasinin Matrisi")
CrossTable(testPred, test$corona_result, prop.chisq = FALSE, chisq = FALSE, 
           prop.t = FALSE,
           dnn = c("Predicted", "Actual"))

confusionMatrix(data = testPred, reference = test$corona_result, mode = "everything", positive = "positive")

# 
# ########## to predict a observation #########
# newData = data.frame(sex = "female", `chest pain type` ="non-anginal", `fasting blood sugar` = "false", `resting ECG`="normal", `exercise induced angina` = "yes", check.names = FALSE)
# newPred=predict(model, newdata=newData)
# newTable=table(newPred)
# newTable
# 
# #install.packages("FSelector")
# library(FSelector)
# weights <- information.gain(output~., kalp)
# weights