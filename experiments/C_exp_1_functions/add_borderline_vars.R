add_borderline_vars = function (dat) {
  
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
  
  # remove function-internal variables before returning the df
  dat$RESPONSE <- NULL
  dat$Exp_Num <- NULL
  dat$Bline_Num <- NULL
  dat$Extr_Num <- NULL
  dat$Exp_side <- NULL
  dat$Bline_side <- NULL
  dat$Extr_side <- NULL
  dat$response_num <- NULL
  dat$response_side <- NULL

  return(dat)
} 