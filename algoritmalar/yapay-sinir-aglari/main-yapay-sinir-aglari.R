#train = read.csv(file = "./veri-on-isleme/genel_temizlik_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
#test = read.csv(file = "./veri-on-isleme/genel_temizlik_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
test = read.csv(file = "./veri-on-isleme/1-1_na-doldurma/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/dengesiz_veri_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

# train = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_egitim.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
# test = read.csv(file = "./veri-on-isleme/1-2_na-silme/unique_test.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)

train$X = NULL
test$X = NULL


summary(train)
summary(test)

train$test_indication<-as.character(train$test_indication)
test$test_indication <-as.character(test$test_indication)


train[train$test_indication=="Contact with confirmed", "test_indication"] <-"Contact_with_confirmed"
test[test$test_indication=="Contact with confirmed", "test_indication"] <-"Contact_with_confirmed"


train$age_60_and_above <-  ifelse(train$age_60_and_above == "Yes",1,-1)
train$gender <-  ifelse(train$gender == "female",1,-1)
train[train$test_indication=="Contact with confirmed", "test_indication"] <- 1 
train[train$test_indication=="Abroad", "test_indication"] <- -1
train[train$test_indication=="Other", "test_indication"] <- -0.5
train$test_indication<-as.numeric(train$test_indication)
train$cough<-ifelse(train$cough == 1,1,-1)
train$fever<-ifelse(train$fever == 1,1,-1)
train$sore_throat<-ifelse(train$sore_throat == 1,1,-1)
train$shortness_of_breath<-ifelse(train$shortness_of_breath == 1,1,-1)
train$head_ache<-ifelse(train$head_ache == 1,1,-1)
head(train)





test$age_60_and_above <-  ifelse(test$age_60_and_above == "Yes",1,-1)
test$gender <-  ifelse(test$gender == "female",1,-1)

train[train$test_indication=="Contact with confirmed", "test_indication"] <-"Contact_with_confirmed"

test[test$test_indication=="Abroad", "test_indication"] <- -1
test[test$test_indication=="Other", "test_indication"] <- -0.5 
test$cough<-ifelse(test$cough == 1,1,-1)
test$fever<-ifelse(test$fever == 1,1,-1)
test$sore_throat<-ifelse(test$sore_throat == 1,1,-1)
test$shortness_of_breath<-ifelse(test$shortness_of_breath == 1,1,-1)
test$head_ache<-ifelse(test$head_ache == 1,1,-1)
test$test_indication<-as.numeric(test$test_indication)




summary(train)
summary(test)



train_model <- model.matrix(
  ~ corona_result+ cough+fever+sore_throat +shortness_of_breath+head_ache+age_60_and_above+gender+test_indication,
  data = train
)

test_model <- model.matrix(
  ~ corona_result+ cough+fever+sore_throat +shortness_of_breath+head_ache+age_60_and_above+gender+test_indication,
  data = test
)
colnames(train_model)

train$positive = ifelse(train$corona_result=="positive", 1, 0)
train$negative <- ifelse(train$corona_result=="negative", 1, 0)

#sigmoid function
sigmoid = function(x) {
  1 / (1 + exp(-x))
}

library(neuralnet)

covid.net<-NULL
covid.net <- neuralnet(corona_resultpositive ~cough+fever+sore_throat +shortness_of_breath+head_ache+age_60_and_aboveYes+gendermale+test_indicationContact_with_confirmed+test_indicationOther,
                       data=train_model, 
                       linear.output = FALSE,
                       hidden = c(3),
                       err.fct = "ce",
                       learningrate = 0.01,
                       algorithm = "backprop",
                       act.fct = sigmoid,
                       stepmax=1e6
)

plot(covid.net,rep="best")
colnames(test_model)

tahminler <- NULL
tahminler <- neuralnet::compute (x =   covid.net,
                                 covariate =  test_model, rep = 1 )$net.result


table(tahminler)
library(caret) #confusion matrix icin

kategorik_tahmin <- NULL
for (i in 1:nrow(tahminler)) {
  if ((tahminler[i,]) >= 0.5) kategorik_tahmin[i] <- "positive" else kategorik_tahmin[i] <- "negative"
}

confusionMatrix(table(kategorik_tahmin, test$corona_result),mode="everything",positive ="positive")
