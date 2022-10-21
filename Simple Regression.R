#############################################################
# ミ絬┦癹耴だ猂家 / Building LPM                       #
#############################################################

temperatures <- c(29, 28, 34, 31, 25, 29, 32, 31, 24, 33, 25, 31, 26, 30)
iced_tea_sales <- c(77, 62, 93, 84, 59, 64, 80, 75, 58, 91, 51, 73, 65, 84)

lm_fit <- lm(iced_tea_sales ~ temperatures)

# 玒计 / Print coefficients
lm_fit$coefficients[2]

# 篒禯 / Print intercept
lm_fit$coefficients[1]

#############################################################
# ノ絬┦癹耴だ猂家箇代 / Predict using LPM              #
#############################################################

# 穝放 / New temperature
to_be_predicted <- data.frame(temperatures = 30)
predicted_sales <- predict(lm_fit, newdata = to_be_predicted)

# 箇代綪秖 / Predicted iced tea sales
predicted_sales

#############################################################
# 絬┦癹耴跌谋て / Visualization                            #
#############################################################

plot(iced_tea_sales ~ temperatures, bg = "blue", pch = 16)
points(x = to_be_predicted$temperatures, y = predicted_sales, col = "red", cex = 2, pch = 17)
abline(reg = lm_fit$coefficients, col = "blue", lwd = 4)

#############################################################
# 絬┦癹耴家罿                                        #
#  Evaluation (mse, r^2, and adjusted r^2)                  #
#############################################################
temperatures <- c(29, 28, 34, 31, 25, 29, 32, 31, 24, 33, 25, 31, 26, 30)
iced_tea_sales <- c(77, 62, 93, 84, 59, 64, 80, 75, 58, 91, 51, 73, 65, 84)

lm_fit <- lm(iced_tea_sales ~ temperatures)
predicted_sales <- predict(lm_fit, newdata = data.frame(temperatures))

# 家罿 / Evaluation
mse <- sum(lm_fit$residuals^2)/(length(temperatures)-2)

# 家罿 / Print evaluation
mse
round(summary(lm_fit)$r.squared, 6)
round(summary(lm_fit)$adj.r.squared, 6)

#############################################################
# 絬┦癹耴家玒计浪﹚ / Evaluation (testing coefficients)#
#############################################################
summary(lm_fit)

