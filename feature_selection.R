rfe_selection <- function(df) {
  df <- one_hot(data.table(df))
  
  rf_profile <- rfe(price~.,
                    df[sample(nrow(hp_train), 0.5*nrow(hp_train)),],
                    sizes=c(ncol(df),ceiling(ncol(df)*0.9), ceiling(ncol(df)*0.8), ceiling(ncol(df)*0.7)),
                    rfeControl=rfeControl(rfFuncs, method="cv", number=3))
  
  print(paste(length(predictors(rf_profile)),
              "variables chosen: ",
              paste(predictors(rf_profile), collapse=", ")))
  
  return(df[,c("price", predictors(rf_profile)), with=F])
}