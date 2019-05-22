source("load_dependencies.R")
source("preprocessing.R")
source("feature_creation.R")
source("pipeline_casero.R")

hp_train <- fread("house_price_train.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio,size_yard,cluster_loc)

lm_baseline <- pipeline_casero(hp_train, pp, fc, model="lm")