source("./scripts/load_dependencies.R")

hp_train <- fread("./data/house_price_train.csv")
hp_test <- fread("./data/house_price_test.csv")

summary(as.factor(hp_train$bedrooms))

ggplot(data=hp_train, aes(x=hp_train$bedrooms)) +
  geom_histogram(binwidth = 1) +
  xlim(1, 11) + # Highest is 33, next lowest is 11
  theme_minimal()


summary(as.factor(hp_train$bathrooms))

ggplot(data=hp_train, aes(x=hp_train$bathrooms)) +
  geom_histogram(binwidth = 0.25) +
  xlim(0.5, 8) + 
  theme_minimal()


summary(as.factor(hp_train$floors))

ggplot(data=hp_train, aes(x=hp_train$floors)) +
  geom_histogram(binwidth = 0.5) +
  xlim(0.5, 3.5) + 
  theme_minimal()

summary(hp_train$sqft_living)
nrow(hp_train[sqft_living>7500]) # 7500 chosen from eyeballing the original plot with no limits

ggplot(data=hp_train[sqft_living<=7500], aes(x=hp_train[sqft_living<=7500]$sqft_living)) +
  geom_histogram() +
  theme_minimal()

summary(hp_train$sqft_living15)
#nrow(hp_train[sqft_living15>6210]) # 7500 chosen from eyeballing the original plot with no limits

ggplot(data=hp_train, aes(x=hp_train$sqft_living15)) +
  geom_histogram() +
  theme_minimal()

nrow(hp_train[sqft_lot>300000])

ggplot(data=hp_train[sqft_lot<=300000], aes(x=hp_train[sqft_lot<=300000]$sqft_lot)) +
  geom_histogram() +
  theme_minimal()

nrow(hp_train[sqft_lot15>250000])

ggplot(data=hp_train[sqft_lot15<=250000], aes(x=hp_train[sqft_lot15<=250000]$sqft_lot15)) +
  geom_histogram() +
  theme_minimal()

set.seed(20190430)
ggpairs(hp_train[sample(nrow(hp_train), 500),],
        columns=c("price", "bedrooms", "bathrooms", "floors", "sqft_above", "sqft_basement", "sqft_living", "sqft_living15", "sqft_lot", "sqft_lot15"))



# Nothing missing, hurrah
any(!complete.cases(hp_train))

ggplot(data=hp_train, aes(x=waterfront)) + geom_bar()
# Ranked categorical variables
ggplot(data=hp_train, aes(x=view)) + geom_bar()
ggplot(data=hp_train, aes(x=condition)) + geom_bar()
ggplot(data=hp_train, aes(x=grade)) + geom_bar()

hp_train$zipcode <- factor(hp_train$zipcode, 
                           levels=names(sort(table(hp_train$zipcode), 
                                             decreasing=TRUE)))

ggplot(data=hp_train, aes(x=zipcode)) + geom_bar()


