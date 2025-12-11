# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal volcanoplot() demo
# date: 08-12-2025
# -----
#
#
# loading libraries
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal);moal::env()
??moal::volcanoplot
# output directory
if(!file.exists("4-volcanoplot-outputdata")){"4-volcanoplot-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSEA_T21vsCTL_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
moal::volcanoplot(omicdata,pval=0.05,fc=1.5) -> p
ggsave(plot = p, filename = "./4-volcanoplot-outputdata/Volcanoplot_p05_fc15_T21vsCTL_23786.pdf")
# with Symbol list
omicdata$Symbol %>% sample(size = 20) -> genenamelist
moal::volcanoplot(omicdata,genenamelist=genenamelist,pval=0.05,fc=1.5) -> p
ggsave(plot = p, filename = "./4-volcanoplot-outputdata/Volcanoplot_list_T21vsCTL_23786.pdf")
#