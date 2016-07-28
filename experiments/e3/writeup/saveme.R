
```{r,checkTrim, fig.width=3, fig.height=3}
xs=melt(dd,  measure.vars=c("RT","logRT","recipRT"))
densityplot(~value|variable,data=xs,
            ylab=NULL,xlab=NULL,yaxt=F,
            scales=list(x=list(relation="free",rot=45),y=list(relation="free",at=NULL)),
            cex=.2, layout=c(3,1))
```

# RT analysis, with all items
## RT means

```{r}
var1=ddply(d, .(Vagueness), summarise, RT=mean(RT, na.rm=TRUE))
var1
```

Vagueness main effect in RT is \Sexpr{round(var1[1,"RT"]-var1[2,"RT"])} ms

```{r}
var2=ddply(d, .(Selection), summarise, RT=mean(RT,na.rm=TRUE))
var2
```

Task main effect in RT is \Sexpr{round(var2[1,"RT"]-var2[2,"RT"])} ms

```{r}
var3=ddply(d, .(Vagueness,Selection), summarise, RT=mean(RT, na.rm=TRUE))
var3
```

View the average times for each item.

```{r, rtitems}
ddply(d, .(Item.char), summarise, RT=mean(RT, na.rm=TRUE))
```

View the condition means broken down over items.

```{r, response-time-one-panel, fig.width=8, fig.height=5}
rts <- summarySEwithin(d, measurevar="logRT", withinvars=c("Selection","Vagueness","Item.char"))
rts$condition=paste(rts$Selection,rts$Vagueness, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(rts, aes(y=logRT_norm, x=Item.char, ymin=logRT_norm-ci, ymax=logRT_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Response time") + 
  ylab("log RT") + 
  xlab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), legend.key = element_blank() )
```

View the condition means broken down over items, with separate panels for comparison and matching.

```{r, response-time-two-panels, fig.width=8, fig.height=5}
rts <- summarySEwithin(d, measurevar="logRT", withinvars=c("Selection","Vagueness","Item.char"))
rts$condition=paste(rts$Selection,rts$Vagueness, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(rts, aes(y=logRT_norm, x=Item.char, ymin=logRT_norm-ci, ymax=logRT_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Response time") + 
  ylab("log RT") + 
  xlab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), legend.key = element_blank() ) +
  facet_grid(~Selection)
```

## RT analysis, with all items

Build a maximal lmer model of RT.

```{r, rtmodel, echo=TRUE, cache=TRUE}
#backing off from maximal model to avoid warnings
lmer.logRT.mm0 <- lmer(
  data=d, 
  logRT~
    Selection.sum * Vagueness.sum * cItm + 
    (Selection.sum * Vagueness.sum + cItm | Subject) )
lmer.logRT.mm0.summary <- summary(lmer.logRT.mm0)
```

Print a table of coefficients.

```{r, rtmodeltable, results='asis', echo=FALSE}
print(xtable(
  digits=c(0,2,2,1,1,3), 
  lmer.logRT.mm0.summary$coefficients,  
  table.placement='Hhtbp'), type='html')
```

```{r, resudualslmerrt, fig.width=3, fig.height=3}
qqPlot(residuals(lmer.logRT.mm0))
```

Separate analyses for the comparison and matching conditions (RT).

Comparison conditions only RT.
```{r, sep1-comparison}
lmer.logRT.selection <- lmer(data=d, subset=Selection=="comparison", 
                             logRT~Vagueness.sum*cItm + (Vagueness.sum+cItm|Subject))
```

Vagueness speeds up responses in the comparison conditions significantly (RT).

```{r, sep1-comparison-table, results='asis'}
print(xtable(digits=3, summary(lmer.logRT.selection)$coefficients, caption="Comparison only"), type='html')
```

Matching conditions only.

```{r,sep2-matching}
lmer.logRT.matching <- lmer(data=d, subset=Selection=="matching", 
                            logRT~Vagueness.sum*cItm + (Vagueness.sum+cItm|Subject))
```

Vagueness slows down responses in the matching conditions significantly.

