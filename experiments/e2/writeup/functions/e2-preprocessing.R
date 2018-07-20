gatherData = function() {
  number_of_valid_subjects=30
  number_of_trials_per_subject=256
  message('Starting to gather data')
  data_dir <- '../../experimentCode/output/'
  column.headers.df <-  head( read.table(
    paste(data_dir,'subject01.data',sep=''),
    header=TRUE),0)
  gathered.data <- column.headers.df
  for (subject in 1:number_of_valid_subjects) {
    current.filename <- paste(data_dir, 'subject', sprintf("%02d",subject), '.data', sep='')
    current.data <- read.table(file=current.filename, header=TRUE, stringsAsFactors = TRUE)
    gathered.data <- rbind(gathered.data, current.data)
  }
  dat <- gathered.data
  dat$Order <- factor(dat$Order, levels=c(1,2), labels=c('LtoR','RtoL'))
  dat$c_Ord <- ifelse(dat$Order=="LtoR",-.5,.5)
  dat$Quantity <- factor(dat$Quantity, levels=c(1,2), labels=c('Small','Large'))
  dat$c_Qty <- ifelse(dat$Quantity=="Small",-.5,.5)
  dat[ dat$Condition==1 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==2 , 'Vagueness'] <- 'Crisp'
  dat[ dat$Condition==3 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==4 , 'Vagueness'] <- 'Crisp'
  dat$Vagueness <- as.factor(dat$Vagueness)
  dat$c_Vag <- ifelse(dat$Vagueness=='Crisp', -.5, .5)
  dat[ dat$Condition==1 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==2 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==3 , 'Number'] <- 'Verbal'
  dat[ dat$Condition==4 , 'Number'] <- 'Verbal'
  dat$Number <- as.factor(dat$Number)
  dat$c_Num <- ifelse(dat$Number=='Numeric', -.5, .5)
  dat$Subject <- factor(paste("s",sprintf("%02d",dat$Subject),sep=""))
  dat$Item_fac <- factor(dat$Item, levels=c(1,2,3,4), labels=c("06:15:24", "16:25:34", "26:35:44", "36:45:54"))
  dat$c_Itm <- ifelse(dat$Item==1, -.75, ifelse(dat$Item==2, -.25, ifelse(dat$Item==3, .25, .75)))
  dat$Trial = rep(x = 1:number_of_trials_per_subject, times = number_of_valid_subjects)
  dat$c_Trl <-dat$Trial - mean(dat$Trial)
  dat$c_Itm <- ifelse(dat$Item==1, -.75, ifelse(dat$Item==2, -.25, ifelse(dat$Item==3, .25, .75)))
  dat$nchar_instr = nchar(as.character(dat$Instruction))
  discriminability = c(0.4875000, 0.3123529, 0.2308442, 0.1833333)
  dat[dat$Item_fac == "06:15:24", "discriminability"] <- discriminability[1]#0.4875000
  dat[dat$Item_fac == "16:25:34", "discriminability"] <- discriminability[2]#0.3123529
  dat[dat$Item_fac == "26:35:44", "discriminability"] <- discriminability[3]#0.2308442
  dat[dat$Item_fac == "36:45:54", "discriminability"] <- discriminability[4]#0.1833333
  # what were they expected to respond?
  message('figuring out borderline response')
  dat$crossed = as.factor(paste('Con', dat$Condition, ':Quan', as.numeric(dat$Quantity), ':Item', dat$Item, sep=''))
  dat[dat$crossed=='Con1:Quan1:Item1', 'Exp_Num']       <-  6
  dat[dat$crossed=='Con1:Quan1:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con1:Quan1:Item1', 'Extr_Num']      <- 24
  dat[dat$crossed=='Con1:Quan1:Item2', 'Exp_Num'] <- 16
  dat[dat$crossed=='Con1:Quan1:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con1:Quan1:Item2', 'Extr_Num']      <- 34
  dat[dat$crossed=='Con1:Quan1:Item3', 'Exp_Num'] <- 26
  dat[dat$crossed=='Con1:Quan1:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con1:Quan1:Item3', 'Extr_Num']      <- 44
  dat[dat$crossed=='Con1:Quan1:Item4', 'Exp_Num'] <- 36
  dat[dat$crossed=='Con1:Quan1:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con1:Quan1:Item4', 'Extr_Num']      <- 54
  dat[dat$crossed=='Con1:Quan2:Item1', 'Exp_Num'] <- 24
  dat[dat$crossed=='Con1:Quan2:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con1:Quan2:Item1', 'Extr_Num']      <-  6
  dat[dat$crossed=='Con1:Quan2:Item2', 'Exp_Num'] <- 34
  dat[dat$crossed=='Con1:Quan2:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con1:Quan2:Item2', 'Extr_Num']      <- 16
  dat[dat$crossed=='Con1:Quan2:Item3', 'Exp_Num'] <- 44
  dat[dat$crossed=='Con1:Quan2:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con1:Quan2:Item3', 'Extr_Num']      <- 26
  dat[dat$crossed=='Con1:Quan2:Item4', 'Exp_Num'] <- 54
  dat[dat$crossed=='Con1:Quan2:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con1:Quan2:Item4', 'Extr_Num']      <- 36
  dat[dat$crossed=='Con2:Quan1:Item1', 'Exp_Num'] <-  6
  dat[dat$crossed=='Con2:Quan1:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con2:Quan1:Item1', 'Extr_Num']      <- 24
  dat[dat$crossed=='Con2:Quan1:Item2', 'Exp_Num'] <- 16
  dat[dat$crossed=='Con2:Quan1:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con2:Quan1:Item2', 'Extr_Num']      <- 34
  dat[dat$crossed=='Con2:Quan1:Item3', 'Exp_Num'] <- 26
  dat[dat$crossed=='Con2:Quan1:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con2:Quan1:Item3', 'Extr_Num']      <- 44
  dat[dat$crossed=='Con2:Quan1:Item4', 'Exp_Num'] <- 36
  dat[dat$crossed=='Con2:Quan1:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con2:Quan1:Item4', 'Extr_Num']      <- 54
  dat[dat$crossed=='Con2:Quan2:Item1', 'Exp_Num'] <- 24
  dat[dat$crossed=='Con2:Quan2:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con2:Quan2:Item1', 'Extr_Num']      <-  6
  dat[dat$crossed=='Con2:Quan2:Item2', 'Exp_Num'] <- 34
  dat[dat$crossed=='Con2:Quan2:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con2:Quan2:Item2', 'Extr_Num']      <- 16
  dat[dat$crossed=='Con2:Quan2:Item3', 'Exp_Num'] <- 44
  dat[dat$crossed=='Con2:Quan2:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con2:Quan2:Item3', 'Extr_Num']      <- 26
  dat[dat$crossed=='Con2:Quan2:Item4', 'Exp_Num'] <- 54
  dat[dat$crossed=='Con2:Quan2:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con2:Quan2:Item4', 'Extr_Num']      <- 36
  dat[dat$crossed=='Con3:Quan1:Item1', 'Exp_Num'] <-  6
  dat[dat$crossed=='Con3:Quan1:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con3:Quan1:Item1', 'Extr_Num']      <- 24
  dat[dat$crossed=='Con3:Quan1:Item2', 'Exp_Num'] <- 16
  dat[dat$crossed=='Con3:Quan1:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con3:Quan1:Item2', 'Extr_Num']      <- 34
  dat[dat$crossed=='Con3:Quan1:Item3', 'Exp_Num'] <- 26
  dat[dat$crossed=='Con3:Quan1:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con3:Quan1:Item3', 'Extr_Num']      <- 44
  dat[dat$crossed=='Con3:Quan1:Item4', 'Exp_Num'] <- 36
  dat[dat$crossed=='Con3:Quan1:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con3:Quan1:Item4', 'Extr_Num']      <- 54
  dat[dat$crossed=='Con3:Quan2:Item1', 'Exp_Num'] <- 24
  dat[dat$crossed=='Con3:Quan2:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con3:Quan2:Item1', 'Extr_Num']      <-  6
  dat[dat$crossed=='Con3:Quan2:Item2', 'Exp_Num'] <- 34
  dat[dat$crossed=='Con3:Quan2:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con3:Quan2:Item2', 'Extr_Num']      <- 16
  dat[dat$crossed=='Con3:Quan2:Item3', 'Exp_Num'] <- 44
  dat[dat$crossed=='Con3:Quan2:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con3:Quan2:Item3', 'Extr_Num']      <- 26
  dat[dat$crossed=='Con3:Quan2:Item4', 'Exp_Num'] <- 54
  dat[dat$crossed=='Con3:Quan2:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con3:Quan2:Item4', 'Extr_Num']      <- 36
  dat[dat$crossed=='Con4:Quan1:Item1', 'Exp_Num'] <-  6
  dat[dat$crossed=='Con4:Quan1:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con4:Quan1:Item1', 'Extr_Num']      <- 24
  dat[dat$crossed=='Con4:Quan1:Item2', 'Exp_Num'] <- 16
  dat[dat$crossed=='Con4:Quan1:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con4:Quan1:Item2', 'Extr_Num']      <- 34
  dat[dat$crossed=='Con4:Quan1:Item3', 'Exp_Num'] <- 26
  dat[dat$crossed=='Con4:Quan1:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con4:Quan1:Item3', 'Extr_Num']      <- 44
  dat[dat$crossed=='Con4:Quan1:Item4', 'Exp_Num'] <- 36
  dat[dat$crossed=='Con4:Quan1:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con4:Quan1:Item4', 'Extr_Num']      <- 54
  dat[dat$crossed=='Con4:Quan2:Item1', 'Exp_Num'] <- 24
  dat[dat$crossed=='Con4:Quan2:Item1', 'Bline_Num']     <- 15
  dat[dat$crossed=='Con4:Quan2:Item1', 'Extr_Num']      <-  6
  dat[dat$crossed=='Con4:Quan2:Item2', 'Exp_Num'] <- 34
  dat[dat$crossed=='Con4:Quan2:Item2', 'Bline_Num']     <- 25
  dat[dat$crossed=='Con4:Quan2:Item2', 'Extr_Num']      <- 16
  dat[dat$crossed=='Con4:Quan2:Item3', 'Exp_Num'] <- 44
  dat[dat$crossed=='Con4:Quan2:Item3', 'Bline_Num']     <- 35
  dat[dat$crossed=='Con4:Quan2:Item3', 'Extr_Num']      <- 26
  dat[dat$crossed=='Con4:Quan2:Item4', 'Exp_Num'] <- 54
  dat[dat$crossed=='Con4:Quan2:Item4', 'Bline_Num']     <- 45
  dat[dat$crossed=='Con4:Quan2:Item4', 'Extr_Num']      <- 36
  dat$crossed <- NULL
  # what side LEFT, MIDDLE, RIGHT corresponds with Expected, Borderline, Extreme?
  for (row in 1:nrow(dat)) {
    if (dat[row, 'Exp_Num']   == dat[row, 'Left'])  {dat[row, 'Exp_side']   <- 'left'}
    if (dat[row, 'Exp_Num']   == dat[row, 'Mid'])   {dat[row, 'Exp_side']   <- 'mid'}
    if (dat[row, 'Exp_Num']   == dat[row, 'Right']) {dat[row, 'Exp_side']   <- 'right'}
    if (dat[row, 'Bline_Num'] == dat[row, 'Left'])  {dat[row, 'Bline_side'] <- 'left'}
    if (dat[row, 'Bline_Num'] == dat[row, 'Mid'])   {dat[row, 'Bline_side'] <- 'mid'}
    if (dat[row, 'Bline_Num'] == dat[row, 'Right']) {dat[row, 'Bline_side'] <- 'right'}
    if (dat[row, 'Extr_Num']  == dat[row, 'Left'])  {dat[row, 'Extr_side']  <- 'left'}
    if (dat[row, 'Extr_Num']  == dat[row, 'Mid'])   {dat[row, 'Extr_side']  <- 'mid'}
    if (dat[row, 'Extr_Num']  == dat[row, 'Right']) {dat[row, 'Extr_side']  <- 'right'}
  }
  # what button press did the subject actually make? LEFT, MIDDLE, RIGHT, NOANSWER?
  # what number of dots corresponds with the subject's button press?
  for (row in 1 : nrow(dat) ) {
    switch(as.character(dat[row,'RESPONSE']),
           'LEFT' = {dat[row, 'response_num'] <- dat[row, 'Left']},
           'MIDDLE' = {dat[row, 'response_num'] <- dat[row, 'Mid']},
           'RIGHT' = {dat[row, 'response_num'] <- dat[row, 'Right']},
           'NOANSWER' = {dat[row, 'response_num'] <- 'NOANSWER'}
    )
  }
  # what category was the subject's response? Expected, Borderline, Extreme, NA
  dat$response_category <- as.character(NA)
  for (row in 1:nrow(dat)) {
    if (dat[row, 'response_num'] == dat[row, 'Exp_Num']) {dat[row, 'response_category'] <- 'expected'}
    if (dat[row, 'response_num'] == dat[row, 'Bline_Num']) {dat[row, 'response_category'] <- 'borderline'}
    if (dat[row, 'response_num'] == dat[row, 'Extr_Num']) {dat[row, 'response_category'] <- 'extreme'}
  }
  dat$response_category <- as.factor(dat$response_category)
  # add isBorderline
  dat$isBorderline <- dat$response_category=='borderline'
  # remove function-internal variables befrore returning the df
  dat$RESPONSE <- NULL
  dat$Exp_Num <- NULL
  dat$Bline_Num <- NULL
  dat$Extr_Num <- NULL
  dat$Exp_side <- NULL
  dat$Bline_side <- NULL
  dat$Extr_side <- NULL
  dat$response_num <- NULL
  dat$response_side <- NULL
  dat$Item <- dat$Item_fac; dat$Item_fac=NULL
  dat$Condition=NULL
  dat$RT_original <- dat$RT
  dat$isBorderline_original <- dat$isBorderline
  message('returning data')
  return(dat)
} # end of gatherData

