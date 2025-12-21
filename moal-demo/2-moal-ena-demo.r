# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal ena() demo
# date: 08-12-2025
# -----
#
# -----
# 1 - functional analysis using Over-Representation analysis (ORA) for Symbol list 
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::ena
# output directory
if(!file.exists("2-ena-outputdata")){"2-ena-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" -> url
data.table::fread(url) %>% data.frame -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
# example with Symbol list without fold-change and p-value Symbol
#
moal::ena(omicdata=omicdata$Symbol,species="hs",dirname="T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv" -> url
data.table::fread(url) %>% data.frame -> sif
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
factor
moal::ena(omicdata=omicdata,factor=factor,species="hs",dirname="fc_T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> dat
dat %>% head
moal::ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="heatmaps_T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps and
# adding gmtfiles for heatmap on specific genesets
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/c2_apoptosis_lung.gmt" %>% download.file(destfile = "c2_apoptosis_lung.gmt")
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/c2_apoptosis_skin.gmt" %>% download.file(destfile = "c2_apoptosis_skin.gmt")
list.files(full.names=T) %>% grep(".gmt$",.,value=T) -> gmtfiles
moal::ena(omicdata=omicdata,dat=dat,factor=factor,gmtfiles=gmtfiles,species="hs",dirname="gmtfiles_T21vsControl_243",path="2-ena-outputdata")
#
# -----
# 2 - functional analysis using GeneSet Enrichment analysis (GSEA)
# -----
#
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSEA_T21vsCTL_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
# example with not filtered differential analysis results with fold-change and p-value and expression data for heatmaps
#
moal::ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="GSEA_T21vsControl_23786",path="2-ena-outputdata")
#
