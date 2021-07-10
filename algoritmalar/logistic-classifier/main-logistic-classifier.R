
# train = read.csv(file = "./Veri -on-isleme -2/1_na_silme/1-silinmis_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./Veri -on-isleme -2/1_na_silme/1-silinmis_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
# train = read.csv(file = "./Veri -on-isleme -2/2_na_doldurma/2_1_tekrar_silme/doldurulmus_1_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./Veri -on-isleme -2/2_na_doldurma/2_1_tekrar_silme/doldurulmus_1_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
# train = read.csv(file = "./Veri -on-isleme -2/2_na_doldurma/2_2_tekrar_testten_silme/doldurulmus_2_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./Veri -on-isleme -2/2_na_doldurma/2_2_tekrar_testten_silme/doldurulmus_2_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 

#############################################################################################################################################################################




# train.lc1 = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

#train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
#test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train)
summary(test)

train$X = NULL
test$X = NULL
# 
# train[train$corona_result=="negative", "corona_result"] < - 0
# train[train$corona_result=="positive", "corona_result"] < - 1
# 
# test[test$corona_result=="negative", "corona_result"] < - 0
# test[test$corona_result=="positive", "corona_result"] < - 1

#install.packages("plyr")
library(plyr)

train$corona_result <- revalue(train$corona_result, c("negative" = "0", "positive" = "1") )
test$corona_result <- revalue(test$corona_result, c("negative" = "0", "positive" = "1") )

#install.packages("e1071")
library(e1071)  

set.seed(1)
normal_classifier = glm(formula = corona_result ~ ., family = binomial, data = train)
normal_probability_predict = predict(normal_classifier, type = 'response', newdata = test[-9])
Logcl_tahminiSiniflar = ifelse(normal_probability_predict>0.5, 1, 0)

library(caret)
confusionMatrix(table(test[, 9], Logcl_tahminiSiniflar),mode = "everything", positive = "1")

nrow(is.na(test[,9])=="TRUE") 

# Roc curve
#install.packages("ROSE")
library(ROSE) 
# Logcl_rocAll <- roc.curve(test[,9], Logcl_tahminiSiniflar, plotit = TRUE,main="LC ROC - Sampling Olmadan")
# print(Logcl_rocAll)

#install.packages("pROC")
library(pROC)
Logcl_rocAll=roc(test[,9]~normal_probability_predict)
print(Logcl_rocAll)
plot(Logcl_rocAll,main="LC for dengesiz veri doldurma")

