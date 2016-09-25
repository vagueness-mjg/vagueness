## ----gatherDataFunction, echo=FALSE--------------------------------------
gatherData = function(number_of_valid_subjects) {
  data_dir <- '../../experimentCode/output/'
  column.headers.df <-  head( read.table(
    paste(data_dir,'subject01.data',sep=''),
    header=TRUE),0)
  gathered.data <- column.headers.df
  for (subject in 1:number_of_valid_subjects) {
    current.filename <- paste(data_dir, 'subject', sprintf("%02d",subject), '.data', sep='')
    current.data <- read.table(file=current.filename, header=TRUE, stringsAsFactors = FALSE)
    gathered.data <- rbind(gathered.data, current.data)
  }
  message('Returning gathered data')
  return(gathered.data)
} # end of gatherData function

## ----classifyResponseFuntion, echo=FALSE---------------------------------
classifyResponses = function(dat) {
  # what were they expected to respond?
  dat$crossed = as.factor(paste('Con', dat$Condition, ':Quan', dat$Quantity, ':Item', dat$Item, sep=''))
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
  dat$RESPONSE <- as.factor(dat$RESPONSE)
  # what number of dots corresponds with the subject's button press?
  for (row in 1 : nrow(dat) ) {
    switch(as.character(dat[row,'RESPONSE']),
           'LEFT' = {dat[row, 'response_num'] <- dat[row, 'Left']},
           'MIDDLE' = {dat[row, 'response_num'] <- dat[row, 'Mid']},
           'RIGHT' = {dat[row, 'response_num'] <- dat[row, 'Right']},
           'NOANSWER' = {dat[row, 'response_num'] <- NA})}
  # what side was the subject's button-press? Left, mid right?
  dat$response_side <- tolower(dat$RESPONSE)
  dat$response_side[dat$response_side == "middle"] <- 'mid'
  dat$response_side <- factor(dat$response_side, exclude="noanswer")
  # what category was the subject's response? Expected, Borderline, Extreme
  dat$response_category <- "nocat"
  for (row in row.names(na.omit(dat))) {
    if (dat[row, 'response_num'] == dat[row, 'Exp_Num']) {dat[row, 'response_category'] <- 'expected'}
    if (dat[row, 'response_num'] == dat[row, 'Bline_Num']) {dat[row, 'response_category'] <- 'borderline'}
    if (dat[row, 'response_num'] == dat[row, 'Extr_Num']) {dat[row, 'response_category'] <- 'extreme'}
  }
  dat$response_category <- factor(dat$response_category, exclude="nocat")
  dat$RESPONSE <- NULL
  message('Returning classified data')
  return(dat)
} # end of classifyResponse function

## ----processDataFunction, echo=FALSE-------------------------------------
processData = function(dat) {
  # SUBJECT
  dat$Subject=factor(paste("s",sprintf("%02d",dat$Subject),sep=""))
  # TRIAL
  dat$Trial = rep(x = 1:number_of_trials_per_subject, times = number_of_valid_subjects)
  # make a centred Trial for modeling
  dat$c_Trl <-dat$Trial - mean(dat$Trial)
  # make a scaled Trial for modelling
  dat$s_Trl <- as.numeric(scale(dat$Trial))
  # ID
  # id is a unique identifier for the 7680 row data
  dat$id <- factor(paste(paste(dat$Subject), paste("t", sprintf("%03d", dat$Trial), sep="") , sep=":"))
  # ITEM
  # create a centred numeric item variable for modeling
  dat$c_Itm <- ifelse(dat$Item==1, -.75, ifelse(dat$Item==2, -.25, ifelse(dat$Item==3, .25, .75)))
  # make Item be a factor and assign labels
  dat$Item <- factor(dat$Item, levels=c(1,2,3,4), labels=c("06:15:24", "16:25:34", "26:35:44", "36:45:54"))
  # VAGUENESS
  # Create a factor coding for Vagueness
  dat[ dat$Condition==1 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==2 , 'Vagueness'] <- 'Crisp'
  dat[ dat$Condition==3 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==4 , 'Vagueness'] <- 'Crisp'
  dat$Vagueness <- as.factor(dat$Vagueness)
  # manually center Vagueness
  dat$c_Vag <- ifelse(dat$Vagueness=='Crisp', -.5, .5)
  # NUMBER
  # Create a factor coding for Number use
  dat[ dat$Condition==1 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==2 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==3 , 'Number'] <- 'Verbal'
  dat[ dat$Condition==4 , 'Number'] <- 'Verbal'
  dat$Number <- as.factor(dat$Number)
  # manually center Number
  dat$c_Num <- ifelse(dat$Number=='Numeric', -.5, .5)
  # CONDITION
  # make a factor out of Condition, as f_Cnd
  dat$f_Cnd <- factor(dat$Condition, levels=c(1,2,3,4), labels=c('Vg:Nm', 'Cr:Nm', 'Vg:Vb', 'Cr:Vb'))
  # ORDER
  # give the levels of Order meaningful names
  dat$Order <- factor(dat$Order, levels=c(1,2), labels=c('LtoR','RtoL'))
  # make a manually centred Order
  dat$c_Ord <- ifelse(dat$Order=="LtoR",-.5,.5)
  # QUANTITY
  # give the levels of Quantity meaningful names
  dat$Quantity <- factor(dat$Quantity, levels=c(1,2), labels=c('Small','Large'))
  # make a manually centred Quantity
  dat$c_Qty <- ifelse(dat$Quantity=="Small",-.5,.5)
  # INSTRUCTION
  # add number of characters in the instruction # 29 30 34 36 38
  dat$nchar_instr = nchar(dat$Instruction)
  dat$nchar_instr_scaled = as.vector(scale(nchar(dat$Instruction), scale=TRUE))
  # make Instruction be a factor (17 levels)
  dat$Instruction <- as.factor(dat$Instruction)
  # RT
  # add transformations of RT
  dat$RT_log       <- log(dat$RT)
  dat$RT_raw       <- dat$RT
  # print to file a table with information about the design
  design_info <- unique(subset(dat, select=c(Item, Condition, Vagueness, Number, Quantity, Order, Left, Mid, Right, Exp_Num, Bline_Num, Extr_Num, Exp_side, Bline_side, Extr_side, Instruction)))
  design.info <- design_info[order(design_info$Item, design_info$Condition, design_info$Quantity, design_info$Order),]
  row.names(design_info) <- NULL
  capture.output(print.data.frame(design_info, row.names=F, print.gap=3, quote=F, right=F), file="design_info-table.txt")
  # Add discriminability metric with reference to item
  discriminability_range = c(0.7500000, 0.5294118, 0.4090909, 0.3333333)
  discriminability_range_scaled = c(1.3441995, 0.1316642, -0.5297187, -0.9461450)  
  discriminability = c(0.4875000, 0.3123529, 0.2308442, 0.1833333)
  discriminability_scaled = c(1.37582241, 0.06614191, -0.54334858, -0.89861574)
  dat[dat$Item == "06:15:24", "discriminability"] <- 0.4875000
  dat[dat$Item == "16:25:34", "discriminability"] <- 0.3123529
  dat[dat$Item == "26:35:44", "discriminability"] <- 0.2308442
  dat[dat$Item == "36:45:54", "discriminability"] <- 0.1833333
  # put dat in better column order
  dat <- subset(dat, select = c(id, Subject, Trial, Condition, Order, 
                                Quantity, Vagueness, Number, Item, discriminability, 
                                c_Trl, s_Trl, c_Itm, c_Vag, c_Num, f_Cnd, c_Ord, c_Qty,
                                RT, RT_log, RT_raw, Exp_Num, Bline_Num, 
                                Extr_Num, Exp_side, Bline_side, Extr_side, 
                                response_num, response_side, response_category, 
                                Left, Mid, Right, Instruction, nchar_instr))
  # This data set (dat) contains *all* trials 7680 including impossible trials and is mainly for graphs comparing different removals
  save(dat, file='data_raw.Rda')
  message('Returning processed data')
  return(dat)
} # end of function processData

