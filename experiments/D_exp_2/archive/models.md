Vagueness experiment 4 models
========================================================





```r
suppressPackageStartupMessages(library(lme4, quietly = TRUE, warn.conflicts = FALSE))
suppressPackageStartupMessages(library(lmerTest, quietly = TRUE, warn.conflicts = FALSE))
```


Set anova contrasts


```r
anova.contrast <- matrix(c(-0.5, -0.5, 0.5, 0.5, -0.5, 0.5, -0.5, 0.5, 0.5, 
    -0.5, -0.5, 0.5), 4, 3, dimnames = list(c("comparison:crisp", "comparison:vague", 
    "matching:crisp", "matching:vague"), c("selection", "vagueness", "selectionXvagueness")))
contrasts(x$Effect) <- anova.contrast
```


Do omnibus lmer using custom anova contrast.


```r
maximal.lmer <- lmer(data = x, logRT ~ Effect + (Effect | Item) + (Effect | 
    Subject))
```


Planned comparisons crisp versus vague at each level of selection.

Comparison vague versus comparison crisp.


```r
comparison.lmer <- lmer(data = x, subset = selection == "comparison", logRT ~ 
    vagueness + (vagueness | Item) + (vagueness | Subject))
```


Matching vague versus matching crisp.


```r
matching.lmer <- lmer(data = x, subset = selection == "matching", logRT ~ vagueness + 
    (vagueness | Item) + (vagueness | Subject))
```






```r
maximal.lmer
```

```
## Linear mixed model fit by REML 
## Formula: logRT ~ Effect + (Effect | Item) + (Effect | Subject) 
##    Data: x 
##    AIC   BIC logLik deviance REMLdev
##  10182 10354  -5066    10114   10132
## Random effects:
##  Groups   Name                      Variance Std.Dev. Corr                
##  Subject  (Intercept)               0.19498  0.4416                       
##           Effectselection           0.03253  0.1804    0.245              
##           Effectvagueness           0.00491  0.0701    0.115 -0.293       
##           EffectselectionXvagueness 0.00957  0.0978   -0.027  0.114  0.270
##  Item     (Intercept)               0.00168  0.0410                       
##           Effectselection           0.00497  0.0705   -0.012              
##           Effectvagueness           0.00861  0.0928   -1.000  0.026       
##           EffectselectionXvagueness 0.01307  0.1143   -0.971  0.249  0.975
##  Residual                           0.22309  0.4723                       
##  
##  
##  
##  
##  
##  
##  
##  
##  
##  
## Number of obs: 7294, groups: Subject, 38; Item, 4
## 
## Fixed effects:
##                           Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                7.40233    0.07471    99.1   <2e-16 ***
## Effectselection            0.19475    0.04713     4.1   0.0037 ** 
## Effectvagueness            0.00482    0.04902     0.1   0.9273    
## EffectselectionXvagueness  0.07754    0.06034     1.3   0.2780    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##             (Intr) Effcts Effctv
## Effectslctn  0.143              
## Effectvgnss -0.234 -0.024       
## EffctslctnX -0.259  0.195  0.890
```

```r
comparison.lmer
```

```
## Linear mixed model fit by REML 
## Formula: logRT ~ vagueness + (vagueness | Item) + (vagueness | Subject) 
##    Data: x 
##  Subset: selection == "comparison" 
##   AIC  BIC logLik deviance REMLdev
##  4539 4595  -2261     4511    4521
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr   
##  Subject  (Intercept) 0.183987 0.4289          
##           vagueness1  0.003036 0.0551   -0.161 
##  Item     (Intercept) 0.002874 0.0536          
##           vagueness1  0.000238 0.0154   -1.000 
##  Residual             0.190138 0.4360          
## Number of obs: 3648, groups: Subject, 38; Item, 4
## 
## Fixed effects:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   7.3050     0.0749    97.5   <2e-16 ***
## vagueness1    0.0364     0.0138     2.6    0.026 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##            (Intr)
## vagueness1 -0.296
```

```r
matching.lmer
```

```
## Linear mixed model fit by REML 
## Formula: logRT ~ vagueness + (vagueness | Item) + (vagueness | Subject) 
##    Data: x 
##  Subset: selection == "matching" 
##   AIC  BIC logLik deviance REMLdev
##  5630 5686  -2806     5605    5612
## Random effects:
##  Groups   Name        Variance Std.Dev. Corr   
##  Subject  (Intercept) 0.22225  0.4714          
##           vagueness1  0.00420  0.0648   -0.025 
##  Item     (Intercept) 0.00278  0.0528          
##           vagueness1  0.01049  0.1024   0.684  
##  Residual             0.25628  0.5062          
## Number of obs: 3646, groups: Subject, 38; Item, 4
## 
## Fixed effects:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   7.4997     0.0813    92.2   <2e-16 ***
## vagueness1   -0.0412     0.0529    -0.8     0.49    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Correlation of Fixed Effects:
##            (Intr)
## vagueness1 0.210
```



PLot the comparison vague versus comparison crisp


```r
x2 <- subset(x, subset = selection == "comparison", select = c(Subject, Item, 
    vagueness, RT))
```

