# add discriminability with reference to item
discriminability_range = c(0.7500000, 0.5294118, 0.4090909, 0.3333333)
discriminability_range_scaled = c(1.3441995, 0.1316642, -0.5297187, -0.9461450)  
discriminability = c(0.4875000, 0.3123529, 0.2308442, 0.1833333)
discriminability_scaled = c(1.37582241, 0.06614191, -0.54334858, -0.89861574)
dat[dat$Item == "06:15:24", "discriminability"] <- 0.4875000
dat[dat$Item == "16:25:34", "discriminability"] <- 0.3123529
dat[dat$Item == "26:35:44", "discriminability"] <- 0.2308442
dat[dat$Item == "36:45:54", "discriminability"] <- 0.1833333
