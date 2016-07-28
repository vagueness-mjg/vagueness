# R version of gatherData.sh

gatherData = function(number_of_valid_subjects) {
  # message("gathering data ... ")
  # number_of_valid_subjects <- 30
  data_dir <- '../experimentCode/output/'
  
  column.headers.df <-  head( read.table(
    paste(data_dir,'subject1.data',sep=''),
    header=TRUE),0)
  
  gathered.data <- column.headers.df
  
  for (subject in 1:number_of_valid_subjects) {
    current.filename <- paste(data_dir, 'subject', subject, '.data', sep='')
    current.data <- read.table(file=current.filename, header=TRUE, stringsAsFactors = FALSE)
    gathered.data <- rbind(gathered.data, current.data)
  }
  
  # message("returning gathered data")
  
  return(gathered.data)
  
}