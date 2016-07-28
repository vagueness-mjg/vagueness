
<<lmer-rt-1, echo=FALSE, cache=FALSE>>=
  # rt model at word level
  lmer.rt <- lmer(data=d, rt~aggregation*similarity*nconj + wlen + (1|subject) + (1|item))
@

<<lmer-msch-1>>=
  # msch model at word level
  lmer.msch <- lmer(data=d, msch~aggregation*similarity*nconj + wlen + (1|subject) + (1|item))
@

<<lmer-rat-1>>=
  # rating ratings model at sentence level
  dr <- unique(subset(d, select=c(subject,id,item,aggregation,similarity,nconj,rating)))
lmer.DIF <- glmer(data=dr, rating ~ nconj*aggregation*similarity + (1|subject) + (1|item), family=poisson)
@

<<lmer-error-1>>=
  # error rates model at sentence level
  derr <- unique(subset(d, select=c(subject,id,item,aggregation,similarity,nconj,error)))
lmer.ERROR <- glmer(data=derr, error~nconj+aggregation+similarity + (1|subject) + (1|item), family=binomial)
@

<<overviewallmeasures, echo=FALSE, fig.path="e1aggreg-writeup-figs/", fig.height=3, fig.width=9, fig.show='hide'>>=
  d5 <- melt(d, measure.vars=c("rt","rating","error"))
grandmeans <- dcast(d5, similarity+aggregation+nconj~variable, function(x)mean(x,na.rm=TRUE))
g.data <- melt(grandmeans, measure.vars=c("rt","rating","error"))
ggplot(data=g.data, aes(y=value, x=nconj, shape=similarity, linetype=aggregation, group=similarity:aggregation))  +   facet_wrap(~variable, scales="free_y") +   geom_point(aes(shape=similarity),size=3) +   geom_line() +  theme(legend.key = element_blank()) 
@

<<plotCoefsWithCisrt, echo=FALSE, fig.path="e1aggreg-writeup-figs/", fig.height=5, fig.width=7, fig.show='hide'>>=
  xvals=as.character(names((summary(lmer.rt)$coefficients)[,3]))
yvals=as.numeric((summary(lmer.rt)$coefficients)[,3])
coef_values <- as.numeric(summary(lmer.rt)$coefficients[,1])
st_err <- as.numeric(summary(lmer.rt)$coefficients[,2])
upperCI <-  coef_values + 1.96*st_err
lowerCI <-  coef_values  - 1.96*st_err
z=data.frame(x=xvals,y=yvals,coef_values=coef_values,upperCI=upperCI,lowerCI=lowerCI)
ggplot(data=z,aes(x=x,y=coef_values,ymin=lowerCI,ymax=upperCI)) + geom_errorbar() + theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1)) + geom_hline(aes(yintercept=0,color="red"))+scale_x_discrete("",label=function(x) abbreviate(x, minlength=200))+ggtitle("rt coefficients with 95% CIs")+scale_y_continuous("contribution to rt (ms)")
@

<<plotCoefsWithCismsch, fig.path="e1aggreg-writeup-figs/",  fig.height=5, fig.width=7, fig.show='hide', echo=FALSE>>=
  xvals=as.character(names((summary(lmer.msch)$coefficients)[,3]))
yvals=as.numeric((summary(lmer.msch)$coefficients)[,3])
coef_values <- as.numeric(summary(lmer.msch)$coefficients[,1])
st_err <- as.numeric(summary(lmer.msch)$coefficients[,2])
upperCI <-  coef_values + 1.96*st_err
lowerCI <-  coef_values  - 1.96*st_err
z=data.frame(x=xvals,y=yvals,coef_values=coef_values,upperCI=upperCI,lowerCI=lowerCI)
ggplot(data=z,aes(x=x,y=coef_values,ymin=lowerCI,ymax=upperCI)) + geom_errorbar() + theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1)) + geom_hline(aes(yintercept=0,color="red"))+scale_x_discrete("",label=function(x) abbreviate(x, minlength=200))+ggtitle("msch coefficients with 95% CIs")+scale_y_continuous("contribution to ms per character")
@

