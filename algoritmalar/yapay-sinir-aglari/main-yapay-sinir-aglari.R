# train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train$X = NULL
test$X = NULL

summary(train)
summary(test)

train$test_indication = as.character(train$test_indication)
train$age_60_and_above = as.character(train$age_60_and_above)
train$gender = as.character(train$gender)
train$corona_result = as.character(train$corona_result)


test$test_indication = as.character(test$test_indication)
test$age_60_and_above = as.character(test$age_60_and_above)
test$gender = as.character(test$gender)
test$corona_result = as.character(test$corona_result)

train$age_60_and_above <-  ifelse(train$age_60_and_above == "Yes",1,0)
train$gender <-  ifelse(train$gender == "female",1,0)
train$test_indication <-  ifelse(train$test_indication == "Contact with confirmed",1,ifelse(train$test_indication == "Abroad",2,3))
train$corona_result <-  ifelse(train$corona_result == "positive",1,0)


test$age_60_and_above <-  ifelse(test$age_60_and_above == "Yes",1,0)
test$gender <-  ifelse(test$gender == "female",1,0)
test$test_indication <-  ifelse(test$test_indication == "Contact with confirmed",1,ifelse(test$test_indication == "Abroad",2,3))
test$corona_result <-  ifelse(test$corona_result == "positive",1,0)




# train$test_indication = as.double(train$test_indication)
# 
# summary(train)
# test$test_indication = as.double(test$test_indication)
# summary(test)



# m <- model.matrix( 
#   ~ corona_result+ cough+fever+sore_throat +shortness_of_breath+head_ache+age_60_and_above+gender+test_indication, 
#   data = train 
# )
# 
# testttt <- model.matrix( 
#   ~ corona_result+ cough+fever+sore_throat +shortness_of_breath+head_ache+age_60_and_above+gender+test_indication, 
#   data = test 
# )

train$corona_result =as.numeric(train$corona_result)
train$age_60_and_above = as.numeric(train$age_60_and_above)
train$gender = as.numeric(train$gender)
train$test_indication = as.numeric(train$test_indication)
train$cough = as.numeric(train$cough)
train$fever = as.numeric(train$fever)
train$sore_throat = as.numeric(train$sore_throat)
train$shortness_of_breath = as.numeric(train$shortness_of_breath)
train$head_ache = as.numeric(train$head_ache)

test$corona_result = as.numeric(test$corona_result)
test$age_60_and_above = as.numeric(test$age_60_and_above)
test$gender = as.numeric(test$gender)
test$test_indication = as.numeric(test$test_indication)
test$cough = as.numeric(test$cough)
test$fever = as.numeric(test$fever)
test$sore_throat = as.numeric(test$sore_throat)
test$shortness_of_breath = as.numeric(test$shortness_of_breath)
test$head_ache = as.numeric(test$head_ache)

#sigmoid function
sigmoid = function(x) {
  1 / (1 + exp(-x))
}



# colnames(m)
library(neuralnet)


nn = NULL
nn <- neuralnet(corona_result~cough+fever+sore_throat+shortness_of_breath+head_ache+age_60_and_above+gender+test_indication,
                linear.output = FALSE,
                hidden = 3,
                err.fct = "ce",
                learningrate = 0.01,
                algorithm = "backprop",
                act.fct = sigmoid,
                stepmax=1e6
)

plot(nn)
Predict=compute(nn,test[1:8])
Predict$net.result
summary(Predict)


pred <- ifelse(Predict$net.result>0.5, 1, 0)
pred
# 
# results <- data.frame(actual = test$corona_result, prediction = pred)
# results

library(caret)
t <- table(pred,test$corona_result)  
confusionMatrix(t, positive = "1")

# tahminler <- NULL
# tahminler <- neuralnet::compute (x =   covid.net,
#                                  covariate =  testttt, rep = 1 )$net.result
# 
# table(tahminler)
# kategorik_tahmin <- NULL
# for (i in 1:nrow(tahminler)) {
#   if ((tahminler[i,]) >= 0.35) kategorik_tahmin[i] <- "positive" else kategorik_tahmin[i] <- "negative"
# }
#covid.prediction <- predict(covid.net, test[1:8],type = "class")

library(caret) 
confusionMatrix(table(Predict, test$corona_result),mode="everything",positive ="positive")

library(pROC)
Logcl_rocAll=roc(test[,9]~Predict)
print(Logcl_rocAll) #AUC
plot(Logcl_rocAll,main="Dengele silinmis") 

