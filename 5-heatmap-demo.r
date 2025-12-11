# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal heatmap() demo
# date: 08-12-2025
# -----
#
# loading libraries
library(moal);moal::env()
help("heatmap")
# output directory
if(!file.exists("outputdata")){"outputdata" %>% dir.create}
# loading data
# normalized expression data
"inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" %>% moal::input(.) -> dat
# loading sample information file
"inputdata/GSE65055_metadata_4_22.tsv" %>% moal::input(.) -> sif
sif %>% head
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor

sif$ANEUPLOIDY %>% grep("Control|T21",.,value=T) %>% ordered(c("Control","T21")) -> factor
factor
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