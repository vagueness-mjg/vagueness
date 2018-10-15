## ----'load Libraries and source my functions', message=FALSE, echo=FALSE----
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
source("C_exp_1_functions/concatenate_raw_data.R")
source("C_exp_1_functions/annotate_the_raw_data.R")
source("C_exp_1_functions/add_borderline_vars.R")
source("C_exp_1_functions/pretty_coef_table.R")
source("C_exp_1_functions/summarySEwithin2.R")
root_dir <- getwd()
data_dir <- "C_exp_1_data"

## ---- "get data for RT analysis", echo=F, message=F, warning=F, results='hide'----
dat <- 
  concatenate_raw_data(root_dir, data_dir) %>%
  annotate_the_raw_data() %>% # at this point RT has min=1 (resp_type="sticky") and max=59,999 (resp_type="timeout")
  filter(RT>1 & RT<59999) # at this point RT has min=445, max=42,685 (42 seconds) and nrow(dat) is 7677 down from 7680
dat <- perSubjectTrim.fnc(dat, response='RT', subject='Subject', trim = 2.5)$data %>% select(-SD, -Mean, -Scaled)
dat$RT_log <- log(dat$RT)

## ---- "get data for borderline analysis", echo=F-------------------------
dat_borderline <- 
  concatenate_raw_data(root_dir, data_dir) %>%
  add_borderline_vars() %>%
  annotate_the_raw_data() %>% # at this point RT has min=1 (resp_type="sticky") and max=59,999 (resp_type="timeout")
  filter(RT>1 & RT<59999) # at this point RT has min=445, max=42,685 (42 seconds) and nrow(dat) is 7677 down from 7680

## ---- "full table of instructions", echo=FALSE---------------------------
instructions_table <- 
  dat %>%
    select(Item, Quantity, Vagueness, Number, Instruction) %>%
    unique() %>%
    arrange(Item, Quantity, Vagueness, Number) %>%
    spread(key=Vagueness, value=Instruction)
# kable(instructions_table, format="latex", booktabs = TRUE)
instructions_table %>% 
  kable(align='cccll', caption="Full table of instructions") %>% 
      kable_styling(full_width = F, position = "left", font_size = 11) 

## ---- "make summary data for rt plot", echo=FALSE------------------------
dat_plot <- summarySEwithin2(dat, measurevar="RT_log", withinvars=c("Vagueness", "Number", "Item"), idvar="Subject")

## ---- "EXP_C_RT_condition_means_plot", fig.width=7, fig.height=3.5, echo=FALSE----
mywidth=0
pdodge=position_dodge(width=mywidth)
ggplot(dat_plot, aes(x=Item, y=RT_logNormed, group=Vagueness, ymin=RT_logNormed-ci, ymax=RT_logNormed+ci, shape=Vagueness, fill=Vagueness)) +
  ggtitle("Response time condition means") +
  facet_wrap(~Number) +
  scale_fill_grey(name="Vagueness", start=0, end=1) +
  scale_shape_manual(name="Vagueness", values=c(21,22)) +
  theme(aspect.ratio = 1, panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_rect(fill="white", colour="black"), strip.background=element_blank(), legend.key = element_blank(), legend.key.size=unit(4, 'mm'), legend.position="top", axis.text.x = element_text(angle = 15)) +
  ylab("RT log(ms)") + xlab(NULL) +
  geom_errorbar(position=pdodge, width=0.25) +
  geom_line(position=pdodge) +
  geom_point(position=pdodge, size=2)

## ---- "EXP_C_Borderline_response_distribution_plot", fig.width=7, fig.height=3.5, echo=FALSE----
dat_borderline$response_category <- relevel(dat_borderline$response_category, ref='expected')

