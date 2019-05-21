library("data.table")
library("ranger")

pipeline_casero <- function(df, preprocessing=c(), creation=c(), selection=c()) {
  df <- data.table(df)
  
  for (f in preprocessing) {
    df <- f(df)
  }
  
  for (f in creation) {
    df <- f(df)
  }
  
  for(f in selection) {
    df <- f(df)
  }
  
  #TODO: Work in the modeling
  
  return(df)
}

pp <- c(create_date_features, factorize_zips)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio,size_yard,cluster_loc)

names(pipeline_casero(hp_train, pp, fc))