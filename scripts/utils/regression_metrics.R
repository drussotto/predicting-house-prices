# Taken from class_codes on campus

mae<-function(real, predicted){
  return(mean(abs(real-predicted)))
}

mape<-function(real,predicted){
  return(mean(abs((real-predicted)/real)))
}

rmse<-function(real,predicted){
  return(sqrt(mean((real-predicted)^2)))
}

coef_det <- function(real, predicted) {
  return(1 - (sum((real-predicted)^2)/sum((real - mean(real))^2)))
}

summary_w_mape <- function(data, lev=NULL, model=NULL) {
  
  retval <- c(defaultSummary(data), mape(data$obs, data$pred))
  
  names(retval) <- c("RMSE", "RSquared", "MAE", "MAPE")
  
  return(retval)
}