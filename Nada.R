## first R file
## Nada'nin yazdiklari

data <- read.csv("corona_tested_individuals_ver_0083.english.csv")
summary(data)

#data after removing NA's from (Age, gender and corona result)
data1<- data[data$corona_result!="other",] 
data1<- data1[data1$age_60_and_above!="",]
data1<- data1[data1$gender!="",]
#test 

#Categorizing
data1$cough <- as.factor(data1$cough)
data1$fever <- as.factor(data1$fever)
data1$sore_throat <- as.factor(data1$sore_throat)
data1$shortness_of_breath <- as.factor(data1$shortness_of_breath)
data1$head_ache <- as.factor(data1$head_ache)
data1$corona_result <- as.factor(data1$corona_result)
data1$age_60_and_above <- as.factor(data1$age_60_and_above)
data1$gender <- as.factor(data1$gender)
data1$test_indication <- as.factor(data1$test_indication)
data1$test_date <- as.Date(data1$test_date)

summary(data1)
nu1<-nrow(unique(data1))

#removing duplicates
uni_data <- data1[!duplicated(data1),]

