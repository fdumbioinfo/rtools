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
library(moal);moal::env()
help("ena")
# output directory
if(!file.exists("outputdata")){"outputdata" %>% dir.create}
# loading data
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" %>% input -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
# example with Symbol list without fold-change and p-value Symbol
#
moal::ena(omicdata=omicdata$Symbol,species="hs",dirname="T21vsControl_243",path="outputdata")
#
# example with Symbol list with fold-change and p-value
#
"inputdata/GSE65055_metadata_4_22.tsv" %>% moal::input(.) -> sif
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
factor
moal::ena(omicdata=omicdata,factor=factor,species="hs",dirname="fc_T21vsControl_243",path="outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps
#
"inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" %>% moal::input(.) -> dat
dat %>% head
moal::ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="heatmaps_T21vsControl_243",path="outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps and
# adding gmtfiles for heatmap on specific genesets
#
"inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" %>% moal::input(.) -> dat
dat %>% head
"inputdata/" %>% list.files(full.names=T) %>% grep(".gmt$",.,value=T) -> gmtfiles
gmtfiles
moal::ena(omicdata=omicdata,dat=dat,factor=factor,gmtfiles=gmtfiles,species="hs",dirname="gmtfiles_T21vsControl_243",path="outputdata")
#
# -----
# 2 - functional analysis using GeneSet Enrichment analysis (GSEA)
# -----
#
# loading data
"inputdata/GSEA_T21vsCTL_23786.tsv" %>% input -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
"inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" %>% moal::input(.) -> dat
dat %>% head
"inputdata/GSE65055_metadata_4_22.tsv" %>% moal::input(.) -> sif
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
factor
#
# example with not filtered differential analysis results with fold-change and p-value and expression data for heatmaps
#
moal::ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="GSEA_T21vsControl_23786",path="outputdata")
#