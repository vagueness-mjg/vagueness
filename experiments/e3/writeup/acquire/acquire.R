rm(list=ls())
x <- read.delim("allresults.txt")
x[x$Condition %in% c(1,3),"vagueness"] <- "vague"
x[x$Condition %in% c(2,4),"vagueness"] <- "crisp"
x$vagueness <- factor(x$vagueness)
contrasts(x$vagueness) <- contr.sum(2)
x[x$Condition %in% c(1,2),"selection"] <- "matching"
x[x$Condition %in% c(3,4),"selection"] <- "comparison"
x$selection <- factor(x$selection)
contrasts(x$selection) <- contr.sum(2)
x <- subset(x,subset=RT>0&RT<49000)
x$cRT <- scale(x$RT, scale=F)
x$logRT <- log(x$RT)
x$cLogRT <- scale(x$logRT,scale=F)
x$Item <- as.factor(x$Item)
x$Subject <- as.factor(x$Subject)
x$Effect <- x$selection:x$vagueness
x$TARGET<-"TARGET"
x[x$Order==1&x$Quantity==1,"TARGET"] <- "LEFT"
x[x$Order==1&x$Quantity==2,"TARGET"] <- "RIGHT"
x[x$Order==2&x$Quantity==1,"TARGET"] <- "RIGHT"
x[x$Order==2&x$Quantity==2,"TARGET"] <- "LEFT"
x$EXTREME <- ifelse(x$TARGET==x$RESPONSE,1,0)
x <- subset(x, select=c(Subject,Item,vagueness,selection, Effect,RT,logRT,EXTREME))
save(x, file="e4vagueness.RData")
