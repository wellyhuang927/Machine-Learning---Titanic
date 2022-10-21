#############################################################
# �פJ��� / Importing data sets                            #
#############################################################

id_train <- "1DwFMWPlof3fAZfKvpagyQxonF-MaszFr" # google file ID
titanic_train <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id_train))
id_test <- "1cyGKKatzrcmRgWlw2gdCudomZapqdIbB" # google file ID
titanic_test <- read.csv(sprintf("https://docs.google.com/uc?id=%s&export=download", id_test))

#############################################################
# �إ��H���˪L / Building random forest model               #
#############################################################

# �N Age ��|�ȥH median ��� / Fill the void of the column "Age" with median
age_median_train <- median(titanic_train$Age, na.rm = TRUE)
new_Age_train <- ifelse(is.na(titanic_train$Age), age_median_train, titanic_train$Age)
titanic_train$Age <- new_Age_train

age_median_test <- median(titanic_test$Age, na.rm = TRUE)
new_Age_test <- ifelse(is.na(titanic_test$Age), age_median_test, titanic_test$Age)
titanic_test$Age <- new_Age_test

# �гy dummy variables / Create dummy variables for the column "Sex"
titanic_train_sex <- ifelse(titanic_train$Sex == "male", 1, 0)
titanic_test_sex <- ifelse(titanic_test$Sex == "male", 1, 0)

# �إ� x_train & x_val & x_test / Creating training set, validation set, and test set of X
df1 <- data.frame(titanic_train$Pclass, titanic_train$Age, titanic_train_sex, titanic_train$Survived)
df2 <- data.frame(titanic_test$Pclass, titanic_test$Age, titanic_test_sex, titanic_test$Survived)

colnames(df1) <- c("Pclass","Age","Sex","Survived")
colnames(df2) <- c("Pclass","Age","Sex","Survived")

N = as.numeric(nrow(df1))
N1 = round(as.numeric(4 * N / 5)) # ������4�G1
# Divide df3 into two sets using a ratio of 4:1, 4 being the training set and 1 being the validation set
x_train = df1[1:N1, 1:3]
x_val = df1[N1:N, 1:3]
x_test = df2[, 1:3]

# �إ� train_Y & valid_Y &test_Y / Creating training set, validation set, and test set of Y
y_train = df1[1:N1, 4]
y_val = df1[N1:N, 4]
y_test = df2[, 4]

# �зǤ� (���G�PPY���ǷL�۲�) / Regularization (Differs from python results by a little)
x_train_std = data.frame(scale(x_train))
x_val_std = data.frame(scale(x_val))
x_test_std = data.frame(scale(x_test))

# �إ߼ҫ� / Building the model
install.packages('randomForest')
library(randomForest)
y_train <- as.character(y_train)
y_train <- as.factor(y_train)
forest_fit_train <- randomForest(y_train ~ Pclass + Age + Sex, data = x_train_std, n_tree = 100)

summary(forest_fit_train)
                 
# ��validation���w�� / Score the model using the validation set
install.packages("caret")
library(caret)
predict_val <- predict(forest_fit_train, x_val_std, type = "response")
confusion_matrix_val <- confusionMatrix(as.factor(y_val), as.factor(predict_val),
                                        mode = "everything")
confusion_matrix_val

# �o��i�H�ΰj��վ�ѼơGn_tree�𪺼ƶq & Z�ȡC
# �Q�ΰj��վ�Ѽƹ�val���_�]���A��X�z�Q�ҫ�
# Use loop to adjust the parameter n_tree and Z to find the best model (scoring each model with the validation set)


#�A��test���w�� / Score the model using the test set
predict_test <- predict(forest_fit_train, x_test_std, type = "response")
confusion_matrix_test <- confusionMatrix(as.factor(predict_test), as.factor(y_test),
                                         mode = "everything")
confusion_matrix_test

#############################################################
# �H���˪L�Z�� / Evaluation                                 #
#############################################################
# AUC�Z�� / AUC Evaluation
install.packages("ROCR")
library(ROCR)
predicted_prob <- predict(forest_fit_train, x_test_std, type = "prob")
pred <- prediction(predicted_prob[, "1"], labels = y_test)

perf <- performance(pred, "auc")
auc <- perf@y.values[[1]]
auc

if(auc==1.0){
  "���������� / Perfect"
} else if(auc < 1.0 & auc >= 0.85){
  "�ĪG�ܦn / Good"
} else if(auc < 0.85 & auc >= 0.70){
  "�ĪG�@�� / Normal"
} else if(auc < 0.70 & auc >= 0.50){
  "�ĪG���C / Low"
} else if(auc == 0.50){
  "�S���w������ / No value"
} else{
  "�жi��Ϲw��/ Please act oppositely to the prediction!"
}

# �p��ǽT�v & �l�^�v / Print accuracy and recall rate
confusion_matrix_test