# declareImpossibleRT
declareImpossibleRT = function(dat) {
  message('Starting to declare impossible RTs')
  # declare impossible trials as NA
  # impossible trials are sticky fingers and timeouts
  dat$NaType = 'valid_trial'
  dat$NaType[dat$RT_original <= 1] <- 'sticky_fingers'
  dat$RT[dat$RT_original <= 1] <- NA
  dat$isBorderline[dat$RT_original <= 1] <- NA
  dat$response_category[dat$RT_original <= 1] <- NA
  dat$NaType[dat$RT_original >= 59998] <- 'near_timeout'
  dat$RT[dat$RT_original >= 59998 ] <- NA
  dat$response_category[dat$RT_original >= 59998] <- NA
  dat$isBorderline[dat$RT_original >= 59998] <- NA
  dat$NaType[is.na(dat$isBorderline_original)] <- 'timeout'
  dat$isBorderline[dat$isBorderline_original=='timeout'] <- NA
  dat$response_category[dat$isBorderline_original=='timeout'] <- NA
  dat$response_category <- as.factor(dat$response_category)
  dat$NaType <- as.factor(dat$NaType)
  dat$RT_original <- NULL
  dat$isBorderline_original <- NULL
  dat$RT_log <- log(dat$RT)
  message('Returning data with impossible RTs declared as NA in RT and isBorderline')
  return(dat)
}

removeImpossibleTrials = function(dat){
  message('Starting to remove impossible trials')
  a=nrow(dat)
  dat <- dat[ complete.cases(dat), ]
  b=nrow(dat)
  message(paste('removed', a-b, 'impossible trials'))
  return(dat)
}
