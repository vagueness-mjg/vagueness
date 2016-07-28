Vagueness experiment 4 graphs
========================================================




RT cutoffs: subset=RT>0&RT<49000




Show distribution of response times.







![plot of chunk showtransform](figure/showtransform.png) 


Show distribution separately for each group.

First way.




![plot of chunk density2](figure/density2.png) 





Second way

![plot of chunk showway2dist](figure/showway2dist.png) 


Boxplot with mean indicator.

![plot of chunk boxplot1](figure/boxplot1.png) 








Show the main effects of vagueness and selection separately.

![plot of chunk showmaineffects](figure/showmaineffects.png) 












Show the Selection x Vagueness interaction.

![plot of chunk selxvag](figure/selxvag.png) 





Probability of an extreme response.

![plot of chunk pexshow](figure/pexshow.png) 



Plots for poster preCogSci 2013


```r
poda = summarySEwithin(x, measurevar = "RT", withinvars = c("vagueness", "selection", 
    "Item"), idvar = "Subject")
poda$mygroup <- paste(poda$selection, poda$vagueness)
```




```r
cogsci = ggplot(data = poda, aes(y = RT, ymin = RT - ci, ymax = RT + ci, x = Item, 
    group = mygroup, col = mygroup, shape = mygroup, fill = mygroup)) + geom_errorbar(position = position_dodge(width = 0.2), 
    width = 0.2) + geom_line(position = position_dodge(width = 0.2)) + geom_point(position = position_dodge(width = 0.2), 
    size = 4) + xlab("Dots") + ylab("Reaction time (ms)") + scale_colour_manual(values = c("red", 
    "blue", "red", "blue")) + scale_shape_manual(values = c(21, 21, 23, 23)) + 
    scale_fill_manual(values = c("red", "blue", "white", "white")) + ggtitle(label = "Forced choice task") + 
    theme(legend.key = element_blank(), legend.title = element_blank(), legend.text = element_text(face = "bold", 
        size = 12), legend.key.size = unit(c(1.5, 1.5), "lines"), axis.title.x = element_text(face = "bold", 
        size = 12, vjust = -1.5), axis.title.y = element_text(face = "bold", 
        size = 12, angle = 90, vjust = -0.01), plot.title = element_text(face = "bold", 
        size = 14, vjust = 1.5), plot.margin = unit(c(2, -9, 2, 2), "lines"), 
        panel.background = element_rect(fill = "white", colour = "black"))
```


Show cogsci plot

```r
print(cogsci)
```

![plot of chunk ShowCogSciPlot](figure/ShowCogSciPlot.png) 




```r
pdf(file = "figure/precogsci2013e4.pdf", width = 7, height = 5)
print(cogsci)
dev.off()
```

```
## pdf 
##   2
```


```{bwhitevxs}
b <- summarySEwithin(x,measurevar="RT",withinvars=c("vagueness","selection"), idvar="Subject")
b$mygroup=paste(b$selection, b$vagueness)
pd=position_dodge(0.1)
ggplot(data=b,aes(y=RT,x=vagueness,group=selection,col=mygroup,shape=mygroup,fill=mygroup,ymax=RT+ci,ymin=RT-ci))+geom_errorbar(position=pd, width=.1)+geom_line(position=pd)+geom_point(position=pd,size=4)+  scale_colour_manual(values = c("black","black", "black", "black")) +   scale_shape_manual(values = c(21, 23, 21, 23)) +    scale_fill_manual(values = c("black", "black", "white","white"))
```

