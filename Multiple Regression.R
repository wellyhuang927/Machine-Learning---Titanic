#############################################################
# ミ狡癹耴だ猂家 / Building LPM                         #
#############################################################
store_area <- c(10, 8, 8, 5, 7, 8, 7, 9, 6, 9)
dist_to_station <- c(80, 0, 200, 200, 300, 230, 40, 0, 330, 180)
monthly_sales <- c(469, 366, 371, 208, 246, 297, 363, 436, 198, 364)
bakery_df <- data.frame(store_area, dist_to_station, monthly_sales)

lm_fit <- lm(monthly_sales ~ store_area + dist_to_station)

# 玒计 / Print coefficients
lm_fit$coefficients[-1]

# 篒禯 / Print intercept
lm_fit$coefficients[1]

#############################################################
# ノ狡癹耴家箇代 / Predict using LPM                    #
#############################################################

# 穝矹縷┍戈 / New cake shop information
to_be_predicted <- data.frame(store_area = 10, dist_to_station = 110)
predicted_sales <- predict(lm_fit, newdata = to_be_predicted)

# 箇代穝矹縷┍虫る綪秖 / Predict the monthly sales for the new cake shop
predicted_sales

#############################################################
# 狡癹耴家罿                                          #
#  Evaluation (mse, r^2, and adjusted r^2)                  #
#############################################################

predicted_sales <- predict(lm_fit, newdata = data.frame(store_area, dist_to_station))

# 家罿 / Evaluation
mse <- sum(lm_fit$residuals^2)/(length(store_area)-3)

# 家罿 / Print evaluation
mse
summary(lm_fit)$r.squared
summary(lm_fit)$adj.r.squared

#############################################################
# 狡癹耴家玒计浪﹚ / Evaluation (testing coefficients)#
#############################################################

#  p-value / Print p-value
summary(lm_fit)$coefficients[-1, 4]
#4琌Pv逆3琌Tv2琌stdev
#The "4" is for p-value, "3" for t-value, "2" for standard deviation
summary(lm_fit)$coefficients[1, 4]