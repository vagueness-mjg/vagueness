concatenate_raw_data = function() {
  
  number_of_valid_subjects=30
  number_of_trials_per_subject=256
  data_dir <- 'per_subject_raw_data_files/'
  
  column.headers.df <-  head( read.table(
    paste(data_dir,'subject01.data',sep=''),
    header=TRUE),0)

  gathered.data <- column.headers.df
  
  for (subject in 1:number_of_valid_subjects) {
    current.filename <- paste(data_dir, 'subject', sprintf("%02d",subject), '.data', sep='')
    current.data <- read.table(file=current.filename, header=TRUE, stringsAsFactors = TRUE)
    gathered.data <- rbind(gathered.data, current.data)
  }
  
  return(gathered.data)
  
}
