source("load_dependencies.R")
source("preprocessing.R")
source("feature_creation.R")
source("feature_selection.R")
source("pipeline_casero.R")

hp_train <- fread("house_price_train.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)

tg <- data.table(expand.grid(mtry=15,
                             splitrule='variance',
                             min.node.size=5))


rf_model <- pipeline_casero(hp_train,
                               pp, 
                               fc,
                               model="ranger",
                               tunegrid=tg)


pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)
fs <- c(rfe_selection)


rf_model2 <- pipeline_casero(hp_train,
                             pp, 
                             fc,
                             fs,
                             model="ranger",
                             tunegrid=tg)