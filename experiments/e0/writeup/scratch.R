rm(d)
d <- read.table("data.txt", header=FALSE) # read in the data for all subjects
mynames <- list("gap_size", 
                "target_size", 
                "correct_side", 
                "vagueness",
                "pair", 
                "Version", 
                "Left",
                "Right", 
                "Text", 
                "Condition", 
                "correctAnswer",
                "subject",
                "actualAnswer",
                "isCorrect",
                "rt")
names(d) <- mynames
# For some reason there is one rt of -6. Set it to NA
d[d$rt==-6,"rt"] <- NA
d$observation <- 1:nrow(d)
d$trial <- 0
for (s in unique(d$subject)){
  d[d$subject==s, "trial"] <- 1:nrow(subset(d,subject==s))
}
d$item = ordered(d$pair, label = c("2:4", "3:5", "6:8", "7:9", "2:6", "7:3", "8:4", "5:9"))
d$subit <- "Not subitizable"
d$subit[d$item == "2:4"] <- "Subitizable"
d$subit[d$item == "3:5"] <- "Subitizable"
d$subit[d$item == "2:6"] <- "Subitizable"
d$subit[d$item == "7:3"] <- "Subitizable"
d$dotpair_id=d$item); d$item=NULL
d$subit = as.factor(d$subit)
d$gap_size = factor(d$gap_size, levels = c("BigGap", "SmallGap"), labels = c("Big", "Small"))
d$target_size = factor(d$target_size, levels = c("BigTarget", "SmallTarget"), labels = c("Big", "Small"))
d$vagueness = factor(d$vagueness, levels = c("Precise", "Vague"), labels = c("Crisp", "Vague")) 
d$is_error = 1 - d$isCorrect
d$dots_right=d$Right; d$Right=NULL
d$dots_left=d$Left; d$Left=NULL
dd <- subset(d, select=c(
  observation, subject, trial, gap_size, target_size, correct_side, dots_left, dots_right, dotpair_id, vagueness, Text, is_error, rt))

head(dd,30)

summary(dd)
