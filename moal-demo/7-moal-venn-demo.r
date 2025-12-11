# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal venn() demo
# date: 08-12-2025
# -----
#
# loading libraries
library(moal);moal::env()
help("venn")
# output directory
if(!file.exists("outputdata")){"outputdata" %>% dir.create}
# loading data
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" %>% input -> l1
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T13vsControl_59.tsv" %>% input -> l2
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T18vsControl_203.tsv" %>% input -> l3
list(l1$rowID,l2$rowID,l3$rowID) %>% moal::venn(export = T,listnames = c("T21","T13","T8"),path = "outputdata")
#