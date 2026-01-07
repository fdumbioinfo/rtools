# -----
# IPSIT univ Paris-Saclay - GNU GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal omic() demo
# date: 11-12-2025
# -----
#
# libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::omic
# output directory
if(!file.exists("1-omic-outputdata")){"1-omic-outputdata" %>% dir.create}
# loading data
# normalized expression data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_22_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> dat
dat %>% head
# loading sample information file
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv" -> url
data.table::fread(url) %>% data.frame -> sif
sif %>% head
# Ordering factors for pairwise comparison fold-changes
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> sif$ANEUPLOIDY
sif$TISSUE %>% as.factor -> sif$TISSUE
# create annotation
dat$rowID %>% moal::annot(species ="hs", idtype = "GENE", dboutput = "ncbi") -> annot
annot %>% head
annot %>% str
annot %>% dplyr::select(GeneID,Symbol) -> annot
annot %>% head
# omic analysis with MSigDB GSEA functional analysis
dat %>% data.frame -> dat
sif %>% data.frame -> sif
moal::omic(dat=dat,sif=sif,annot=annot,species="hs",model="ANEUPLOIDY",batch="TISSUE",dirname="GSE65055",path="1-omic-outputdata")
#
