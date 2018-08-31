preprocessing = function(root_dir, data_dir) {
  
  dat <- read.delim(file.path(root_dir, data_dir, "data_raw.txt"), stringsAsFactors = FALSE)
  
  # declare local variables
  Number_of_valid_subjects <- 40
  Number_of_rows <- 7680
  Number_of_trials_per_subject <- Number_of_rows / Number_of_valid_subjects # 192
  
  # sort out borderline responses into expected near and far
  # How many squares in the square they chose? 
  dat$RESPONSE <- as.character(dat$key)
  for (row in 1 : nrow(dat) ) {
    switch(dat[row,'RESPONSE'],
           'L' = {dat[row, 'choice'] <- dat[row, 'Lft']},
           'M' = {dat[row, 'choice'] <- dat[row, 'Mid']},
           'R' = {dat[row, 'choice'] <- dat[row, 'Rgt']}         
    )
  }
  dat$Item <- dat$Itm
  dat$Itm <- NULL
  dat$crossed=paste('Con',dat$Cnd,':Quan',dat$Qty,':Item',dat$Item,sep="")
  
  dat[dat$crossed=='Con1:Quan1:Item1', 'ResponseExpected'] <-  6 
  dat[dat$crossed=='Con1:Quan1:Item1', 'ResponseNear']     <- 15  
  dat[dat$crossed=='Con1:Quan1:Item1', 'ResponseFar']      <- 24
  
  dat[dat$crossed=='Con1:Quan1:Item2', 'ResponseExpected'] <- 16
  dat[dat$crossed=='Con1:Quan1:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con1:Quan1:Item2', 'ResponseFar']      <- 34
  
  dat[dat$crossed=='Con1:Quan1:Item3', 'ResponseExpected'] <- 26
  dat[dat$crossed=='Con1:Quan1:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con1:Quan1:Item3', 'ResponseFar']      <- 44
  
  dat[dat$crossed=='Con1:Quan1:Item4', 'ResponseExpected'] <- 36
  dat[dat$crossed=='Con1:Quan1:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con1:Quan1:Item4', 'ResponseFar']      <- 54
  
  dat[dat$crossed=='Con1:Quan2:Item1', 'ResponseExpected'] <- 24
  dat[dat$crossed=='Con1:Quan2:Item1', 'ResponseNear']     <- 15 
  dat[dat$crossed=='Con1:Quan2:Item1', 'ResponseFar']      <-  6
  
  dat[dat$crossed=='Con1:Quan2:Item2', 'ResponseExpected'] <- 34
  dat[dat$crossed=='Con1:Quan2:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con1:Quan2:Item2', 'ResponseFar']      <- 16
  
  dat[dat$crossed=='Con1:Quan2:Item3', 'ResponseExpected'] <- 44
  dat[dat$crossed=='Con1:Quan2:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con1:Quan2:Item3', 'ResponseFar']      <- 26
  
  dat[dat$crossed=='Con1:Quan2:Item4', 'ResponseExpected'] <- 54
  dat[dat$crossed=='Con1:Quan2:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con1:Quan2:Item4', 'ResponseFar']      <- 36
  
  dat[dat$crossed=='Con2:Quan1:Item1', 'ResponseExpected'] <-  6 
  dat[dat$crossed=='Con2:Quan1:Item1', 'ResponseNear']     <- 15  
  dat[dat$crossed=='Con2:Quan1:Item1', 'ResponseFar']      <- 24
  
  dat[dat$crossed=='Con2:Quan1:Item2', 'ResponseExpected'] <- 16
  dat[dat$crossed=='Con2:Quan1:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con2:Quan1:Item2', 'ResponseFar']      <- 34
  
  dat[dat$crossed=='Con2:Quan1:Item3', 'ResponseExpected'] <- 26
  dat[dat$crossed=='Con2:Quan1:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con2:Quan1:Item3', 'ResponseFar']      <- 44
  
  dat[dat$crossed=='Con2:Quan1:Item4', 'ResponseExpected'] <- 36
  dat[dat$crossed=='Con2:Quan1:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con2:Quan1:Item4', 'ResponseFar']      <- 54
  
  dat[dat$crossed=='Con2:Quan2:Item1', 'ResponseExpected'] <- 24
  dat[dat$crossed=='Con2:Quan2:Item1', 'ResponseNear']     <- 15 
  dat[dat$crossed=='Con2:Quan2:Item1', 'ResponseFar']      <-  6
  
  dat[dat$crossed=='Con2:Quan2:Item2', 'ResponseExpected'] <- 34
  dat[dat$crossed=='Con2:Quan2:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con2:Quan2:Item2', 'ResponseFar']      <- 16
  
  dat[dat$crossed=='Con2:Quan2:Item3', 'ResponseExpected'] <- 44
  dat[dat$crossed=='Con2:Quan2:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con2:Quan2:Item3', 'ResponseFar']      <- 26
  
  dat[dat$crossed=='Con2:Quan2:Item4', 'ResponseExpected'] <- 54
  dat[dat$crossed=='Con2:Quan2:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con2:Quan2:Item4', 'ResponseFar']      <- 36
  
  dat[dat$crossed=='Con3:Quan1:Item1', 'ResponseExpected'] <-  6 
  dat[dat$crossed=='Con3:Quan1:Item1', 'ResponseNear']     <- 15  
  dat[dat$crossed=='Con3:Quan1:Item1', 'ResponseFar']      <- 24
  
  dat[dat$crossed=='Con3:Quan1:Item2', 'ResponseExpected'] <- 16
  dat[dat$crossed=='Con3:Quan1:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con3:Quan1:Item2', 'ResponseFar']      <- 34
  
  dat[dat$crossed=='Con3:Quan1:Item3', 'ResponseExpected'] <- 26
  dat[dat$crossed=='Con3:Quan1:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con3:Quan1:Item3', 'ResponseFar']      <- 44
  
  dat[dat$crossed=='Con3:Quan1:Item4', 'ResponseExpected'] <- 36
  dat[dat$crossed=='Con3:Quan1:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con3:Quan1:Item4', 'ResponseFar']      <- 54
  
  dat[dat$crossed=='Con3:Quan2:Item1', 'ResponseExpected'] <- 24
  dat[dat$crossed=='Con3:Quan2:Item1', 'ResponseNear']     <- 15 
  dat[dat$crossed=='Con3:Quan2:Item1', 'ResponseFar']      <-  6
  
  dat[dat$crossed=='Con3:Quan2:Item2', 'ResponseExpected'] <- 34
  dat[dat$crossed=='Con3:Quan2:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con3:Quan2:Item2', 'ResponseFar']      <- 16
  
  dat[dat$crossed=='Con3:Quan2:Item3', 'ResponseExpected'] <- 44
  dat[dat$crossed=='Con3:Quan2:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con3:Quan2:Item3', 'ResponseFar']      <- 26
  
  dat[dat$crossed=='Con3:Quan2:Item4', 'ResponseExpected'] <- 54
  dat[dat$crossed=='Con3:Quan2:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con3:Quan2:Item4', 'ResponseFar']      <- 36
  
  dat[dat$crossed=='Con4:Quan1:Item1', 'ResponseExpected'] <-  6 
  dat[dat$crossed=='Con4:Quan1:Item1', 'ResponseNear']     <- 15  
  dat[dat$crossed=='Con4:Quan1:Item1', 'ResponseFar']      <- 24
  
  dat[dat$crossed=='Con4:Quan1:Item2', 'ResponseExpected'] <- 16
  dat[dat$crossed=='Con4:Quan1:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con4:Quan1:Item2', 'ResponseFar']      <- 34
  
  dat[dat$crossed=='Con4:Quan1:Item3', 'ResponseExpected'] <- 26
  dat[dat$crossed=='Con4:Quan1:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con4:Quan1:Item3', 'ResponseFar']      <- 44
  
  dat[dat$crossed=='Con4:Quan1:Item4', 'ResponseExpected'] <- 36
  dat[dat$crossed=='Con4:Quan1:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con4:Quan1:Item4', 'ResponseFar']      <- 54
  
  dat[dat$crossed=='Con4:Quan2:Item1', 'ResponseExpected'] <- 24
  dat[dat$crossed=='Con4:Quan2:Item1', 'ResponseNear']     <- 15 
  dat[dat$crossed=='Con4:Quan2:Item1', 'ResponseFar']      <-  6
  
  dat[dat$crossed=='Con4:Quan2:Item2', 'ResponseExpected'] <- 34
  dat[dat$crossed=='Con4:Quan2:Item2', 'ResponseNear']     <- 25  
  dat[dat$crossed=='Con4:Quan2:Item2', 'ResponseFar']      <- 16
  
  dat[dat$crossed=='Con4:Quan2:Item3', 'ResponseExpected'] <- 44
  dat[dat$crossed=='Con4:Quan2:Item3', 'ResponseNear']     <- 35
  dat[dat$crossed=='Con4:Quan2:Item3', 'ResponseFar']      <- 26
  
  dat[dat$crossed=='Con4:Quan2:Item4', 'ResponseExpected'] <- 54
  dat[dat$crossed=='Con4:Quan2:Item4', 'ResponseNear']     <- 45
  dat[dat$crossed=='Con4:Quan2:Item4', 'ResponseFar']      <- 36
  
  dat$isResponseExpected <- dat$choice == dat$ResponseExpected
  dat$isResponseNear <- dat$choice == dat$ResponseNear
  dat$isResponseFar <- dat$choice == dat$ResponseFar
  
  for ( row in 1:nrow(dat) ) {
    dat[row, 'response_cat'] <- 
      ifelse(dat[row, 'isResponseExpected']==TRUE, 'Expected', 
             ifelse(dat[row, 'isResponseNear']==TRUE, 'Near', 'Far') ) 
  }
  
  # ensure Subject is a factor 
  dat$Subject=factor(paste("s",sprintf("%02d",dat$Sub),sep=""))
  
  # Trial for subject, 1 to 192
  dat$Trial = rep(x = 1:Number_of_trials_per_subject, times = Number_of_valid_subjects)
  
  # Obs is a unique identifier for the 7680 row data
  dat$Obs <- 1:7680
  
  # make Item be a factor and assign labels
  dat$Item <- factor(dat$Item, levels=c(1,2,3,4), labels=c("06:15:24", "16:25:34", "26:35:44", "36:45:54"))
  
  # Create a factor coding for Vagueness
  dat[ dat$Cnd==1 , 'Vagueness'] <- 'Vague'
  dat[ dat$Cnd==2 , 'Vagueness'] <- 'Crisp'
  dat[ dat$Cnd==3 , 'Vagueness'] <- 'Vague'
  dat[ dat$Cnd==4 , 'Vagueness'] <- 'Crisp'
  dat$Vagueness <- as.factor(dat$Vagueness)
  
  # Create a variable coding for Selection Algorithm
  dat$Selection = ""
  dat[dat$Cnd %in% c(1,2), "Selection"] <- "Matching"
  dat[dat$Cnd %in% c(3,4), "Selection"] <- "Comparison"
  dat$Selection <- as.factor(dat$Selection)
  
  # give the levels of Order meaningful names
  dat$Order <- factor(dat$Ord, levels=c(1,2), labels=c('LtoR','RtoL'))
  
  # give the levels of Quantity meaningful names
  dat$Quantity <- factor(dat$Qty, levels=c(1,2), labels=c('Small','Large'))
  
  # add Number of characters in the instruction # 29 30 34 36 38
  dat$nchar_instr = nchar(as.character(dat$Ins))
  
  # make Instruction be a factor (17 levels)
  dat$Instruction <- as.factor(dat$Ins) 
  
  # Say how many dots were in the target
  dat$Target <- dat$Prm
  
  # give rt the expected name RT
  dat$RT <- dat$rt
  
  # select vars for main df
  dat <- subset(dat, select=c(Subject, Trial, Obs, Order, Quantity, Vagueness, Selection, Item, Target, Instruction, response_cat, RT))
  
  return(dat)
  
}