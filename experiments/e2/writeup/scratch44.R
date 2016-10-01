
```{r rSquaredInfo, echo=FALSE}
cat("R^2")
cor(fitted(v5), dd$RT_log)^2
```

```{r plotModelCoefsAndCis, fig.width=5.5, fig.height=4, fig.cap='Coefficient estimates and their (Wald) 95 per cent confidence intervals', fig.pos='hbtp', echo=FALSE}
# Plot model coefficients and ci's
dfr <- data.frame(coef = summary(v5)$coef[-1, 1], 
                  ci2.5  = confint(v5, method='Wald')[18:26, 1],
                  ci97.5 = confint(v5, method='Wald')[18:26, 2] )
dfr <- dfr[rev(rownames(dfr)),]
par(mar=c(5,10,1,1))
plot(y=1:nrow(dfr), 
     x=dfr$coef, 
     xlim=range(dfr$ci2.5, dfr$ci97.5), 
     type='n', axes=F, xlab="", ylab="")
abline(v=0, lty=3, col='grey')
abline(h=c(1,2,3,4,5,6,7,8,9), col='grey', lty=3)
arrows(y0=1:nrow(dfr), y1=1:nrow(dfr), 
       x0=dfr$ci2.5, x1=dfr$ci97.5, 
       length=0.035,
       col='black',
       lwd=2, code=3, angle=90)
points(y=1:nrow(dfr), x=dfr$coef, pch=21, bg='white')
axis(2, labels=row.names(dfr), at=1:nrow(dfr), las=1, tick=FALSE)
axis(1)
mtext("Coefficient estimates, in units of log(RT),\nwith 95% confidence intervals", side=1, line=3.5, cex.lab=1, las=1)
mtext("Model terms", side=2, line=8)
box(which='plot', col='grey')

```




```{r plotLMERfnc, fig.width=6, fig.height=4, fig.pos='hbtp', fig.cap='plotMLERfnc', echo=TRUE}
par(mfrow=c(2,4))
plotLMER.fnc(v5)

```



```{r baayenPLots99, fig.width=6, fig.height=4, fig.cap='Baayen Model Criticism Plots', fig.pos='hbtp', echo=FALSE}
# Baayen 4-plot model criticism
par(mfrow=c(1,3), pty='s')
# create scaled residuals
dd$rstand = as.vector(scale(resid(v5)))
# plot scaled residuals density
plot(density(dd$rstand))
# plot sample quantiles versus theoretical quantiles
qqnorm(dd$rstand, cex=.5)
qqline(dd$rstand)
# plot standardised residuals versus fitted values
plot(dd$rstand ~ fitted(v5), pch='.')
# absolute standardised residuals greater than 2.5 are candidates for being outliers, the abline identifies them on the plot
abline(h=c(-2.5,2.5))

```



#lmerTest Version

```{r lmerTestVersionOfModel, tidy=FALSE, cache=TRUE, echo=TRUE}
v6 <- lmerTest::lmer(data=dd,
                     RT_log ~
                       c_Vag + c_Num + c_Qty + c_Ord +
                       c_Num:c_Vag:c_Qty +
                       discriminability +
                       s_Trl +
                       RTprev_log +
                       nchar_instr +
                       (1+c_Vag + c_Num + c_Qty + c_Ord|Subject))
```

```{r summaryLmerTest, cache=TRUE}
summary(v6)
```


#Lmer model: after outlier removal
not done yet.

#Borderline responses

```{r barplotBorderline, fig.width=6, fig.height=4, echo=FALSE}
dd$response_category <- relevel(dd$response_category, ref = 'expected')
barplot(table(dd$Vagueness,dd$response_category), beside=TRUE, legend=TRUE, space=c(0,.5))

```

```{r tabBdl, echo=FALSE, results='asis'}
print(xtable(table(dd$response_category,dd$Vagueness),
             caption='Borderline cases counts'),
      table.placement='htbp',
      latex.environments='center',
      size='small')
```

