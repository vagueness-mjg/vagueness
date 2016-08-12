# number of higher-level cells in the design (abstracting over Order) =
# Item(4) * Number(2) * Vagueness(2) * Quantity(2) = 32
# number of measurements in eaach cell = 8
# 332 * 8 = 256
# 256 * 30 = 7680
dd$measurement=0
dd$cell=0
for (s in levels(dd$Subject)) {
  cellcount=0
  for (i in levels(dd$Item)) {
    for (n in levels(dd$Number)) {
      for (v in levels(dd$Vagueness)) {
        for (q in levels(dd$Quantity)) {
          measurementcount=0
          cellcount=cellcount+1
          for (t in dd[dd$Subject==s & dd$Item==i & dd$Number==n & dd$Vagueness==v & dd$Quantity == q, "Trial"]) {
            dd[dd$Subject==s & dd$Item==i & dd$Number==n & dd$Vagueness==v & dd$Quantity == q & dd$Trial==t, "cell"] <- cellcount
            measurementcount=measurementcount+1
            dd[dd$Subject==s & dd$Item==i & dd$Number==n & dd$Vagueness==v & dd$Quantity == q & dd$Trial==t, "measurement"] = measurementcount
          }
        }
      }
    }
  }
}