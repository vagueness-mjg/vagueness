concatenate_raw_data = function(root_dir, data_dir) {
  
  number_of_valid_subjects=30
  number_of_trials_per_subject=256

  column.headers.df <-  head(read.table(file.path(root_dir, data_dir, "subject01.data"), header=TRUE),0)

  gathered.data <- column.headers.df
  
  for (subject_number in 1:number_of_valid_subjects) {
    current.filename <- file.path(root_dir, data_dir, paste(sep="", "subject", sprintf("%02d", subject_number), ".data"))
    current.data <- read.table(file=current.filename, header=TRUE, stringsAsFactors = TRUE)
    gathered.data <- rbind(gathered.data, current.data)
  }
  
  return(gathered.data)
  
}
