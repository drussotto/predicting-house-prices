library("data.table")
library("dbscan")


create_date_features <- function(df) {
  # in R this is a new object
  df <- data.table(df)
  
  df[, c("day", "month", "year") := tstrsplit(hp_train$date, "/", type.convert = T)]
  
  return(df)
  
  
}


factorize_zips <- function(df) {
  df <- data.table(df)
  
  df[, c("zipcode") := factor(zipcode, 
                              levels=names(sort(table(zipcode), 
                                                decreasing=TRUE)))]
 return(df) 
}

hp_train$zipcode <- factor(hp_train$zipcode, 
                           levels=names(sort(table(hp_train$zipcode), 
                                             decreasing=TRUE)))



yrs_since_renovated <- function(df) {
  df <- data.table(df)
  
  df[, c("yrs_since_renovated") := (year - ifelse(yr_renovated, yr_renovated, yr_built))]
  
  return(df)
}

sum_grades <- function(df) {
  df <- data.table(df)
  
  # include waterfront?
  df[, c("grade_sums") := (view + condition + grade)]
  
  return(df)
}

# estimating a person to bathroom ratio
bed_bath_ratio <- function(df) {
  df <- data.table(df)
  
  df[, c("bed_bath_ratio") := (bed / bath)]
  
  return(df)
}


# estimation of a yard o algo asi
size_yard <- function(df) {
  df <- data.table(df)
  
  # assuming the living space split evenly amongst the floors
  df[, c("yard") := sqft_lot - (sqft_living / floors)]
  
  return(df)
}


#kNNdistplot(hp_train[, c("lat", "long")], round(log(nrow(hp_train))))

cluster_loc <- function(df) {
  df <- data.table(df)
  
  # can't incorporate elbow programmatically, but determined 0.03 from knnDistPlot and trial and error
  df[, c("loc_cluster") := 
       as.factor(dbscan(df[, c("lat", "long")], minPts=round(log(nrow(df))), eps=0.03)$cluster)]
  
  return(df)
}



