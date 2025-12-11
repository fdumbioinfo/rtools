# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal volcanoplot() demo
# date: 08-12-2025
# -----
#
#
# loading libraries
library(moal);moal::env()
help("volcanoplot")
# output directory
if(!file.exists("outputdata")){"outputdata" %>% dir.create}
# loading data
"inputdata/GSEA_T21vsCTL_23786.tsv" %>% input -> omicdata
omicdata %>% str
omicdata %>% colnames
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
moal::volcanoplot(omicdata,pval = 0.05,fc = 1.5) -> p
ggsave(plot = p, filename = "./outputdata/Volcanoplot_T21vsCTL_23786.pdf")
# with Symbol list
omicdata$Symbol %>% sample(size = 20) -> genenamelist
moal::volcanoplot(omicdata,genenamelist=genenamelist ,pval = 0.05,fc = 1.5) -> p
ggsave(plot = p, filename = "./outputdata/Volcanoplot_list_T21vsCTL_23786.pdf")
#