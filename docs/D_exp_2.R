## ---- echo=FALSE, message=FALSE------------------------------------------
library(knitr)
library(tidyverse)
library(broom)
library(broom.mixed)
library(lme4)
library(lmerTest)
library(dotwhisker)
library(kableExtra)
library(LMERConvenienceFunctions)
library(data.table)
library(grid)
library(gridExtra)
source("D_exp_2_functions/preprocessing.R")
source("D_exp_2_functions/pretty_coef_table.R")
source("D_exp_2_functions/summarySEwithin2.R")
root_dir <- getwd()
data_dir <- "D_exp_2_data"

## ------------------------------------------------------------------------
dat_full <- preprocessing(root_dir, data_dir)
dat <- subset(dat_full, subset=RT>0 & RT<25000) # loses 2 RTs that were judged to be outliers 25978 49871
dat_borderline <- dat
dat <- perSubjectTrim.fnc(dat, response='RT', subject='Subject', trim = 2.5)$data
dat$RT_log <- log(dat$RT)

## ---- echo=FALSE---------------------------------------------------------
instructions_table <- 
  dat %>%
    select(Item, Quantity, Vagueness, Selection, Instruction) %>%
    unique() %>%
    arrange(Item, Quantity, Vagueness, Selection) %>%
    spread(key=Vagueness, value=Instruction)
instructions_table %>% 
  kable(align='cccll', caption="Full table of instructions") %>% 
      kable_styling(full_width = F, position = "left", font_size = 11) 

## ---- cho=FALSE----------------------------------------------------------
dat_plot <- summarySEwithin2(dat, measurevar="RT_log", withinvars=c("Vagueness", "Selection", "Item"), idvar="Subject")

## ---- "EXP_D_RT_means_plot", fig.width=7, fig.height=3, echo=FALSE-------
dodge = position_dodge(width=0.2)
dat_plot$Condition <- as.factor(paste(sep=' ', dat_plot$Selection, dat_plot$Vagueness))
ggplot(dat_plot, aes(y=RT_logNormed, x=Item, ymin=RT_logNormed-ci, ymax=RT_logNormed+ci, group=Condition, shape=Condition, fill=Condition)) +
  geom_line(position=dodge) +
  geom_errorbar(width=.2, position=dodge) +
  geom_point(size=2, position=dodge) +
  scale_shape_manual("",values = c(22, 22, 21, 21)) +
  scale_fill_manual("",values=c("black","white","black","white")) +
  ggtitle("Response time") +
  ylab("Respone time (log (ms))") + 
  xlab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        legend.key = element_blank(), aspect.ratio=1,
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.background=element_rect(fill=NA, color='white')) +
  facet_grid(~Selection) 

## ---- "EXP_D_Borderline_response_distribution_plot", fig.width=7, fig.height=3.5, echo=FALSE----
dat_borderline$response_cat <- factor(dat_borderline$response_cat, levels= c("Near", "Expected", "Far"))
ggplot(dat_borderline) + 
  geom_bar(aes(response_cat, group=Selection:Vagueness, fill=Vagueness), position=position_dodge(width=NULL)) +   
  scale_fill_grey() + 
  xlab(NULL) + 
  ggtitle('Borderline response distribution') + 
  facet_grid(~Selection) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank(), legend.position="top", aspect.ratio=1, plot.background = element_rect(fill=NA, color='white'), strip.background=element_blank(), legend.key.size=unit(4, 'mm'), axis.text.x = element_text(angle = 15))

## ---- "rt_lmer_full_model_all_items", cache=TRUE-------------------------
dat_model <- dat
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Sel <- ifelse(dat_model$Selection=="Comparison", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
rtlmer = lmerTest::lmer(data=dat_model, RT_log ~ c_Vag * c_Sel + c_Itm + (1 + c_Vag * c_Sel + c_Itm | Subject))
pretty_coef_table(rtlmer, "rt_lmer_full_model_all_items")

## ---- "rt_lmer_for_comparison_all_items", cache=TRUE---------------------
dat_model <- subset(dat, subset=Selection=='Comparison')
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
comp_lmer <- lmerTest::lmer(data=dat_model, RT_log ~ c_Vag + c_Itm + (1 + c_Vag + c_Itm | Subject))
pretty_coef_table(comp_lmer, "rt_lmer_for_comparison_all_items")

## ---- "rt_lmer_for_matching_all_items", cache=TRUE-----------------------
dat_model <- subset(dat, subset=Selection=='Matching')
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
match_lmer <- lmerTest::lmer(data=dat_model, RT_log ~ c_Vag + c_Itm + (1 + c_Vag + c_Itm | Subject))
pretty_coef_table(match_lmer, "rt_lmer_for_matching_all_items")

## ------------------------------------------------------------------------
dat_model <- dat
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Sel <- ifelse(dat_model$Selection=="Comparison", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))

Item.numeric <- sapply(dat_model$Item,function(i) contr.sum(4)[i,])
dat_model$Item1 <- Item.numeric[1,]
dat_model$Item2 <- Item.numeric[2,]
dat_model$Item3 <- Item.numeric[3,]

## ------------------------------------------------------------------------
null.model2 <- lmer(RT_log ~ 
                     c_Sel + c_Vag:c_Sel + # main effect of selection and the interaction with vagueness
                     Item1 + c_Vag:Item1 +         # item effect and interaction with vagueness
                     Item2 + c_Vag:Item2 +         # item effect and interaction with vagueness
                     Item3 + c_Vag:Item3 +         # item effect and interaction with vagueness
                     (c_Sel + c_Vag + c_Itm| Subject), # per-subject
                   dat_model, REML=FALSE) 

## ------------------------------------------------------------------------
pretty_coef_table(null.model2, "null.model2")

## ------------------------------------------------------------------------
full.model2 <- lmer(RT_log ~ 
                     c_Vag + 
                     c_Sel + c_Vag:c_Sel + # main effect of selection and the interaction with vagueness
                     Item1 + c_Vag:Item1 +         # item effect and interaction with vagueness
                     Item2 + c_Vag:Item2 +         # item effect and interaction with vagueness
                     Item3 + c_Vag:Item3 +         # item effect and interaction with vagueness
                     (c_Sel + c_Vag + c_Itm| Subject), # per-subject
                   dat_model, REML=FALSE) 

## ------------------------------------------------------------------------
pretty_coef_table(full.model2, "full.model2")

## ------------------------------------------------------------------------
anova(null.model2, full.model2)

