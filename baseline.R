library("data.table")
library("ranger")
source("regression_metrics.R")
source("f_partition.R")

hp_train <- fread("house_price_train.csv")
hp_test <- fread("house_price_test.csv")

scale_features <- function(df) {
  # in R this is a new object
  df <- data.table(df)
  
  price <- df$price
  
  
  df[, names(df)[sapply(df, is.numeric)]:=lapply(.SD, scale), .SDcols=sapply(df, is.numeric)]
  
  df$price <- price
  
  return(df)
  
}



hp_train <- create_date_features(hp_train)


# I would much rather just exclude these features from the formula, but I ran into this:
# https://stackoverflow.com/q/22315394
hp_train$id <- NULL
hp_test$id <- NULL
hp_train$date <- NULL
hp_test$date <- NULL

# same number of levels, phew
hp_train$zipcode <- factor(hp_train$zipcode)
hp_test$zipcode <- factor(hp_test$zipcode)

hp_train_scaled <- scale_features(hp_train)

hp_train.train <- f_partition(hp_train_scaled, seed=20190616)$train
hp_train.test <- f_partition(hp_train_scaled, seed=20190616)$test


linear_baseline <- lm(price~., hp_train.train)

summary(linear_baseline)

# TODO: removing insignificant zipcodes?
linear_baseline <- lm(price~. -sqft_lot -floors -sqft_basement, hp_train.train)

summary(linear_baseline)

lm_preds <- predict(linear_baseline, hp_train.test)

mae(hp_train.test$price, lm_preds)
mape(hp_train.test$price, lm_preds)
rmse(hp_train.test$price, lm_preds)



rf_baseline <- ranger(price~., hp_train.train)

rf_preds <- predict(rf_baseline, hp_train.test)$predictions

mae(hp_train.test$price, rf_preds)
mape(hp_train.test$price, rf_preds)
rmse(hp_train.test$price, rf_preds)





