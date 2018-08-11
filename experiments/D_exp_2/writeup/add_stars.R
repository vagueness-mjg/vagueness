add_stars = function(modl) {
  
  require(broom.mixed)
  
  coef_table <- as.data.frame(tidy(modl, effects="fixed"))
  
  # be sensitive to whether the model is an lmer or a glmer 
  
  if (class(modl) == "lmerModLmerTest") {
    
    # sort the names out
    names(coef_table) <- c("effect", "term", "coefficient", "std.error", "df", "t_value", "p_value_raw")
    coef_table$p_value <- as.character("")
    coef_table$star <- as.character("")
    
    # categorise p values and add significance stars
    for (i in 1:nrow(coef_table)) {
      if (!is.na(coef_table$p_value_raw[i])) {
        if (coef_table$p_value_raw[i] >= 0     & coef_table$p_value[i] < 0.001) {coef_table$p_value[i] <-    "<0.001"; coef_table$star[i] <- "***"}
        if (coef_table$p_value_raw[i] >= 0.001 & coef_table$p_value[i] < 0.01 ) {coef_table$p_value[i] <-    "<0.01"; coef_table$star[i] <- "**"}
        if (coef_table$p_value_raw[i] >= 0.01  & coef_table$p_value[i] < 0.05 ) {coef_table$p_value[i] <-    "<0.05"; coef_table$star[i] <- "*"}
        if (coef_table$p_value_raw[i] >= 0.05  ) {coef_table$p_value[i] <-    round(coef_table$p_value_raw[i],3); coef_table$star[i] <-  ""}
      }
    }

    # convert numerics to formatted chars for pretty printing
    coef_table$coefficient <- format(x=coef_table$coefficient, nsmall=2, digits=2)
    coef_table$std.error   <- format(x=coef_table$std.error, nsmall=2, digits=2)
    coef_table$df          <- format(x=coef_table$df, nsmall=2, digits=1)
    coef_table$t_value     <- format(x=coef_table$t_value, nsmall=2, digits=2)
    coef_table$p_value_raw <- format(x=coef_table$p_value_raw, nsmall=2, digits=3)
    
    # select rows and cols
    coef_table <- coef_table %>%
      select(-effect) %>%
      filter(term!="(Intercept)") 
    
    return(coef_table)
  
  }
  
  if (class(modl) == "glmerMod") {
    
    # sort the names out
    names(coef_table) <- c("effect", "term", "coefficient", "std.error", "z_value", "p_value_raw")
    coef_table$p_value <- as.character("")
    coef_table$star <- as.character("")
    
    # categorise p values and add significance stars
    for (i in 1:nrow(coef_table)) {
      if (!is.na(coef_table$p_value_raw[i])) {
        if (coef_table$p_value_raw[i] >= 0     & coef_table$p_value[i] < 0.001) {coef_table$p_value[i] <-    "<0.001"; coef_table$star[i] <- "***"}
        if (coef_table$p_value_raw[i] >= 0.001 & coef_table$p_value[i] < 0.01 ) {coef_table$p_value[i] <-    "<0.01"; coef_table$star[i] <- "**"}
        if (coef_table$p_value_raw[i] >= 0.01  & coef_table$p_value[i] < 0.05 ) {coef_table$p_value[i] <-    "<0.05"; coef_table$star[i] <- "*"}
        if (coef_table$p_value_raw[i] >= 0.05  ) {coef_table$p_value[i] <-    round(coef_table$p_value_raw[i],3); coef_table$star[i] <-  ""}
      }
    }
    
    # convert numerics to formatted chars for pretty printing
    coef_table$coefficient <- format(x=coef_table$coefficient, nsmall=2, digits=2)
    coef_table$std.error   <- format(x=coef_table$std.error, nsmall=2, digits=2)
    coef_table$df          <- format(x=coef_table$df, nsmall=2, digits=1)
    coef_table$z_value     <- format(x=coef_table$z_value, nsmall=2, digits=2)
    coef_table$p_value_raw <- format(x=coef_table$p_value_raw, nsmall=2, digits=3)

    
    # kable styling etc
    coef_table <- coef_table %>%
      select(-effect) %>%
      filter(term!="(Intercept)") %>%
      kable(align='rrlrrrl', caption=mycaption) %>% 
      kable_styling(full_width = F, position = "left", font_size = 11)
    
    return(coef_table)
  }
  
}