<<plotCoefsWithCisDIF, fig.path="e1aggreg-writeup-figs/",  fig.height=5, fig.width=7, fig.show='hide', echo=FALSE>>=
  xvals=as.character(names((summary(lmer.DIF)$coefficients)[,3]))
yvals=as.numeric((summary(lmer.DIF)$coefficients)[,3])
coef_values <- as.numeric(summary(lmer.DIF)$coefficients[,1])
st_err <- as.numeric(summary(lmer.DIF)$coefficients[,2])
upperCI <-  coef_values + 1.96*st_err
lowerCI <-  coef_values  - 1.96*st_err
z=data.frame(x=xvals,y=yvals,coef_values=coef_values,upperCI=upperCI,lowerCI=lowerCI)
ggplot(data=z,aes(x=x,y=coef_values,ymin=lowerCI,ymax=upperCI)) + geom_errorbar() + theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1)) + geom_hline(aes(yintercept=0,color="red"))+scale_x_discrete("",label=function(x) abbreviate(x, minlength=200))+ggtitle("rating Ratings (1--7) coefficients with 95% CIs")+scale_y_continuous("contribution to rating (1--7)")
@

<<plotCoefsWithCisERROR, fig.path="e1aggreg-writeup-figs/",  fig.height=5, fig.width=7, fig.show='hide', echo=FALSE>>=
  xvals=as.character(names((summary(lmer.ERROR)$coefficients)[,3]))
yvals=as.numeric((summary(lmer.ERROR)$coefficients)[,3])
coef_values <- as.numeric(summary(lmer.ERROR)$coefficients[,1])
st_err <- as.numeric(summary(lmer.ERROR)$coefficients[,2])
upperCI <-  coef_values + 1.96*st_err
lowerCI <-  coef_values  - 1.96*st_err
z=data.frame(x=xvals,y=yvals,coef_values=coef_values,upperCI=upperCI,lowerCI=lowerCI)
ggplot(data=z,aes(x=x,y=coef_values,ymin=lowerCI,ymax=upperCI)) + geom_errorbar() + theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1)) + geom_hline(aes(yintercept=0,color="red"))+scale_x_discrete("",label=function(x) abbreviate(x, minlength=200))+ggtitle("error rates coefficients with 95% CIs")+scale_y_continuous("contribution to error Rates (0--1)")
@

