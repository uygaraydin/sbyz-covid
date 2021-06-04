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
