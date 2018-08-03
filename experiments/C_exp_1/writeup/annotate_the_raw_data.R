annotate_the_raw_data = function (dat) {
  
  # annotate vagueness
  dat[ dat$Condition==1 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==2 , 'Vagueness'] <- 'Crisp'
  dat[ dat$Condition==3 , 'Vagueness'] <- 'Vague'
  dat[ dat$Condition==4 , 'Vagueness'] <- 'Crisp'
  dat$Vagueness <- as.factor(dat$Vagueness)
  
  # annotate use of a number / word in the instructions
  dat[ dat$Condition==1 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==2 , 'Number'] <- 'Numeric'
  dat[ dat$Condition==3 , 'Number'] <- 'Verbal'
  dat[ dat$Condition==4 , 'Number'] <- 'Verbal'
  dat$Number <- as.factor(dat$Number)
  
  # annotate Item
  dat$Item <- factor(dat$Item, levels=c(1,2,3,4), labels=c("06:15:24", "16:25:34", "26:35:44", "36:45:54"))
  
  # annotate Order
  dat$Order <- factor(dat$Order, levels=c(1,2), labels=c('LtoR','RtoL'))
  
  # annotate Quantity
  dat$Quantity <- factor(dat$Quantity, levels=c(1,2), labels=c('Small','Large'))
  
  # annotate Subject
  dat$Subject <- factor(paste("s",sprintf("%02d",dat$Subject),sep=""))
  
  # annotate Trial index for each participant (1:256 trials for 30 subjects)
  dat$Trial = rep(x = 1:256, times = 30)
  
  # add an Observation index, over the whole data set (1:7680)
  dat$Obs <- 1:7680
  
  # remove variables that don't matter for purposes of RT analysis
  #dat <- select(dat, Obs, Trial, Instruction, Subject, Item, Quantity, Order, Vagueness, Number, response_category, isBorderline, RT)
  
  return(dat)
}  