<<plotMainEffectOfAggregationrt, fig.width=7, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  pwc.rt <- summarySEwithin(d, measurevar = "rt", withinvars = c("aggregation", "similarity", "nconj"), na.rm = T)
pwc.rt$mygroup = paste(pwc.rt$similarity, pwc.rt$aggregation)
ggplot(data = pwc.rt, aes(y = rt, x = nconj, ymin = rt - ci, ymax = rt + ci, group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), size = 4) + scale_colour_manual(values = c("black","black", "black", "black")) + scale_shape_manual(values = c(21, 21, 23, 23)) + scale_fill_manual(values = c("black", "white", "black", "white")) + facet_grid(~similarity) +  xlab("Number of Conjuncts") + ylab("Mean response time (ms)") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<plotMainEffectOfAggregationmschInteractionSimxNCNJ23, fig.width=5, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  dD <- subset(d, nconj%in%c("2","3"))
pwc.rt <- summarySEwithin(dD, measurevar = "rt", withinvars = c("similarity", "nconj"), na.rm = T)
pwc.rt$mygroup = paste(pwc.rt$similarity)
ggplot(data = pwc.rt, aes(y = rt, x = nconj, ymin = rt - ci, ymax = rt + ci, group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), size = 4) + scale_colour_manual(values = c("black","black")) + scale_shape_manual(values = c(17,24)) + scale_fill_manual(values = c("black", "white")) + xlab("Number of Conjuncts") + ylab("rt") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<plotMainEffectOfAggregationrtXnotsig, fig.width=7, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  dD <- subset(d, nconj%in%c("2","3"))
pwc.rt <- summarySEwithin(dD, measurevar = "rt", withinvars = c("aggregation", "similarity", "nconj"), na.rm = T)
pwc.rt$mygroup = paste(pwc.rt$similarity, pwc.rt$aggregation)
ggplot(data = pwc.rt, aes(y = rt, x = nconj, ymin = rt - ci, ymax = rt + ci, group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), size = 4) + scale_colour_manual(values = c("black","black", "black", "black")) + scale_shape_manual(values = c(21, 21, 23, 23)) + scale_fill_manual(values = c("black", "white", "black", "white")) + facet_grid(~aggregation) +  xlab("Number of Conjuncts") + ylab("Mean response time (ms)") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<plotMainEffectOfAggregationmsch, fig.width=7, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  pwc.msch <- summarySEwithin(d, measurevar = "msch", withinvars = c("aggregation", "similarity", "nconj"), na.rm = T)
pwc.msch$mygroup = paste(pwc.msch$similarity, pwc.msch$aggregation)
ggplot(data = pwc.msch, aes(y = msch, x = nconj, ymin = msch - ci, ymax = msch + ci, group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), size = 4) + scale_colour_manual(values = c("black","black", "black", "black")) + scale_shape_manual(values = c(21, 21, 23, 23)) + scale_fill_manual(values = c("black", "white", "black", "white")) + facet_grid(~similarity) + xlab("Number of Conjuncts") + ylab("ms per character") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<plotMainEffectOfAggregationDIF, fig.width=7, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  pwc.RAT <- summarySEwithin(d,measurevar="rating",withinvars=c("aggregation","similarity","nconj"),na.rm=T)
pwc.RAT$mygroup=paste(pwc.RAT$similarity,pwc.RAT$aggregation)
ggplot(data=pwc.RAT, aes(y=rating, x=nconj, ymin=rating-ci, ymax=rating+ci, group=mygroup, col=mygroup, shape=mygroup, fill=mygroup)) + geom_errorbar(position=position_dodge(width=.2), width=.2) + geom_line(position=position_dodge(width=.2)) +   geom_point(position=position_dodge(width=.2),size=4) + facet_grid(~similarity) + scale_colour_manual(values = c("black","black", "black", "black")) + scale_shape_manual(values = c(21, 21, 23, 23)) + scale_fill_manual(values = c("black", "white", "black", "white")) + xlab("Number of Conjuncts") + ylab("Mean difficulty rating") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<plotMainEffectOfAggregationERROR, fig.width=7, fig.height=3, echo=FALSE, fig.show='hide', fig.path='e1aggreg-writeup-figs/'>>=
  pwc.ERROR <- summarySEwithin(d, measurevar = "error", withinvars = c("aggregation", "similarity", "nconj"), na.rm = T)
pwc.ERROR$mygroup = paste(pwc.ERROR$similarity, pwc.ERROR$aggregation)
ggplot(data = pwc.ERROR, aes(y = error, x = nconj, ymin = error - ci, ymax = error + ci, group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), size = 4) + scale_colour_manual(values = c("black","black", "black", "black")) + scale_shape_manual(values = c(21, 21, 23, 23)) + scale_fill_manual(values = c("black", "white", "black", "white")) + facet_grid(~similarity) + xlab("Number of Conjuncts") + ylab("error rate (0--1)") + theme(legend.key = element_blank(), legend.title = element_blank())
@

<<ComparisonAt3conjuncts, echo=FALSE, fig.width=5, fig.height=3, fig.show='hide',fig.path="e1aggreg-writeup-figs/">>=
  d.restricted <- subset(d, nconj == 3 & similarity == "Similar")
teqiv <- summarySEwithin(d.restricted, measurevar = "rt", withinvars = c("aggregation", "similarity", "nconj"), na.rm = T)
ggplot(data=teqiv, aes(y=rt, x=aggregation, ymin=rt-ci, ymax=rt+ci)) + geom_errorbar(stat='identity',width=.2) + geom_point(stat='identity',size=4) + ylab("Mean rt (ms)")
@

\clearpage
\section{Data frame summary}
%%% Data Summary

<<summary>>=
  summary(d)
