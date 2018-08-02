# # add ratios for Item
# item_range_ratio = c(6 / 24, 16 / 34, 26 / 44, 36 / 54) 
# # 0.2500000 0.4705882 0.5909091 0.6666667
# item_range_ratio_scaled = as.vector(scale(c(6 / 24, 16 / 34, 26 / 44, 36 / 54)))
# # -1.3441995 -0.1316642  0.5297187  0.9461450
# item_mean_ratio = c(mean(c(6 / 15, 15 / 24)), mean(c(16 / 25, 25 / 34)), mean(c(26 /35, 35 / 44)), mean(c(36 / 45, 45 / 54))) 
# # 0.5125000 0.6876471 0.7691558 0.8166667
# item_mean_ratio_scaled = as.vector(scale(c(mean(c(6 / 15, 15 / 24)), mean(c(16 / 25, 25 / 34)), mean(c(26 /35, 35 / 44)), mean(c(36 / 45, 45 / 54))))) 
# # -1.37582241 -0.06614191  0.54334858 0.89861574

# dat[dat$Item == "06:15:24", "item_range_ratio"] <-  0.2500000
# dat[dat$Item == "16:25:34", "item_range_ratio"] <-  0.4705882
# dat[dat$Item == "26:35:44", "item_range_ratio"] <-  0.5909091
# dat[dat$Item == "36:45:54", "item_range_ratio"] <-  0.6666667
# 
# dat[dat$Item == "06:15:24", "item_range_ratio_scaled"] <-  -1.3441995
# dat[dat$Item == "16:25:34", "item_range_ratio_scaled"] <-  -0.1316642
# dat[dat$Item == "26:35:44", "item_range_ratio_scaled"] <-   0.5297187  
# dat[dat$Item == "36:45:54", "item_range_ratio_scaled"] <-   0.9461450
# 
# dat[dat$Item == "06:15:24", "item_mean_ratio"] <-  0.5125000 
# dat[dat$Item == "16:25:34", "item_mean_ratio"] <-  0.6876471 
# dat[dat$Item == "26:35:44", "item_mean_ratio"] <-  0.7691558
# dat[dat$Item == "36:45:54", "item_mean_ratio"] <-  0.8166667
# 
# dat[dat$Item == "06:15:24", "item_mean_ratio_scaled"] <-   -1.37582241 
# dat[dat$Item == "16:25:34", "item_mean_ratio_scaled"] <-   -0.06614191 
# dat[dat$Item == "26:35:44", "item_mean_ratio_scaled"] <-    0.54334858 
# dat[dat$Item == "36:45:54", "item_mean_ratio_scaled"] <-    0.89861574