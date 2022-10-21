#############################################################
# 匯入資料 / Importing data sets                            #
#############################################################

id_train <- "1DwFMWPlof3fAZfKvpagyQxonF-MaszFr" # google file ID
titanic_train <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id_train))
id_test <- "1cyGKKatzrcmRgWlw2gdCudomZapqdIbB" # google file ID
titanic_test <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id_test))

#############################################################
# 建立隨機森林 / Building random forest model               #
#############################################################

# 將 Age 遺漏值以 median 填補 / Fill the void of the column "Age" with median
age_median_train <- median(titanic_train$Age, na.rm = TRUE)
new_Age_train <- ifelse(is.na(titanic_train$Age), age_median_train, titanic_train$Age)
titanic_train$Age <- new_Age_train

age_median_test <- median(titanic_test$Age, na.rm = TRUE)
new_Age_test <- ifelse(is.na(titanic_test$Age), age_median_test, titanic_test$Age)
titanic_test$Age <- new_Age_test

# 創造 dummy variables / Create dummy variables for the column "Sex"
titanic_train_sex <- ifelse(titanic_train$Sex == "male", 1, 0)
titanic_test_sex <- ifelse(titanic_test$Sex == "male", 1, 0)

# 建立 x_train & x_val & x_test / Creating training set, validation set, and test set of X
df1 <- data.frame(titanic_train$Pclass, titanic_train$Age, titanic_train_sex, titanic_train$Survived)
df2 <- data.frame(titanic_test$Pclass, titanic_test$Age, titanic_test_sex, titanic_test$Survived)

colnames(df1) <- c("Pclass","Age","Sex","Survived")
colnames(df2) <- c("Pclass","Age","Sex","Survived")

N = as.numeric(nrow(df1))
N1 = round(as.numeric(4 * N / 5)) # 切分為4：1
# Divide df3 into two sets using a ratio of 4:1, 4 being the training set and 1 being the validation set
x_train = df1[1:N1, 1:3]
x_val = df1[N1:N, 1:3]
x_test = df2[, 1:3]

# 建立 train_Y & valid_Y &test_Y / Creating training set, validation set, and test set of Y
y_train = df1[1:N1, 4]
y_val = df1[N1:N, 4]
y_test = df2[, 4]

# 標準化 (結果與PY有些微相異) / Regularization (Differs from python results by a little)
x_train_std = data.frame(scale(x_train))
x_val_std = data.frame(scale(x_val))
x_test_std = data.frame(scale(x_test))

# 建立模型 / Building the model
install.packages('randomForest')
library(randomForest)
y_train <- as.character(y_train)
y_train <- as.factor(y_train)
forest_fit_train <- randomForest(y_train ~ Pclass + Age + Sex, data = x_train_std, n_tree = 100)

summary(forest_fit_train)
                 
# 對validation做預測 / Score the model using the validation set
install.packages("caret")
library(caret)
predict_val <- predict(forest_fit_train, x_val_std, type = "response")
confusion_matrix_val <- confusionMatrix(as.factor(y_val), as.factor(predict_val),
                                        mode = "everything")
confusion_matrix_val

# 這邊可以用迴圈調整參數：n_tree樹的數量 & Z值。
# 利用迴圈調整參數對val不斷跑分，找出理想模型
# Use loop to adjust the parameter n_tree and Z to find the best model (scoring each model with the validation set)


#再對test做預測 / Score the model using the test set
predict_test <- predict(forest_fit_train, x_test_std, type = "response")
confusion_matrix_test <- confusionMatrix(as.factor(predict_test), as.factor(y_test),
                                         mode = "everything")
confusion_matrix_test

#############################################################
# 隨機森林績效 / Evaluation                                 #
#############################################################
# AUC績效 / AUC Evaluation
install.packages("ROCR")
library(ROCR)
predicted_prob <- predict(forest_fit_train, x_test_std, type = "prob")
pred <- prediction(predicted_prob[, "1"], labels = y_test)

perf <- performance(pred, "auc")
auc <- perf@y.values[[1]]
auc

if(auc==1.0){
  "完美分類器 / Perfect"
} else if(auc < 1.0 & auc >= 0.85){
  "效果很好 / Good"
} else if(auc < 0.85 & auc >= 0.70){
  "效果一般 / Normal"
} else if(auc < 0.70 & auc >= 0.50){
  "效果較低 / Low"
} else if(auc == 0.50){
  "沒有預測價值 / No value"
} else{
  "請進行反預測/ Please act oppositely to the prediction!"
}

# 計算準確率 & 召回率 / Print accuracy and recall rate
confusion_matrix_test
