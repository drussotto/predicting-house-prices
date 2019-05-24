create_date_features <- function(df) {
  # in R this is a new object
  df <- data.table(df)
  
  df[, c("day", "month", "year") := tstrsplit(df$date, "/", type.convert = T)]
  
  df$date <- NULL
  
  return(df)
}

rm_id <- function(df) {
  df <- data.table(df)
  
  df$id <- NULL
  
  return(df)
}


factorize_zips <- function(df) {
  df <- data.table(df)
  
  df[, c("zipcode") := factor(zipcode, 
                              levels=names(sort(table(zipcode), 
                                                decreasing=TRUE)))]
  return(df) 
}

rm_zip <- function(df) {
  df <- data.table(df)
  
  df$zipcode <- NULL
  
  return(df)
}


scale_features <- function(df) {
  # in R this is a new object
  df <- data.table(df)
  
  price <- df$price
  
  
  df[, names(df)[sapply(df, is.numeric)]:=lapply(.SD, scale), .SDcols=sapply(df, is.numeric)]
  
  df$price <- price
  
  return(df)
  
}