## ----postProcessDataFunction, echo=FALSE---------------------------------
postProcessData = function(dat) {
  # dd removes impossible trials from dat
  # Throw out RT = 1 and RT = 59998, and RTprev = 1 and RTprev = 59998 i.e., throw out sticky fingers and timeouts, and the trials that followed sticky fingers and timeouts since they were likely affected by unusual previous trials. Also lose impossible trials
  dd <- dat
  dd$RT[dd$RT == 1 ] <- NA
  dd$RT[dd$RT == 59998 ] <- NA
  dd <- dd[complete.cases(dd),]
  row.names(dd) <- NULL
  # add preceding RT: because we removed impossible trials, the value for preceding RT for a trial following an impossible trial is the value of the trial that preceded the impossible trial.
  dd$RTprev <- NA
  for (s in levels(dd$Subject)) {
    nrows = nrow(dd[dd$Subject==s,])
    for (i in 1:nrows) {
      if (i==1) {dd[dd$Subject==s, "RTprev"][i] <- dd[dd$Subject==s, "RT"][i]}
      else
        dd[dd$Subject==s, "RTprev"][i] <- dd[dd$Subject==s, "RT"][i-1] }}
  # add transformations of previous RT
  dd$RTprev_log       <- log(dd$RTprev)
  dd$RTprev_raw       <- dd$RTprev
  # put dd in better column order
  dd <- subset(dd, select = c(id, Subject, Trial, Condition, Order, Quantity, Vagueness, Number, Item, discriminability, c_Trl, s_Trl, c_Itm, c_Vag, c_Num, f_Cnd, c_Ord, c_Qty, RT, RT_log, RT_raw, RTprev, RTprev_log, RTprev_raw, Exp_Num, Bline_Num, Extr_Num, Exp_side, Bline_side, Extr_side, response_num, response_side, response_category, Left, Mid, Right, Instruction, nchar_instr ))
  save(dd, file="data_processed.Rda")
  message('Returning post processed data')
  return(dd)
} # end of function postProcessResponses

## ----getTheData----------------------------------------------------------
# if the file data_processed.Rda already exists then load it, else do data wrangling
if( file.exists('../data_processed.Rda') ) {
  load('../data_processed.Rda')
} else {
  # declare local variables
  number_of_valid_subjects <- 30 # = 30
  number_of_rows <- 7680 # 7680
  number_of_trials_per_subject <- number_of_rows / number_of_valid_subjects # = 256
  # call functions
  dat <- gatherData(number_of_valid_subjects) # = 30
  dat <- classifyResponses(dat) # classify the response as expected, near, or far
  dat <- processData(dat) # remove impossible trials and re-do previous rt measures
  dd  <- postProcessData(dat)
} # end else do data wrangling



# subset dd
dd <- subset(dd, select=c(Subject, Trial, Condition, Left, Mid, Right, discriminability, 
                          Exp_side, Bline_side, Extr_side, response_side, Instruction, 
                          Vagueness, c_Vag, Number, c_Num, Order, c_Ord, Quantity, c_Qty, 
                          Item, c_Itm, response_category, RT, RT_log))
dd$isBorderline <- ifelse(dd$response_category=='borderline', TRUE, FALSE)

# write plain text file
write.table(dd, file='../data.txt')
