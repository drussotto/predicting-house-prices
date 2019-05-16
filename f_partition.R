f_partition <- function(data, trainsize=0.8, seed=513) {
  set.seed(seed)
  train_i <- sample(nrow(data), floor(trainsize*nrow(data)))
  
  train <- data[train_i]
  test <- data[-train_i]
  
  retval <- list(train, test)
  names(retval) <- c("train", "test")
  
  return(retval)
  
}