## ----loadLibs------------------------------------------------------------
suppressPackageStartupMessages(library(knitr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(xtable))
suppressPackageStartupMessages(library(gridExtra))
suppressPackageStartupMessages(library(lme4))
suppressPackageStartupMessages(library(lmerTest)) 
suppressPackageStartupMessages(library(data.table)) 
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(dtplyr))  
source('summarySEwithin2.R') 

## ----separateDataFramesForRTandErrorAnalyses, echo=T---------------------
dat <- read.table('data.txt', sep=' ')
str(dat)
erdata <- dat
rtdata <- subset(dat, error==FALSE)

## ----rtplot, message=FALSE-----------------------------------------------
(rtdataplot1 = summarySEwithin2(rtdata,  measurevar="logrt",  withinvars=c("Vgn","Gap"), idvar="subject"))
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
rtplot

## ----tableRTmodelSimple, results='asis'----------------------------------
print(
  xtable(
    digits=3, 
    summary(
      rt.lmer <- lmer(data=rtdata, logrt ~ c_Vgn * c_Gap + (c_Vgn * c_Gap|subject))
    )$coefficients,
    caption="a response time model", 
    caption.placement="top"), type='html')

## ----tableRTmodelMaximal, results='asis'---------------------------------
print(
  xtable(
    digits=3, 
    summary(
      rt.lmer <- lmer(data=rtdata, logrt ~ c_Vgn * c_Gap + c_Ord + c_Qty + 
                        (c_Vgn * c_Gap + c_Ord + c_Qty | subject))
    )$coefficients,
    caption="Most maximal response time model", 
    caption.placement="top"), type='html')

## ----erplot--------------------------------------------------------------
(erdataplot1 <- summarySEwithin2(erdata, measurevar="error", withinvars=c("Vgn","Gap"), idvar="subject"))
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
erplot

## ----tableErrorModelsimple, results='asis', cache=TRUE-------------------
print(
  xtable(
    digits=3, summary(
      ac.lmer <- glmer(data = erdata, error ~ c_Vgn * c_Gap + (c_Vgn * c_Gap | subject), 
                       family="binomial", 
                       control = glmerControl(optimizer = "bobyqa")))$coefficients,
             caption="an accuracy model",
             caption.placement="top"), type='html')

## ----tableErrorModelMaximal, results='asis', cache=TRUE------------------
print(
  xtable(
    digits=3, summary(
      ac.lmer <- glmer(data = erdata, error ~ c_Vgn * c_Gap + c_Ord + c_Qty + (c_Vgn * c_Gap + c_Ord + c_Qty | subject), 
                       family="binomial", 
                       control = glmerControl(optimizer = "bobyqa")))$coefficients,
             caption="Most maximal accuracy model",
             caption.placement="top"), type='html')

## ----plotRTandErrorRates, fig.width=10, fig.height=4, message=FALSE------
grid.arrange(rtplot, erplot, ncol=2)

## ----stateVersions-------------------------------------------------------
sessionInfo()

