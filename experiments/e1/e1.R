## ----pander, echo=FALSE--------------------------------------------------
library(pander)

## ----showInstructions, echo = FALSE--------------------------------------
v = c("crisp","vague")
e <- c("Choose the the square with many dots", "Choose the square with 20 dots")
i = data.frame(v, e)
names(i) = c("vagueness", "example instruction")
pander(i, justify=c('center', 'left'))

## ----showItems, echo=FALSE-----------------------------------------------
items = c(1,2,3,4,5,6,7,8)
i = data.frame(Gap = c("05","10","15","20"),
               x = c("25:20","25:15","25:10","25:05"),
               z = c("25:30","25:35","25:40","25:45") )
names(i) = c('Gap Size', 'Small Target', 'Large Target')
pander(i, justify=c('center', 'center', 'center'))

## ----loadLibraries, message=FALSE, echo = FALSE--------------------------
library(knitr); library(ggplot2); library(xtable); library(gridExtra); library(lme4); library(lmerTest);  library(data.table); library(dplyr); library(dtplyr); library(pander); source('summarySEwithin2.R') 

## ----separateDataFramesForRTandErrorAnalyses, echo=T---------------------
rawdata <- read.table('data.txt', sep=' ')
rtdata <- subset(rawdata, error==FALSE)
erdata <- rawdata

## ----computeSummariesForGraphs, cache=TRUE-------------------------------
rtdataplot1 = summarySEwithin2(rtdata,  measurevar="logrt",  withinvars=c("Vgn","Gap"), idvar="subject")
erdataplot1 <- summarySEwithin2(erdata, measurevar="error", withinvars=c("Vgn","Gap"), idvar="subject")

## ----rtplot, echo = FALSE------------------------------------------------
dodge=.06
rtplot = ggplot(rtdataplot1, aes(y=logrtNormed, x=Gap, group=Vgn, fill=Vgn, shape=Vgn, ymin=logrtNormed-ci, ymax=logrtNormed+ci)) + 
  geom_line(position=position_dodge(dodge)) + 
  geom_errorbar(width=.3, lty=1, position=position_dodge(dodge)) + 
  geom_point(pch=21, size=3, position=position_dodge(dodge)) +
  ggtitle("Response time") + 
  ylab("log RT") + 
  xlab("Gap Size") +
  scale_fill_grey(name=element_blank(), start=0, end=1) +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank() ) +
  theme(aspect.ratio=1) + xlab("")

## ----erplot, echo=FALSE--------------------------------------------------
dodge=.06
erplot = ggplot(erdataplot1, aes(y=errorNormed, x=Gap, group=Vgn, fill=Vgn, shape=Vgn, ymin=errorNormed-ci, ymax=errorNormed+ci)) + 
  geom_line(position=position_dodge(dodge)) + 
  geom_errorbar(width=.3, lty=1, position=position_dodge(dodge)) + 
  geom_point(pch=21, size=3, position=position_dodge(dodge)) +
  ggtitle("Error rate") + 
  ylab("error rate") + 
  xlab("Gap Size") +
  scale_fill_grey(name=element_blank(), start=0,end=1)+
  theme_bw()+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank() )+
  theme(aspect.ratio=1) + xlab("")

## ----plotRTandErrorRates, fig.width=10, fig.height=4, message=FALSE, echo=FALSE----
grid.arrange(rtplot, erplot, ncol=2)

## ----showVersions, echo=FALSE, comment=NA--------------------------------
cat (paste(sep="", 
           c("lmerTest version "), c(packageDescription("lmerTest", fields = "Version")),
           "; ", 
           c("lme4 version "), c(packageDescription("lme4", fields = "Version"))) ) 

## ----computeLmerModels, cache = TRUE, tidy=FALSE-------------------------
rt.lmer.1 <- lmerTest::lmer(
  data=rtdata, logrt ~ c_Vgn * c_Gap + (c_Vgn * c_Gap|subject))
rt.lmer.2 <- lmerTest::lmer(
  data=rtdata, logrt ~ c_Vgn * c_Gap + c_Ord + c_Qty + (c_Vgn * c_Gap + c_Ord + c_Qty | subject))
ac.lmer.1 <- lme4::glmer(
  data = erdata, error ~ c_Vgn * c_Gap + (c_Vgn * c_Gap | subject), 
  family="binomial", control = glmerControl(optimizer = "bobyqa"))
ac.lmer.2 <- lme4::glmer(
  data = erdata, error ~ c_Vgn * c_Gap + c_Ord + c_Qty + (c_Vgn * c_Gap + c_Ord + c_Qty | subject), 
  family="binomial", control = glmerControl(optimizer = "bobyqa"))

## ---- results='asis', echo=F---------------------------------------------
print(
  xtable(rtdataplot1,
         caption='Condition means'),
  include.rownames=FALSE,
  caption.placement='top',
  type='html')

## ----tableRTmodelSimple, results='asis', echo=FALSE, cache=TRUE----------
x = as.data.frame(format(summary(rt.lmer.1)$coef, scientific=FALSE), stringsAsFactors = FALSE)

for (i in 1:(ncol(x)-1)) {
  for (j in 1:nrow(x)) {
    x[j,i] <-  substr(x[j,i], start=1, stop=7)
  }
}

for (i in 1:(ncol(x)-1)) {
  x[,i] <- as.numeric(x[,i])
}

for (i in ncol(x)) {
  for (j in 1:nrow(x)) {
    x[j,i] <-  substr(x[j,i], start=1, stop=7)
  }
}
print(
  xtable(
    align='lrrrrr', 
    digits=c(0,  2,2,2,2,3),
    x,
    caption="Simple response time model"), 
    caption.placement="top", 
  type='html')

## ----tableRTmodelMaximal, results='asis', echo=FALSE, cache=TRUE---------
x = as.data.frame(format(summary(rt.lmer.2)$coef, scientific=FALSE), stringsAsFactors = FALSE)

for (i in 1:(ncol(x)-1)) {
  for (j in 1:nrow(x)) {
    x[j,i] <-  substr(x[j,i], start=1, stop=7)
  }
}

for (i in 1:(ncol(x)-1)) {
  x[,i] <- as.numeric(x[,i])
}

for (i in ncol(x)) {
  for (j in 1:nrow(x)) {
    x[j,i] <-  substr(x[j,i], start=1, stop=7)
  }
}
print(
  xtable(
    align='lrrrrr', 
    digits=c(0,  2,2,2,2,3),
    x,
    caption="Maximal response time model"), 
    caption.placement="top", 
  type='html')

## ----erdataplot1, results='asis', echo=F---------------------------------
print(
  xtable(erdataplot1,
         caption='Condition means'),
  include.rownames=FALSE,
  caption.placement='top',
  type='html')

## ----tableErrorModelsimple, results='asis', cache=TRUE, echo=FALSE-------
print(
  xtable(summary(
    ac.lmer.1)$coefficients,
         digits=3, 
         caption="Simple error rates model"),
         caption.placement="top", type='html')

## ----tableErrorModelMaximal, results='asis', cache=TRUE, echo=FALSE------
print(
  xtable(
    digits=3, summary(
      ac.lmer.2)$coefficients,
             caption="Maximal error rates model"),
             caption.placement="top", type='html')