```{r,sep2-matching-table, results='asis',echo=FALSE}
print(xtable(summary(digits=3, lmer.logRT.matching)$coefficients, caption="Matching only"), type='html')
```

## RT analysis, after removing item 1

The reason for trying an analysis removing item one is that the very fast times for item one are likely due, not to the manipulations of interest, but to the very small ratio differences between the numbers of dots in the square. This skews the model leading to spurious interactions with item.

```{r,remove-item-one}
dd <- subset(d, Item.char!="6:15:24")
```

View the data less item one, in two panels.

```{r,response-time-two-panels-no1, fig.width=8, fig.height=5}
rts <- summarySEwithin(dd, measurevar="logRT", withinvars=c("Selection","Vagueness","Item.char"))
rts$condition=paste(rts$Selection,rts$Vagueness, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(rts, aes(y=logRT_norm, x=Item.char, ymin=logRT_norm-ci, ymax=logRT_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Response time") + 
  ylab("log RT") + 
  xlab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), legend.key = element_blank() ) +
  facet_grid(~Selection)
```

Build a maximal lmer model of RT less item one.

```{r, rtmodel-no1}
#backing off from maximal model to avoid warnings
lmer.logRT.mm0.no1 <- lmer(
  data=dd, 
  logRT~
    Selection.sum * Vagueness.sum * cItm + 
    (Selection.sum * Vagueness.sum + cItm | Subject) )
lmer.logRT.mm0.no1.summary <- summary(lmer.logRT.mm0.no1)
```

Print a table of coefficients for the model less item one.

```{r,rtmodeltable-no1, results='asis', echo=FALSE}
print(xtable(
  digits=c(0,2,2,1,1,3), 
  lmer.logRT.mm0.no1.summary$coefficients), type='html')
```

View residuals

```{rresudualslmerrt-no1, fig.width=3, fig.height=3}
qqPlot(residuals(lmer.logRT.mm0.no1))
```

Do the separate analyses for vageness effect at each level of selection task.

Comparison conditions only RT.
```{r, sep1-comparison-dd}
lmer.logRT.selection.dd <- lmer(data=dd, subset=Selection=="comparison", 
                                logRT~Vagueness.sum*cItm + (Vagueness.sum+cItm|Subject))
```

Vagueness 

```{r, sep1-comparison-table-dd, results='asis'}
print(xtable(digits=3, summary(lmer.logRT.selection.dd)$coefficients, caption="Comparison only"), type='html')
```

Matching conditions only.

```{r, sep2-matching-dd}
lmer.logRT.matching.dd <- lmer(data=dd, subset=Selection=="matching", 
                               logRT~Vagueness.sum*cItm + (Vagueness.sum+cItm|Subject))
```

Vagueness 

```{r, sep2-matching-table-dd, results='asis'}
print(xtable(summary(digits=3, lmer.logRT.matching.dd)$coefficients, caption="Matching only"), type='html')
```

# BD analysis

First, we want to know what the distribution was of (1) choosing the `best' square; (2) choosing the `borderline' square (3) choosing the `worst' square.

How often did people choose the borderline square? (as percent of total)

```{r, echo=FALSE}
round(table(dat$switchResponseFactor) / nrow(d) * 100, 0)
```

Visualise how often people chose the borderline square

```{r, hist1, out.width="2in", echo=FALSE}
bwtheme <- standard.theme("pdf", color=FALSE)
histogram(data=d, ~ switchResponseFactor , type='percent', col='grey', xlab=NULL, par.settings=bwtheme)
```

How often did people choose the borderline square broken down for Vagueness (as percent of total).

```{r}
round(table(dat$Vagueness, dat$switchResponseFactor) / nrow(d) * 100, 0)
```

```{r,histbd2,fig.width=4}
bwtheme <- standard.theme("pdf", color=FALSE)
histogram(data=d, ~ switchResponseFactor | Vagueness, type='percent', col='grey', xlab=NULL, par.settings=bwtheme)
```

How often did people choose the borderline square broken down for Selection (as percent of total).

```{r}
round(table(dat$Selection, dat$switchResponseFactor) / nrow(d) * 100, 0)
```

