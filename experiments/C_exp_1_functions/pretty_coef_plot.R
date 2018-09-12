pretty_coef_plot = function(modl, mycaption) {
  dwplot(tidy(modl, effects="fixed")) + 
    theme(panel.background = element_rect(colour="black", fill="white"), panel.grid = element_blank()) + 
    geom_vline(xintercept=0, alpha=0.2) + 
    ggtitle(paste(mycaption, 'coefficient estimates'), subtitle = paste('deviation from an intercept of', round(summary(modl)$coefficients[1,1],2), 'log RT, with 95% CI.'))
}