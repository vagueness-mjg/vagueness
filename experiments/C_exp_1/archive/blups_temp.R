par(mfrow=c(3,2))
plot(ranef(m2)$Subject,type="n",main="m2 subj BLUPS")
text(ranef(m2)$Subject, labels=rownames(ranef(m2)$Subject), cex=.7)
abline(h=0,lty=3);abline(v=0,lty=3)
plot(coef(m2)$Subject,type="n",main="m2 subj coefficients")
text(coef(m2)$Subject, labels=rownames(coef(m2)$Subject), cex=.7)
abline(h=0,lty=3)


plot(ranef(m3)$Subject,type="n",main="m3 subj BLUPS")
text(ranef(m3)$Subject, labels=rownames(ranef(m3)$Subject), cex=.7)
abline(h=0,lty=3);abline(v=0,lty=3)
plot(coef(m3)$Subject,type="n",main="m3 subj coefficients")
text(coef(m3)$Subject, labels=rownames(coef(m3)$Subject), cex=.7)
abline(h=0,lty=3)


plot(ranef(m3)$f_Itm,type="n",main="m3 item BLUPS")
text(ranef(m3)$f_Itm, labels=rownames(ranef(m3)$f_Itm), cex=.7)
abline(h=0,lty=3);abline(v=0,lty=3)
plot(coef(m3)$f_Itm,type="n",main="m3 item coefficients")
text(coef(m3)$f_Itm, labels=rownames(coef(m3)$f_Itm), cex=.7)
abline(h=0,lty=3)
