remove_impossible_trials = function(dat){
  message('Starting to remove impossible trials')
  a=nrow(dat)
  dat <- dat[ complete.cases(dat), ]
  b=nrow(dat)
  message(paste('removed', a-b, 'impossible trials'))
  return(dat)
}
