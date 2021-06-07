# train.lc1 = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

#train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
#test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

# train.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test.lc1 = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

summary(train.lc1)
summary(test.lc1)

train.lc1$X = NULL
test.lc1$X = NULL
# 
# train[train$corona_result=="negative", "corona_result"] < - 0
# train[train$corona_result=="positive", "corona_result"] < - 1
# 
# test[test$corona_result=="negative", "corona_result"] < - 0
# test[test$corona_result=="positive", "corona_result"] < - 1

#install.packages("plyr")
library(plyr)

train.lc1$corona_result <- revalue(train.lc1$corona_result, c("negative" = "0", "positive" = "1") )
test.lc1$corona_result <- revalue(test.lc1$corona_result, c("negative" = "0", "positive" = "1") )

#install.packages("e1071")
library(e1071)  

set.seed(1)
normal_classifier = glm(formula = corona_result ~ ., family = binomial, data = train.lc1)
normal_probability_predict = predict(normal_classifier, type = 'response', newdata = test.lc1[-9])
Logcl_tahminiSiniflar = ifelse(normal_probability_predict>0.5, 1, 0)

library(caret)
confusionMatrix(table(test.lc1[, 9], Logcl_tahminiSiniflar),mode = "everything", positive = "1")

nrow(is.na(test.lc1[,9])=="TRUE") 

# Roc curve
#install.packages("ROSE")
library(ROSE) 
# Logcl_rocAll <- roc.curve(test.lc1[,9], Logcl_tahminiSiniflar, plotit = TRUE,main="LC ROC - Sampling Olmadan")
# print(Logcl_rocAll)

#install.packages("pROC")
library(pROC)
Logcl_rocAll=roc(test.lc1[,9]~normal_probability_predict)
print(Logcl_rocAll)
plot(Logcl_rocAll,main="LC for dengesiz veri doldurma")

