#############################################################
# �إ߽u�ʰj�k���R�ҫ� / Building LPM                       #
#############################################################

temperatures <- c(29, 28, 34, 31, 25, 29, 32, 31, 24, 33, 25, 31, 26, 30)
iced_tea_sales <- c(77, 62, 93, 84, 59, 64, 80, 75, 58, 91, 51, 73, 65, 84)

lm_fit <- lm(iced_tea_sales ~ temperatures)

# �L�X�Y�� / Print coefficients
lm_fit$coefficients[2]

# �L�X�I�Z / Print intercept
lm_fit$coefficients[1]

#############################################################
# �Q�νu�ʰj�k���R�ҫ��w�� / Predict using LPM              #
#############################################################

# �s����� / New temperature
to_be_predicted <- data.frame(temperatures = 30)
predicted_sales <- predict(lm_fit, newdata = to_be_predicted)

# �w�����B�����P�q / Predicted iced tea sales
predicted_sales

#############################################################
# �u�ʰj�k��ı�� / Visualization                            #
#############################################################

plot(iced_tea_sales ~ temperatures, bg = "blue", pch = 16)
points(x = to_be_predicted$temperatures, y = predicted_sales, col = "red", cex = 2, pch = 17)
abline(reg = lm_fit$coefficients, col = "blue", lwd = 4)

#############################################################
# �u�ʰj�k�ҫ����Z��                                        #
#  Evaluation (mse, r^2, and adjusted r^2)                  #
#############################################################
temperatures <- c(29, 28, 34, 31, 25, 29, 32, 31, 24, 33, 25, 31, 26, 30)
iced_tea_sales <- c(77, 62, 93, 84, 59, 64, 80, 75, 58, 91, 51, 73, 65, 84)

lm_fit <- lm(iced_tea_sales ~ temperatures)
predicted_sales <- predict(lm_fit, newdata = data.frame(temperatures))

# �ҫ��Z�� / Evaluation
mse <- sum(lm_fit$residuals^2)/(length(temperatures)-2)

# �L�X�ҫ��Z�� / Print evaluation
mse
round(summary(lm_fit)$r.squared, 6)
round(summary(lm_fit)$adj.r.squared, 6)

#############################################################
# �u�ʰj�k�ҫ����Y���˩w / Evaluation (testing coefficients)#
#############################################################
summary(lm_fit)