@
\clearpage
<<structure>>=
  str(d)
@
\clearpage
\begin{figure}[htbp]
<<scatter.withoutliers,echo=F,fig.width=7,fig.height=5, fig.path="e1aggreg-writeup-figs/">>=
  ggplot(data=d.withoutlier,aes(y=rt,x=trial,color=aggregation))+geom_point(na.rm=T)
@
\caption{Raw data with no outliers removed}
\end{figure}

\clearpage
\begin{figure}[htbp]
<<scatter,echo=F,fig.width=7,fig.height=5, fig.path="e1aggreg-writeup-figs/">>=
  ggplot(data=d,aes(y=rt,x=trial,color=aggregation))+geom_point(na.rm=T)
@
\caption{Raw data with one outlier removed. These are the data that we pursue in the analyses}
\end{figure}

\clearpage
\section{Overview all measures}
\begin{figure}[htbp]
\includegraphics[width=.9\textwidth]{e1aggreg-writeup-figs/overviewallmeasures}
\caption{All measures}
\end{figure}

%%% RESPONSE TIMES
\clearpage
\section{Response Time Results}


\subsection{Plots trying to show the main effects from the lmer}
\begin{figure}[htbp]
<<plotMainEffectOfAggregationrt, fig.path="e1aggreg-writeup-figs/", fig.width=7, fig.height=3, echo=FALSE>>=
  @
\caption{Mean rt}
\label{labelmeanrt}
\end{figure}

\begin{figure}[htbp]
\begin{center}
\includegraphics[width=.6\textwidth]{e1aggreg-writeup-figs/plotMainEffectOfAggregationmschInteractionSimxNCNJ23}
\caption{This plots the similarity x nconj3-2 interaction. The only reason for focussing here is that in an earlier model, this was significant. Removing the outlier changed that, and so did changing wlen to a numeric non-factor predictor.}
\label{significantinteraction}
\end{center}
\end{figure}

\begin{figure}[htbp]
<<plotMainEffectOfAggregationrtXnotsig, fig.width=7, fig.height=3, echo=FALSE, fig.show='asis', fig.path='e1aggreg-writeup-figs/'>>=
  @
\caption{This shows that the once-significant similarity x nconj3-2 interaction is not modulated by aggregation}
\label{nosiginteractionwithaggrgation}
\end{figure}

\clearpage
\subsection{Focused comparisons on RT at 3 conjuncts similar}
Pit at 3 conjuncts similar aggregated versus similar not-aggregated.
Planned comparison shows the contrast is not reliable. Manual coefs = ($\beta$=, SE=, t=, p=).
\begin{figure}[htbp]
\begin{center}
\includegraphics[width=.6\textwidth]{e1aggreg-writeup-figs/ComparisonAt3conjuncts}
\end{center}
\caption{Data are response times for 3-conjunct sentences only, in the similar condition, with 95\% confidence intervals around the mean - (the mean is represented as the point)}
\end{figure}
<<plannedContrast1, results='asis', echo=FALSE>>=
  # restrict data for planned comparison
  d.restricted <- subset(d, nconj == 3 & similarity == "Similar")
pc1 <- lmer(data=d.restricted, rt~aggregation + wlen + (aggregation|subject) + (aggregation|item))
print(xtable(round(summary(pc1)$coefficients,3),caption="Table of coefficients for the specific comparison at 3 conjuncts similar"), caption.placement="top")
@


\clearpage
\subsection{Coefficients from the main model of rt}
<<fullCoefsrtModel,  results='asis', echo=FALSE>>=
  print(xtable(summary(lmer.rt)$coefficients,digits=c(1,1,1,1,3),caption="Coefficients for the model of Response Times"),caption.placement="top")
@

\begin{table}[htbp]
\centering
\caption{(manual) (significant) Coefficients for the model of Response Times} 
\begin{tabular}{rrrrr}
\hline
& Estimate & Std. Error & t value & $p$ \\ 
\hline
aggregation & &&& \\ 
word length & &&& \\  
\hline
\end{tabular}
\end{table}


