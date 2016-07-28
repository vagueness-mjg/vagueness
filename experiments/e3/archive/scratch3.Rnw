
<<getData, echo=TRUE>>=
  x=read.table("../data/data.txt")
  x$rt <- x$RT; x$RT <- NULL # for consistency
  x$logRT <- log(x$rt)
  x$recipRT <- -1000/x$rt
  # remove rt of 0
  (before <- nrow(x))
  x <- subset(x, rt>0)
  (after <- nrow(x))
  before - after
  @
    
    Set factors etc
  
  <<setFactors>>=
    x$vagueness <- factor(x$vagueness)
  contrasts(x$vagueness) <- contr.sum(2)/2
  x$selection <- factor(x$selection)
  contrasts(x$selection) <- contr.sum(2)/2
  x$cItm <- scale(x$Item)
  x$Item <- as.factor(x$Item)
  x$Subject <- as.factor(x$Subject)
  @
    
    Check contrasts
  
  <<checkContrasts>>=
    contrasts(x$vagueness)
  contrasts(x$selection)
  unique(x$cItm)
  @
    
    For the untrimmed data, show effects of transforming rt.
  
  \begin{marginfigure}
  <<plotDistributions, fig.width=4, fig.height=2, out.width="\\linewidth", echo=FALSE, fig.pos="Hhtbp", crop=TRUE>>=
    xs=melt(x,measure.vars=c("rt","logRT","recipRT"))
  densityplot(~value|variable,data=xs, ylab=NULL, xlab=NULL, yaxt=F, scales=list(x=list(relation="free",rot=45), y=list(relation="free",at=NULL)), cex=.2)
  @
    \caption{Untrimmed data}
  \end{marginfigure}
  
  Trim the data.
  
  <<trimData>>=
    data.trim <- perSubjectTrim.fnc(x, response="rt", subject="Subject", trim=2.5)
  @
    
    Check the distribution of the trimmed data to see if a transformation is suggested.
  
  \begin{marginfigure}
  <<checkTrim, fig.width=4, fig.height=2, out.width="\\linewidth", fig.pos="Hhtbp", echo=FALSE, crop=TRUE>>=
    xs=melt(data.trim$data,  measure.vars=c("rt","logRT","recipRT"))
  densityplot(~value|variable, data=xs, ylab=NULL, xlab=NULL, yaxt=F, scales=list(x=list(relation="free", rot=45), y=list(relation="free", at=NULL)), cex=.2)
  @
    \caption{Trimmed data}
  \end{marginfigure}
  
  Select either trimmed or untrimmed data.
  
  <<selectTrim>>=
    dat <- data.trim$data
  @
    
    Show means.
  
  \begin{figure}[htbp]
  <<plotMeans, echo=FALSE, fig.width=5, fig.height=3, out.width='.5\\linewidth', crop=TRUE>>=
    a=summarySEwithin(dat, measurevar="logRT", withinvars=c("vagueness","selection"), idvar="Subject", na.rm=TRUE)
  a$mygroup=paste(a$selection,a$vagueness)
  pd <- position_dodge(.05)
  ggplot(a, aes(x=vagueness, y=logRT, group=selection, col=mygroup, shape=mygroup, fill=mygroup, ymin=logRT-ci, ymax=logRT+ci)) + geom_errorbar(width=.1, position=pd) +  geom_line(position=pd) +  geom_point(position=pd,size=5) +  scale_colour_manual(values = c("black","black", "black", "black")) +   scale_shape_manual(values = c(21, 23, 21, 23)) + scale_fill_manual(values = c("black", "black", "white", "white")) + xlab("Vagueness") + theme(legend.title=element_blank())
  @
    \caption{Means for vagueness and selection}
  \end{figure}
  
  Edinburgh slides plot.
  
  \begin{figure}[htbp]
  <<plotMeansEdin, echo=FALSE, fig.width=9, fig.height=5>>=
    a=summarySEwithin(dat, measurevar="logRT", withinvars=c("vagueness","selection"), idvar="Subject", na.rm=TRUE)
  a$vagueness <- relevel(a$vagueness,ref="crisp")
  a$selection <- relevel(a$selection,ref="matching")
  a$mygroup=a$selection:a$vagueness
  a$mygroup=a$selection
  ggplot(a, aes(x=vagueness, y=logRT, group=selection, col=selection, ymin=logRT-ci, ymax=logRT+ci)) + 
    geom_errorbar(width=.1,lwd=1.1) +  
    geom_line(lwd=1.1) +  
    geom_point(size=5) +  
    scale_colour_manual(values = c("red","blue","red","blue")) +  
    #   scale_shape_manual(values = c(21, 23, 21, 23)) + 
    scale_fill_manual(values = c("blue", "blue", "white", "white")) +
    theme(legend.title=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_text(size=18,angle=0),
          axis.text.x=element_text(size=18),
          axis.text.y=element_text(size=18),
          panel.background=element_rect(),
          legend.text=element_text(size=15) ,
          legend.key.size=unit(1.5,"cm")) +
    scale_y_continuous(limits = c(7.05,7.505))
  @
    \caption{Means for vagueness and selection}
  \end{figure}
  
  
  Break the means down over items in response to significant 3-way interaction in the lm.
  
  \begin{figure}[htbp]
  <<PlotOfConditionMeansBrokenOverItems, fig.width=9, fig.height=2.9, out.width='\\linewidth',crop=TRUE, echo=FALSE>>=
    d2 <- summarySEwithin(dat, measurevar="logRT",withinvars=c("vagueness","selection", "Item"),idvar="Subject",na.rm=TRUE)
  d2$mygroup=paste(d2$selection,d2$vagueness)
  d2$Item <- paste("Item:",d2$Item,sep="")
  pd <- position_dodge(.1)
  ggplot(d2, aes(x=vagueness, y=logRT_norm, group=selection, col=selection, shape=selection, fill=selection,  ymin=logRT_norm-ci, ymax=logRT_norm+ci)) + geom_errorbar(width=.1, position=pd) + facet_grid(~Item) +  geom_line(position=pd) +  geom_point(position=pd, size=3) +  scale_colour_manual(values = c("black","black")) +   scale_shape_manual(values = c(21, 21)) + scale_fill_manual(values = c("black", "white")) + guides(col = guide_legend(reverse = TRUE, title="Task"), fill=guide_legend(reverse = TRUE, title="Task"), shape=guide_legend(reverse = TRUE, title="Task"))
  @
    \caption{Condition means broken down over items}
  \end{figure}
  
  Specify a lm model.
  
  <<lm1>>=
    lm1 <- lm(data=dat, logRT~vagueness*selection*cItm)
  @
    
    <<lm1-table, results='asis', echo=FALSE>>=
    print(xtable(summary(lm1),caption="lm model"), table.placement="htbp")
  @
    
    Specify a random-intercepts-only model.
  
  <<rimodel>>=
    lmer.rt.ri <- lmer(data=dat, formula=logRT~vagueness*selection*cItm+ (1|Subject)) 
  @
    
    Specify a maximal model.
  
  <<mxmodel, cache=TRUE>>=
    # this doesn't converge
    lmer.rt.mx <- lmer(data=dat, formula=logRT~vagueness*selection*cItm+ (vagueness*selection*cItm|Subject)) 
  @
    
    Drop highest-order interaction random slope for effects involving cItm.
  
  <<mmmodel0, cache=TRUE>>=
    # this doesn't converge
    lmer.rt.mm0 <- lmer(data=dat, formula=logRT~vagueness*selection*cItm+ (vagueness*selection+cItm|Subject)) 
  @
    
    Drop highest-order interaction random slope for effects involving selection.
  
  <<mmmodel1, cache=TRUE>>=
    # this converges
    lmer.rt.mm1 <- lmer(data=dat, formula=logRT~vagueness*selection*cItm+ (vagueness+selection+cItm|Subject)) 
  @
    
    <<modelTables, results='asis', echo=FALSE>>=
    print(xtable(summary(lmer.rt.mm1)$coefficients, digits=3))
  @
    
    Check the residuals of the most maximal model that converges.
  
  \begin{marginfigure}
  <<qq, fig.width=5, fig.height=5, crop=TRUE, fig.pos='htbp', out.width="\\linewidth", echo=FALSE>>=
    qqPlot(residuals(lmer.rt.mm1), cex=.2)
  @
    \caption{Model residuals for the most maximal model that converges}
  \end{marginfigure}
  
  Vagueness appears to be beneficial in the comparison condition. Do a focussed comparison.
  
  <<datc>>=
    datc.lmer <- lmer(data=dat, subset=selection=="comparison", formula=logRT~vagueness*cItm+ (vagueness+cItm|Subject))
  @
    
    <<datc-table, results='asis', echo=FALSE>>=
    print(xtable(summary(datc.lmer)$coef,caption="Restricted to comparison condition"))
  @
    
    Vagueness appears to be detrimental in the matching condition. Do a focussed comparison.
  
  <<datm>>=
    datm.lmer <- lmer(data=dat, subset=selection=="matching", formula=logRT~vagueness*cItm+ (vagueness+cItm|Subject))
  @
    
    <<datm-table, results='asis', echo=FALSE>>=
    print(xtable(summary(datm.lmer)$coef,caption="Restricted to matching condition"))
  @