```{r, histbd3, fig.width=4}
bwtheme <- standard.theme("pdf", color=FALSE)
histogram(data=d, ~ switchResponseFactor | Selection, type='percent', col='grey', xlab=NULL, par.settings=bwtheme)
```

Percent of borderline cases, all conditions, ignoring item

```{r, histbd4, fig.width=4}
bwtheme <- standard.theme("pdf", color=FALSE)
histogram(data=d, ~ switchResponseFactor | Selection :Vagueness, type='percent', col='grey', xlab=NULL, par.settings=bwtheme, layout=c(4,1))
```

Percent of borderline cases, all conditions, all items (histogram).

```{r, bdhist, fig.width=4}
bwtheme <- standard.theme("pdf", color=FALSE)
histogram(data=d, ~ switchResponseFactor | Item.char * Vagueness : Selection,
          col="grey", par.settings=bwtheme )
```

Percent of borderline cases, all conditions (lineplot)

```{r, bordelinecasesbd, fig.width=8, fig.height=7}
dat$isResponseNearPercent <- as.numeric(dat$isResponseNear)*100
bds <- summarySEwithin(d, measurevar="isResponseNearPercent", 
                       withinvars=c("Selection","Vagueness","Item.char"))
bds$condition=paste(bds$Selection,bds$Vagueness, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(bds, aes(y=isResponseNearPercent_norm, x=Item.char, ymin=isResponseNearPercent_norm-ci,
                ymax=isResponseNearPercent_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Percent of responses that identified the borderline case") + 
  ylab("percent") + 
  xlab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank())
```

Percent of boderline cases, comparing Vague and Crisp.

```{r, borderlineVagueness,fig.width=8,fig.height=7}
dat$isResponseNearPercent <- as.numeric(dat$isResponseNear)*100
bds <- summarySEwithin(d, measurevar="isResponseNearPercent", 
                       withinvars=c("Vagueness","Item.char"))
bds$condition=paste(bds$Vagueness, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(bds, aes(y=isResponseNearPercent_norm, x=Item.char, ymin=isResponseNearPercent_norm-ci,
                ymax=isResponseNearPercent_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Percent of responses that identified the borderline case") + 
  ylab("percent") + 
  xlab("1=6:15:24, 2=16:25:34, 3=26:35:44, 4=36:45:54") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank())
```

Percent of borderline cases, comparing Numeric and Verbal

```{r ,bdsSel,fig.width=8,fig.height=7}
dat$isResponseNearPercent <- as.numeric(dat$isResponseNear)*100
bds <- summarySEwithin(d, measurevar="isResponseNearPercent", 
                       withinvars=c("Selection","Item.char"))
bds$condition=paste(bds$Selection, sep= ' ')
dodge = position_dodge(width=0.2)
ggplot(bds, aes(y=isResponseNearPercent_norm, x=Item.char, ymin=isResponseNearPercent_norm-ci,
                ymax=isResponseNearPercent_norm+ci, 
                group=condition, shape=condition, fill=condition)) +
  geom_line(position=dodge) + 
  geom_errorbar(width=.2, position=dodge) + 
  geom_point(size=4, position=dodge) + 
  scale_shape_manual("",values = c(22, 22, 21, 21)) + 
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Percent of responses that identified the borderline case") + 
  ylab("percent") + 
  xlab("1=6:15:24, 2=16:25:34, 3=26:35:44, 4=36:45:54") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank())
```

Borderline cases model.

```{r, borderlinecasesmodel, echo=TRUE, cache=TRUE}
lmer.bd.mm0 <- glmer(data=d, 
                     isResponseNear ~ 
                       Selection.sum * Vagueness.sum * cItm 
                     + (Selection.sum * Vagueness.sum + cItm | Subject), 
                     family=binomial, 
                     control=glmerControl(optimizer="bobyqa"))
lmer.bd.summary <- summary(lmer.bd.mm0)
```

```{r, results='asis'}
print(xtable(digits=3,lmer.bd.summary$coefficients,
             caption="The most maximal model of bd that converges"),type='html')
```

```{r, residualslmerbd, fig.width=3, fig.height=3}
qqPlot(residuals(lmer.bd.mm0))
```