ggplot(dat_borderline) + 
  geom_bar(aes(response_category, group=Number:Vagueness, fill=Vagueness), position=position_dodge(width=NULL)) +   
  scale_fill_grey() + 
  xlab(NULL) + 
  ggtitle('Borderline response distribution') + 
  facet_grid(~Number) +
  theme_bw() + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.key = element_blank(), legend.position="top", aspect.ratio=1, plot.background = element_rect(fill=NA, color='white'), strip.background=element_blank(), legend.key.size=unit(4, 'mm'), axis.text.x = element_text(angle = 15))


## ----"original full RT model", cache=TRUE--------------------------------
dat_model <- dat
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Num <- ifelse(dat_model$Number=="Verbal", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
rtFullModel <- lmerTest::lmer(1 + RT_log ~ c_Vag * c_Num + c_Itm + (1 + c_Vag * c_Num + c_Itm | Subject), dat_model)
pretty_coef_table(rtFullModel, "rtFullModel")

## ----"numeric only RT model", cache=TRUE---------------------------------
dat_model <- droplevels(subset(dat, Number=="Numeric"))
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
rtFullModel_num <- lmerTest::lmer(1 + RT_log ~ c_Vag + c_Itm + (1 + c_Vag + c_Itm | Subject), dat_model)
pretty_coef_table(rtFullModel_num, "rtFullModel_num")

## ----"verbal only RT model", cache=TRUE----------------------------------
dat_model <- droplevels(subset(dat, Number=="Verbal"))
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
rtFullModel_verb <- lmerTest::lmer(1 + RT_log ~ c_Vag + c_Itm + (1 + c_Vag + c_Itm | Subject), dat_model)
pretty_coef_table(rtFullModel_verb, "rtFullModel_verb")

## ----"borderline full model", cache=TRUE---------------------------------
dat_model <- dat_borderline
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Num <- ifelse(dat_model$Number=="Verbal", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="06:15:24", -.75, ifelse(dat_model$Item=="16:25:34", -.25, ifelse(dat_model$Item=="26:35:44", .25, .75)))
blFullModel <- lme4::glmer(isBorderline ~ c_Vag * c_Num + c_Itm + (1 + c_Vag * c_Num + c_Itm | Subject), dat_model, family="binomial", control = glmerControl(optimizer = "bobyqa"))
pretty_coef_table(blFullModel, "blFullModel")

## ---- "full RT model after drop item", cache=TRUE------------------------
dat_model <- droplevels(subset(dat, Item!="06:15:24"))
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Num <- ifelse(dat_model$Number=="Verbal", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="16:25:34", -.3333, ifelse(dat_model$Item=="26:35:44", .0000, .3333))
rtRestrictedModel <- lmerTest::lmer(1 + RT_log ~ c_Vag * c_Num + c_Itm + (1 + c_Vag + c_Num  | Subject), dat_model)
pretty_coef_table(rtRestrictedModel, "rtRestrictedModel")

## ---- "num only RT model after drop item", cache=TRUE--------------------
dat_model <- droplevels(subset(dat, Item!="06:15:24" & Number=="Numeric"))
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="16:25:34", -.3333, ifelse(dat_model$Item=="26:35:44", .0000, .3333))
rtRestrictedModel_num <- lmerTest::lmer(1 + RT_log ~ c_Vag + c_Itm + (1 + c_Vag | Subject), dat_model)
pretty_coef_table(rtRestrictedModel_num, "rtRestrictedModel_num")

## ---- "verbal only RT model after drop item", cache=TRUE-----------------
dat_model <- droplevels(subset(dat, Item!="06:15:24" & Number=="Verbal"))
dat_model$c_Vag <- ifelse(dat_model$Vagueness=="Crisp", -0.5, 0.5)
dat_model$c_Itm <- ifelse(dat_model$Item=="16:25:34", -.3333, ifelse(dat_model$Item=="26:35:44", .0000, .3333))
rtRestrictedModel_verb <- lmerTest::lmer(1 + RT_log ~ c_Vag + c_Itm + (1 + c_Vag + c_Itm | Subject), dat_model)
pretty_coef_table(rtRestrictedModel_verb, "rtRestrictedModel_verb")

