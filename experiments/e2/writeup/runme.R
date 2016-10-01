source('e2-preprocessing.R')
if( file.exists('e2-b-data.txt') ) {
  dd <- read.delim('e2-b-data.txt')
} else { 
  dat <- gatherData() 
  dat <- declareImpossibleRT(dat)
  dat <- removeImpossibleTrials(dat)
  dat <- subset(dat, select=c(Subject, Trial, Item, 
                              discriminability, 
                              Instruction,
                              nchar_instr,
                              Vagueness, Number, Order, Quantity, 
                              c_Vag, c_Num, c_Ord, c_Qty,
                              NaType, response_category, 
                              isBorderline, RT)
  )
  write.table(dat, file='e2-b-data.txt', sep='\t', quote=FALSE)
  dd <- read.delim('e2-b-data.txt')
} 

