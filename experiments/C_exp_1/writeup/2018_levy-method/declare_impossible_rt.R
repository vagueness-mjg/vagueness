declare_impossible_rt = function(dat) {
  message('Starting to declare impossible RTs')
  dat$NaType = 'valid_trial'
  # declare impossible trials as NA
  # impossible trials are sticky fingers and timeouts
  # sticky fingers
  dat$NaType[dat$RT_original <= 1] <- 'sticky_fingers'
  dat$RT[dat$RT_original <= 1] <- NA
  dat$isBorderline[dat$RT_original <= 1] <- NA
  dat$response_category[dat$RT_original <= 1] <- NA
  # timeout
  dat$NaType[dat$RT_original >= 59998] <- 'near_timeout'
  dat$RT[dat$RT_original >= 59998 ] <- NA
  dat$isBorderline[dat$RT_original >= 59998] <- NA
  dat$response_category[dat$RT_original >= 59998] <- NA
  
  #dat$NaType[is.na(dat$isBorderline_original)] <- 'timeout'
 # dat$isBorderline[dat$isBorderline_original=='timeout'] <- NA
 # dat$response_category[dat$isBorderline_original=='timeout'] <- NA
  
  dat$response_category <- as.factor(dat$response_category)
  dat$NaType <- as.factor(dat$NaType)
  #dat$RT_original <- NULL
  #dat$isBorderline_original <- NULL
  dat$RT_log <- log(dat$RT)
  dat$RT_rcp <- -1/dat$RT
  message('Returning data with impossible RTs declared as NA in RT and isBorderline')
  return(dat)
}