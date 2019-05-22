source("load_dependencies.R")

pipeline_casero <- function(df, preprocessing=c(), creation=c(), selection=c(), model="ranger", k=3) {
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
  
  tc <- trainControl(method="cv", number=k)
  
  #TODO: Work in the modeling
  trained <- train(price~., df, method=model, metric="MAPE", maximize=FALSE,trControl=tc)
  
  return(trained)
}