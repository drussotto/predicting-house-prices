rf_model_gridsearch <- readRDS("models/rf_model_gridsearch.rds")

hp_test <- fread("house_price_test.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)


make_predictions <- function(df, preprocessing, feature_creation, train_obj) {
  df <- data.table(df)
  
  for(f in c(preprocessing,feature_creation)) {
    df <- f(df)
  }
  
  print(names(df))
  
  df <- one_hot(df)[,train_obj$coefnames,with=F]
  
  return(predict(train_obj$finalModel, df))
}



preds <- make_predictions(hp_test, pp, fc, rf_model_gridsearch)

guesses <- data.table(id=hp_test$id, pred=preds$predictions)
fwrite(guesses, "guesses.csv")