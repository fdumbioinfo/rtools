# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal omic() demo
# date: 08-12-2025
# -----
#
# loading libraries
library(moal);moal::env()
help("omic")
# output directory
if(!file.exists("outputdata")){"outputdata" %>% dir.create}
# loading data
# normalized expression data
"inputdata/GSE65055_datanorm_22_23786.tsv" %>% moal::input(.) -> dat
# loading sample information file
"inputdata/GSE65055_metadata_4_22.tsv" %>% moal::input(.) -> sif
# Ordering factors for pairwise comparison fold-changes
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> sif$ANEUPLOIDY
sif$TISSUE %>% as.factor -> sif$TISSUE
# create annotation
dat$rowID %>% moal::annot(species ="hs", idtype = "GENE", dboutput = "ncbi") -> annot
annot %>% head
annot %>% str
annot %>% dplyr::select(GeneID,Symbol) -> annot
annot %>% head
# omic analysis with gsea functional analysis with MSigDB geneset database
"GSE65055" -> dirname
moal::omic(dat=dat,sif=sif,annot=annot,species="hs",model="ANEUPLOIDY",batch="TISSUE",dirname="GSE65055",path="outputdata")
#