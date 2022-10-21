#############################################################
# �إ߽ưj�k���R�ҫ� / Building LPM                         #
#############################################################
store_area <- c(10, 8, 8, 5, 7, 8, 7, 9, 6, 9)
dist_to_station <- c(80, 0, 200, 200, 300, 230, 40, 0, 330, 180)
monthly_sales <- c(469, 366, 371, 208, 246, 297, 363, 436, 198, 364)
bakery_df <- data.frame(store_area, dist_to_station, monthly_sales)

lm_fit <- lm(monthly_sales ~ store_area + dist_to_station)

# �L�X�Y�� / Print coefficients
lm_fit$coefficients[-1]

# �L�X�I�Z / Print intercept
lm_fit$coefficients[1]

#############################################################
# �Q�νưj�k�ҫ��w�� / Predict using LPM                    #
#############################################################

# �s�J�|����� / New cake shop information
to_be_predicted <- data.frame(store_area = 10, dist_to_station = 110)
predicted_sales <- predict(lm_fit, newdata = to_be_predicted)

# �w���s�J�|�������P�q / Predict the monthly sales for the new cake shop
predicted_sales

#############################################################
# �ưj�k�ҫ����Z��                                          #
#  Evaluation (mse, r^2, and adjusted r^2)                  #
#############################################################

predicted_sales <- predict(lm_fit, newdata = data.frame(store_area, dist_to_station))

# �ҫ��Z�� / Evaluation
mse <- sum(lm_fit$residuals^2)/(length(store_area)-3)

# �L�X�ҫ��Z�� / Print evaluation
mse
summary(lm_fit)$r.squared
summary(lm_fit)$adj.r.squared

#############################################################
# �ưj�k�ҫ������Y���˩w / Evaluation (testing coefficients)#
#############################################################

# �L�X p-value / Print p-value
summary(lm_fit)$coefficients[-1, 4]
#�᭱4�O��Pv�����A3�OTv�A2�Ostdev
#The "4" is for p-value, "3" for t-value, "2" for standard deviation
summary(lm_fit)$coefficients[1, 4]