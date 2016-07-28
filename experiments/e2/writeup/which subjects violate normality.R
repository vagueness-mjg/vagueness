# which subjects violate normality
f = function(dfr) return(shapiro.test(dfr$logRT)$p.value)
p = as.vector(by(dat, dat$Subject, f))
names(p) = levels(dat$Subject)
names(p[p < 0.05])
length(names(p[p < 0.05]))
qqmath(~logRT | Subject, data = dat,
       prepanel = prepanel.qqmathline,
       panel = function(x, ...) {
         panel.qqmathline(x, ...)
         panel.qqmath(x, ...)
       })
