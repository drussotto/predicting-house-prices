source("./scripts/load_dependencies.R")

hp_train <- fread("./data/house_price_train.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)

tg <- data.table(expand.grid(mtry=15,
                             splitrule='variance',
                             min.node.size=5))


rf_model_all_features <- pipeline_casero(hp_train,
                               pp, 
                               fc,
                               model="ranger",
                               tunegrid=tg)

saveRDS(rf_model_all_features, "./models/rf_model_all_features.rds")


pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)
fs <- c(rfe_selection)


rf_model_rfe <- pipeline_casero(hp_train,
                             pp, 
                             fc,
                             fs,
                             model="ranger",
                             tunegrid=tg)

saveRDS(rf_model_rfe, "./models/rf_model_rfe.rds")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c()
fs <- c(rfe_selection)


rf_model_base_rfe <- pipeline_casero(hp_train,
                                pp, 
                                fc,
                                fs,
                                model="ranger",
                                tunegrid=tg)

saveRDS(rf_model_base_rfe, "./models/rf_model_base_rfe.rds")


pp <- c(create_date_features, rm_zip, rm_id)
fc <- c(yrs_since_renovated, sum_grades, bed_bath_ratio, size_yard, cluster_loc)
fs <- c(rfe_selection)

# Best model so far is with added features using RFE, do grid search on that
tg <- data.table(expand.grid(mtry=c(10, 15, 20),
                             splitrule='variance',
                             min.node.size=c(2,5,10)))

rf_model_gridsearch <- pipeline_casero(hp_train,
                                pp, 
                                fc,
                                fs,
                                model="ranger",
                                tunegrid=tg)

saveRDS(rf_model_gridsearch, "./models/rf_model_gridsearch.rds")




