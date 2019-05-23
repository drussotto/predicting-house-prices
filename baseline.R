source("load_dependencies.R")
source("preprocessing.R")
source("feature_creation.R")
source("pipeline_casero.R")

hp_train <- fread("house_price_train.csv")

pp <- c(create_date_features, rm_zip, rm_id)
fc <- c()

lm_baseline <- pipeline_casero(hp_train, pp, fc, model="lm")

tg <- data.table(expand.grid(mtry=15,
                             splitrule='variance',
                             min.node.size=5))


#linear_model <- pipeline_casero(sample(hp_train, floor(nrow(hp_train)*0.1, pp, fc, model="lm")
rf_baseline <- pipeline_casero(hp_train,
                               pp, 
                               fc,
                               model="ranger",
                               tunegrid=tg)
