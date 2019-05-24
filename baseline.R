source("load_dependencies.R")
source("preprocessing.R")
source("feature_creation.R")
source("pipeline_casero.R")

hp_train <- fread("house_price_train.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c()

lm_baseline <- pipeline_casero(hp_train, pp, fc, model="lm")

saveRDS(lm_baseline, "./models/linear_baseline.rds")


pp <- c(create_date_features, rm_zip, rm_id)
fc <- c()
tg <- data.table(expand.grid(mtry=15,
                             splitrule='variance',
                             min.node.size=5))

rf_baseline <- pipeline_casero(hp_train,
                               pp, 
                               fc,
                               model="ranger",
                               tunegrid=tg)

saveRDS(rf_baseline, "./models/rf_baseline.rds")