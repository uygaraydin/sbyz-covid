#train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
#test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

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


# Applying C4.5 Algorithm
#install.packages("RWeka")
library(RWeka)
C45_model <- J48(corona_result ~ ., data=train)
#C45_model2 <- J48(CreditStatus ~., data=training, control =Weka_control(R = F, M = 10))
print(summary(C45_model))
print(C45_model)

#install.packages("party")
#install.packages("partykit")
library("party")
library("partykit")
library("caret")
plot(C45_model)
# Finding Predictions of The Model
C45_predictions <- predict(C45_model, newdata = test)
# Performance Evaluation
confusionMatrix(data = C45_predictions, reference = test$corona_result, dnn =
                  c("Predictions", "Actual/Reference"), mode = "everything", positive = "positive")

library(e1071)
install.packages("ROSE")
library(ROSE) 
RF_RocAll <- roc.curve(test[,9],C45_predictions,plotit=TRUE,main="RF ROC-Karar Ağacı Doldurulmuş Random Dengeleme", col= "red")
print(RF_RocAll)
