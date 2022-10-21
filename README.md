# Machine-Learning---Titanic
2022/05-2022/06  
Main Content made by **Wei-Chung Huang**  
Collaborated with **Professor Cheng-Hsi Hsieh**  

This project is about implementing both Python and R to predict Titanic survivors.  
5 methods are used in this project:
1) simple regression  
2) multiple regression
3) logistic regression
4) random forest
5) support vector machine (SVM)  

The data sets used in this project is from *Titanic - Machine Learning from Disaster* (https://www.kaggle.com/c/titanic).  

The project is consisted of 4 main parts:  
1) Two CSV files - a training set and a test set from Kaggle. (https://www.kaggle.com/competitions/titanic/data)  
2) Five IPYNB files - 5 python files, developed using Google Colaboratory
3) Five R files - 5 R files, developed using R 4.1.2 and RStudio
4) Example-Titanic-Educational Purpose.ipynb - an explanatory file developed by Professor Cheng-Hsi Hsieh

## Simple Regression
🔴**Simple Regression.ipynb** and **Simple Regression.R**  
Used **temperature(X)** to predict **iced tea sales(Y)**.  
  ### Modules and Packages
  In Python, I used **LinearRegression()** from **sklearn.linear_model**.  
  In R, I used **lm**.  
  ### Evaluation of Prediction
  1) mse, r^2, and adjusted r^2
  2) testing coefficients

## Multiple Regression
🔴**Multiple Regression.ipynb** and **Multiple Regression.R**  
Used **the area of the cake shops(X1)** and **the distance from train station(X2)** to predict **the monthly sales of each cake shop(Y)**.  
  ### Modules and Packages
  In Python, I used **LinearRegression()** from **sklearn.linear_model**.  
  In R, I used **lm**.  
  ### Evaluation of Prediction
  1) mse, r^2, and adjusted r^2
  2) testing coefficients

  For Python users, please use **Multiple Regression_visualization.ipynb** for the visualization of the result.

## Logistic Regression
🔴**Logistic Regression.ipynb** and **Logistic Regression.R**  
Data sets used are **kaggle_titanic_train** and **kaggle_titanic_test**.  
Used **Sex(X1)**, **Age(X2)**, and **Pclass(X3)** to predict **survived or not(Y)**.  
  ### Modules and Packages
  In Python, I used **LogisticRegression()** from **sklearn.linear_model**.  
  In R, I used **glm**.  
  ### Evaluation of Prediction
  Used **confusion matrix**, **accuracy**, and **recall rate** to evaluate the prediction performance.

## Random Forest
🔴**Random Forest.ipynb** and **Random Forest.R**  
Data sets used are **kaggle_titanic_train** and **kaggle_titanic_test**.  
Used **Sex(X1)**, **Age(X2)**, and **Pclass(X3)** to predict **survived or not(Y)**.  
  ### Modules and Packages
  In Python, I used **RandomForestClassifier()** from **sklearn.ensemble**.  
  In R, I used **randomForest**.  
  ### Evaluation of Prediction
  Used **AUC**, **confusion matrix**, **accuracy**, and **recall rate** to evaluate the prediction performance.

## Support Vector Machine (SVM)
🔴**SVM.ipynb** and **SVM.R**  
Data sets used are **kaggle_titanic_train** and **kaggle_titanic_test**.  
Used **Sex(X1)**, **Age(X2)**, and **Pclass(X3)** to predict **survived or not(Y)**.  
  ### Modules and Packages
  In Python, I used **SVC()** from **sklearn.svm**.  
  In R, I used **svm** from **e1071**.  
  ### Evaluation of Prediction
  Used **AUC**, **confusion matrix**, **accuracy**, and **recall rate** to evaluate the prediction performance.
