# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal heatmap() demo
# date: 08-12-2025
# -----
#
# loading libraries
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal);moal::env()
??moal::heatmap
# output directory
if(!file.exists("5-heatmap-outputdata")){"5-heatmap-outputdata" %>% dir.create}
# loading data
# loading data
# normalized expression data
data.table::fread("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv") %>% data.frame -> dat
dat %>% head
# loading sample information file
data.table::fread("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv") %>% data.frame -> sif
sif %>% head
# Ordering factors for pairwise comparison fold-changes
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
data.table::fread("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv") %>% data.frame -> sif
sif %>% head

"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" %>% input -> l1
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T13vsControl_59.tsv" %>% input -> l2
"inputdata/List_p05_fc15_ANEUPLOIDY_ud_T18vsControl_203.tsv" %>% input -> l3
c(l1$rowID,l2$rowID,l3$rowID) %>% unique %>% moal::annot(species ="hs", idtype = "GENE", dboutput = "ncbi") -> annot
annot %>% head
annot %>% str
mode(dat$rowID) <- "character"
colnames(annot)[1] <- "rowID"
annot %>% dplyr::inner_join(dat) -> heatmapdat
heatmapdat %>% colnames
heatmapdat %>% dplyr::select(c(9:30)) -> dat
dat %>% head
dat %>% dim
# heatmap
paste("outputdata/Heatmap_ANEUPLOIDY_",nrow(sif),"_",nrow(dat),".pdf",sep="") -> filename
pdf(filename)
moal::heatmap(dat=dat,factor=factor,labRow=heatmapdat$Symbol,labCol=sif$SampleName,dendrogram="row")
graphics.off()
#