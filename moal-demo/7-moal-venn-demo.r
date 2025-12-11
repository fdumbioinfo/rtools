# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal venn() demo
# date: 08-12-2025
# -----
#
# loading libraries
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal);moal::env()
??moal::venn
# output directory
if(!file.exists("7-venn-outputdata")){"7-venn-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" -> url
data.table::fread(url) %>% data.frame -> l1
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T13vsControl_59.tsv" -> url
data.table::fread(url) %>% data.frame -> l2
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T18vsControl_203.tsv" -> url
data.table::fread(url) %>% data.frame -> l3
list(l1$rowID,l2$rowID,l3$rowID) %>% moal::venn(export = T,listnames = c("T21","T13","T8"),path = "7-venn-outputdata")
#