\begin{figure}[htbp]
<<plotCoefsWithCisrt,echo=FALSE, fig.width=7, fig.height=5, fig.path="e1aggreg-writeup-figs/">>=
  @
\caption{Coefficients and confidence intervals from model of rt per word}
\label{fig::rtcoefs}
\end{figure}

\clearpage
\subsection{Verbal descriptions of the RT results}
\paragraph{Aggregation}Aggregation led to increased reading times when compared with unaggregated controls.

\paragraph{Interaction similarity x number of conjunctions (3 vs 2)}The difference between response times for 3 and 2 conjuncts was reliably mediated by similarity, but the interaction effect was not reliably mediated by aggregation. 
%The nature of the interaction is that comparing 3 with 2 conjuncts, in the dissimilar condition reading times tended to be longer, in the similar condition, times tended to get shorter. 

When similar and dissimilar forms are compared at 2 and 3 conjuncts, the dissimilar forms tend to get more difficult as the number of conjuncts grows, but in contrast the similar forms tend to get easier as the number of conjuncts grows. The tendencies are reliably different from each other.


%%% MSCH

\clearpage
\section{Milliseconds per character measure (msch)}

\begin{figure}[htbp]
<<plotMainEffectOfAggregationmsch,fig.width=7, fig.height=3, echo=FALSE, fig.path="e1aggreg-writeup-figs/">>=
  @ 
\caption{Mean ms per character}
\label{lebelmeanmsch}
\end{figure}

<<fullCoefsmschModel,  results='asis', echo=FALSE>>=
  print(xtable(summary(lmer.msch)$coefficients,digits=c(1,1,1,1,3),caption="Coefficients for the model of ms per character"),caption.placement="top")
@
\begin{figure}[htbp]
<<plotCoefsWithCismsch, echo=FALSE, fig.height=5, fig.width=7, fig.path="e1aggreg-writeup-figs/">>=
  @
\caption{Coefficients and confidence intervals from model of ms per char}
\label{fig::MSCHcoefs}
\end{figure}


%%% DIFFICULTY RATING
\clearpage
\section{Difficulty Rating Results}
This is the difficulty ratings results.

Main points of ratings analysis.

Similarity is reliable - dissimilar is rated harder than similar (coef=, SE=, z=, p).

Aggregation is not reliable (coef=, SE=, z=, p).


\begin{figure}[htbp]
<<plotMainEffectOfAggregationDIF, fig.path="e1aggreg-writeup-figs/", fig.width=7, fig.height=3, echo=FALSE>>=
  @
\caption{Mean difficulty ratings}
\label{labelmeandiff}
\end{figure}

<<fullCoefsDiffModel, results='asis', echo=FALSE>>=
  print(xtable(round(summary(lmer.DIF)$coefficients,4),caption="Coefficients for the model of rating Ratings 1--7"),caption.placement="top")
@
\begin{figure}[htbp]
<<plotCoefsWithCisDIF, echo=FALSE, fig.height=5, fig.path="e1aggreg-writeup-figs/">>=
  @
\caption{Coefficients and confidence intervals from model of rating Ratings per sentence}
\label{fig::DIFcoefs}
\end{figure}


%%% ERROR RATES 

\clearpage
\section{Error Rates Results}
This is the error rates results
\begin{figure}[htbp]
<<plotMainEffectOfAggregationERROR, fig.width=7, fig.height=3, fig.path="e1aggreg-writeup-figs/", echo=FALSE>>=
  @
\caption{Mean comprehension errors}
\label{labelmeanerror}
\end{figure}

<<fullCoefserrorModel, results='asis', echo=FALSE>>=
  print(xtable(round(summary(lmer.ERROR)$coefficients,3),caption="Coefficients for the model of error Rates"),caption.placement="top")
@
\begin{figure}[htbp]
<<plotCoefsWithCisERROR, fig.path="e1aggreg-writeup-figs/", echo=FALSE, fig.height=5>>=
  @
\caption{Coefficients and confidence intervals from model of comprehension error per sentence}
\label{fig::ERRcoefs}
\end{figure}
