pretty_coef_table = function(modl, mycaption){
  
  coef_table <- tidy(modl, effects="fixed") 

  # be sensitive to whether the model is an lmer or a glmer 
  
  if (class(modl) == "lmerModLmerTest") {
    
    # sort the names out
    names(coef_table) <- c("effect", "term", "coefficient", "std.error", "df", "t_value", "p_value_raw")
    coef_table$p_value <- as.character("")
    coef_table$star <- as.character("")
    
    # categorise p values and add significance stars
    # "\u2007" is a space the same width as a numeric, that is preserved in printing
    # "\u0020" is just a space
    for (i in 1:nrow(coef_table)) {
      if (!is.na(coef_table$p_value_raw[i])) {
        if (coef_table$p_value_raw[i] >= 0     & coef_table$p_value[i] < 0.001) {coef_table$p_value[i] <-    "<0.001";                        coef_table$star[i] <- paste(sep="","\uFF0A","\uFF0A","\uFF0A")}
        if (coef_table$p_value_raw[i] >= 0.001 & coef_table$p_value[i] < 0.01 ) {coef_table$p_value[i] <-    paste(sep="","<0.01", "\u2007"); coef_table$star[i] <- paste(sep="","\uFF0A","\uFF0A"," ")}
        if (coef_table$p_value_raw[i] >= 0.01  & coef_table$p_value[i] < 0.05 ) {coef_table$p_value[i] <-    paste(sep="","<0.05", "\u2007"); coef_table$star[i] <- paste(sep="","\uFF0A"," "," ")}
        if (coef_table$p_value_raw[i] >= 0.05  ) {coef_table$p_value[i] <-    round(coef_table$p_value_raw[i],3); coef_table$star[i] <-  ""}
      }
    }
    # un-tibble the table
    coef_table <- coef_table %>% as.data.frame()
    
    # convert numerics to formatted chars for pretty printing
    coef_table$coefficient <- format(x=coef_table$coefficient, nsmall=2, digits=2)
    coef_table$std.error   <- format(x=coef_table$std.error, nsmall=2, digits=2)
    coef_table$df          <- format(x=coef_table$df, nsmall=2, digits=1)
    coef_table$t_value     <- format(x=coef_table$t_value, nsmall=2, digits=2)
    coef_table$p_value_raw <- format(x=coef_table$p_value_raw, nsmall=2, digits=3)
    
    # "\u2007" is a space the same width as a numeric, that is preserved in printing
    names(coef_table)[3] <- paste(sep="","\uD835\uDEFD","\u2007")            #'\u03B2' beta
    names(coef_table)[4] <- paste(sep="","\u2007","s.e.")                    # s.e.
    names(coef_table)[5] <- paste(sep="","\u2007","d.f.")                    # d.f
    names(coef_table)[6] <- paste(sep="","\uD835\uDC61","\u2007")            # t
    names(coef_table)[7] <- paste(sep="","\uD835\uDC5D","\u2007","\u2007")   # p
    names(coef_table)[8] <- paste(sep="","Pr(>|t|)")                         # Pr(>|t|)
    names(coef_table)[9] <- paste(sep="","\u2007","sig.")                    # sig.
    
    # kable styling etc
    coef_table <- coef_table %>%
      select(-effect) %>%
      filter(term!="(Intercept)") %>%
      kable(align='rrllrrrl', caption=mycaption) %>% 
      kable_styling(full_width = F, position = "left", font_size = 11) 
    
    return(coef_table)
  }
  
  if (class(modl) == "glmerMod") {
  
    # sort the names out
    names(coef_table) <- c("effect", "term", "coefficient", "std.error", "z_value", "p_value_raw")
    coef_table$p_value <- as.character("")
    coef_table$star <- as.character("")
    
    # categorise p values and add significance stars
    # "\u2007" is a space the same width as a numeric, that is preserved in printing
    # "\u0020" is just a space
    for (i in 1:nrow(coef_table)) {
      if (!is.na(coef_table$p_value_raw[i])) {
        if (coef_table$p_value_raw[i] >= 0     & coef_table$p_value[i] < 0.001) {coef_table$p_value[i] <-    "<0.001";                        coef_table$star[i] <- paste(sep="","\uFF0A","\uFF0A","\uFF0A")}
        if (coef_table$p_value_raw[i] >= 0.001 & coef_table$p_value[i] < 0.01 ) {coef_table$p_value[i] <-    paste(sep="","<0.01", "\u2007"); coef_table$star[i] <- paste(sep="","\uFF0A","\uFF0A"," ")}
        if (coef_table$p_value_raw[i] >= 0.01  & coef_table$p_value[i] < 0.05 ) {coef_table$p_value[i] <-    paste(sep="","<0.05", "\u2007"); coef_table$star[i] <- paste(sep="","\uFF0A"," "," ")}
        if (coef_table$p_value_raw[i] >= 0.05  ) {coef_table$p_value[i] <-    round(coef_table$p_value_raw[i],3); coef_table$star[i] <-  ""}
      }
    }
    # un-tibble the table
    coef_table <- coef_table %>% as.data.frame()
    
    # convert numerics to formatted chars for pretty printing
    coef_table$coefficient <- format(x=coef_table$coefficient, nsmall=2, digits=2)
    coef_table$std.error   <- format(x=coef_table$std.error, nsmall=2, digits=2)
    coef_table$z_value     <- format(x=coef_table$z_value, nsmall=2, digits=2)
    coef_table$p_value_raw <- format(x=coef_table$p_value_raw, nsmall=2, digits=3)
    
    # "\u2007" is a space the same width as a numeric, that is preserved in printing
    names(coef_table)[3] <- paste(sep="","\uD835\uDEFD","\u2007")            #'\u03B2' beta
    names(coef_table)[4] <- paste(sep="","\u2007","s.e.")                    # s.e.
    names(coef_table)[5] <- paste(sep="","\ud835\udc67","\u2007")            # z
    names(coef_table)[6] <- paste(sep="","\uD835\uDC5D","\u2007","\u2007")   # p
    names(coef_table)[7] <- paste(sep="","Pr(>|z|)")                         # Pr(>|z|)
    names(coef_table)[8] <- paste(sep="","\u2007","sig.")                    # sig.  
    
    # kable styling etc
    coef_table <- coef_table %>%
      select(-effect) %>%
      filter(term!="(Intercept)") %>%
      kable(align='rrlrrrl', caption=mycaption) %>% 
      kable_styling(full_width = F, position = "left", font_size = 11)
    
    return(coef_table)
  }

  
  
}