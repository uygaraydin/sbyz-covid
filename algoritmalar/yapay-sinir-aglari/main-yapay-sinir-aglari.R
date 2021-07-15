
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

# train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# 
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

summary(train)
# colnames(m)
library(neuralnet)


nn = NULL
set.seed(10)
nn <- neuralnet(corona_result~cough+fever+sore_throat+shortness_of_breath+head_ache+age_60_and_above+gender+test_indication,
                data=train,
                algorithm = "backprop",
                # learningrate=0.001,
                # linear.output = FALSE,
                hidden = 5,
                act.fct = "logistic",
                stepmax=1e6
)

#plot(nn)
Predict=NULL
set.seed(10)
Predict=compute(nn,test[1:8])
#Predict$net.result
summary(Predict)

pred <- ifelse(Predict$net.result>0.5, 1, 0)

library(caret)
t <- table(pred,test$corona_result)  
confusionMatrix(t, mode="everything", positive = "1")
table(test$corona_result)
table(pred)

library(pROC)
Logcl_rocAll=roc(test$corona_result~pred)
print(Logcl_rocAll) #AUC
plot(Logcl_rocAll) 

