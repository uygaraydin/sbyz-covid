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

# Dengeli SVM Model
library(e1071)
dengeli_SVM <- svm(corona_result~.,data = train)

SVM_tahminleri <- predict(dengeli_SVM, test[,1:8])
(SVM_tablom <- table(SVM_tahminleri, test[[9]], dnn = c("Tahmini Siniflar", "Gercek Siniflar")))

matSVM_dengeli<-confusionMatrix(data = SVM_tahminleri, reference = test[[9]], mode = "everything" )
matSVM_dengeli

# Dengesiz SVM Model
library(e1071)
dengesiz_SVM <- svm(corona_result~.,data = train)

SVM_tahminleri <- predict(dengesiz_SVM, test[,1:8])
(SVM_tablom <- table(SVM_tahminleri, test[[9]], dnn = c("Tahmini Siniflar", "Gercek Siniflar")))

matSVM_dengesiz<-confusionMatrix(data = SVM_tahminleri, reference = test[[9]], mode = "everything" )
matSVM_dengesiz

# Unique SVM Model
library(e1071)
unique_SVM <- svm(corona_result~.,data = train)

SVM_tahminleri <- predict(unique_SVM, test[,1:8])
(SVM_tablom <- table(SVM_tahminleri, test[[9]], dnn = c("Tahmini Siniflar", "Gercek Siniflar")))

matSVM_unique<-confusionMatrix(data = SVM_tahminleri, reference = test[[9]], mode = "everything" )
matSVM_unique