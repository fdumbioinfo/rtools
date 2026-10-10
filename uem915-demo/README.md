<b><h3>MOAL demos</h3></b>

0 - moal install

```r
# -----
# IPSIT univ Paris-Saclay - GNU GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal install from r-universe
# date: 11122025
# -----
# 
if(!(Sys.info()[1] == "Linux")){options(pkgType = "binary")}
# annotation packages
if(!require("moalannotgene",quietly=TRUE)){install.packages("moalannotgene",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalannotensg",quietly=TRUE)){install.packages("moalannotensg",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalannotenst",quietly=TRUE)){install.packages("moalannotenst",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalannotensp",quietly=TRUE)){install.packages("moalannotensp",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdbhs",quietly=TRUE)){install.packages("moalstringdbhs",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdbmm",quietly=TRUE)){install.packages("moalstringdbmm",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdbrn",quietly=TRUE)){install.packages("moalstringdbrn",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdbdr",quietly=TRUE)){install.packages("moalstringdbdr",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdbss",quietly=TRUE)){install.packages("moalstringdbss",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
if(!require("moalstringdboa",quietly=TRUE)){install.packages("moalstringdboa",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
# depend packages
if(!require("BiocManager",quietly=TRUE)){install.packages("BiocManager")}
if(!require("broom",quietly=TRUE)){BiocManager::install("broom",update=F)}
if(!require("dendextend",quietly=TRUE)){BiocManager::install("dendextend",update=F)}
if(!require("doParallel",quietly=TRUE)){BiocManager::install("doParallel",update=F)}
if(!require("dplyr",quietly=TRUE)){BiocManager::install("dplyr",update=F)}
if(!require("edgeR",quietly=TRUE)){BiocManager::install("edgeR",update=F)}
if(!require("forcats",quietly=TRUE)){BiocManager::install("forcats",update=F)}
if(!require("foreach",quietly=TRUE)){BiocManager::install("foreach",update=F)}
if(!require("ggforce",quietly=TRUE)){BiocManager::install("ggforce",update=F)}
if(!require("ggpubr",quietly=TRUE)){BiocManager::install("ggpubr",update=F)}
if(!require("gplots",quietly=TRUE)){BiocManager::install("gplots",update=F)}
if(!require("ggrepel",quietly=TRUE)){BiocManager::install("ggrepel",update=F)}
if(!require("grDevices",quietly=TRUE)){BiocManager::install("grDevices",update=F)}
if(!require("gridExtra",quietly=TRUE)){BiocManager::install("gridExtra",update=F)}
if(!require("igraph",quietly=TRUE)){BiocManager::install("igraph",update=F)}
if(!require("parallel",quietly=TRUE)){BiocManager::install("parallel",update=F)}
if(!require("plyr",quietly=TRUE)){BiocManager::install("plyr",update=F)}
if(!require("Rgraphviz",quietly=TRUE)){BiocManager::install("Rgraphviz",update=F)}
if(!require("graphics",quietly=TRUE)){BiocManager::install("graphics",update=F)}
if(!require("stringr",quietly=TRUE)){BiocManager::install("stringr",update=F)}
if(!require("tidyselect",quietly=TRUE)){BiocManager::install("tidyselect",update=F)}
if(!require("utils",quietly=TRUE)){BiocManager::install("utils",update=F)}
if(!require("colourvalues",quietly=TRUE)){BiocManager::install("colourvalues",update=F)}
if(!require("fgsea",quietly=TRUE)){BiocManager::install("fgsea",update=F)}
if(!require("limma",quietly=TRUE)){BiocManager::install("limma",update=F)}
# moal package
if(!require("moal",quietly=TRUE)){install.packages("moal",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")
```
1 - moal::omic() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title: omic
# date: 29-09-2026
# -----
# 
# moal install
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
# libraries
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::omic
# "~/Desktop" %>% setwd
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
dat$rowID %>% annotdb(species ="hs", idtype = "GENE", dboutput = "ncbi") -> annot
annot %>% head
annot %>% str
annot %>% select(GeneID,Symbol) -> annot
annot %>% head
# omic analysis with MSigDB GSEA functional analysis
dat %>% data.frame -> dat
sif %>% data.frame -> sif
"1-omic-outputdata" -> path
"GSE65055" -> dirname
NULL -> sample
#
omic(
  #
  # input
  dat = dat , sif = sif,
  annot = annot, species = "hs",
  #
  # anova model
  model = "ANEUPLOIDY", padj = "none", anovafc = "anovafc",
  batch = "TISSUE", 
  # paired = NULL,
  #
  # anova all filtering
  # threshold = c(1, 2, 3, 4, 9, 10, 11, 12),
  dovenn = T, docluster = T, dopattern = T,
  #
  # plot
  doheatmap = T, dovolcanoplot = T, dolineplot = T, doboxplotrow = T,
  #
  # functional analysis doena for GSEA and doenaora for ORA significant feature lists
  doena = T, doenaora = F, gmtfiles = NULL,
  dotopheatmap = T, dotopgenesetheatmap = T, dogmtgenesetheatmap = F, 
  dotopnetwork = T, dotopgenesetnetwork = F, dogmtgenesetnetwork = F, 
  # 
  # other par
  path = path, dirname = dirname, sample = sample,
  # parallelisation
  dopar = T, nbcore = NULL, liblocpath = NULL, savehistory = T )
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/1-moal-omic-demo.r")
```
2 - moal::ena() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title: moal ena() demo
# date: 10-10-2026
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
ena(omicdata=omicdata$Symbol,species="hs",dirname="T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv" -> url
data.table::fread(url) %>% data.frame -> sif
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
factor
ena(omicdata=omicdata,factor=factor,species="hs",dirname="fc_T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> dat
dat %>% head
ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="heatmaps_T21vsControl_243",path="2-ena-outputdata")
#
# example with Symbol list with fold-change and p-value and expression data for heatmaps and
# adding gmtfiles for heatmap on specific genesets
#
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/c2_apoptosis_lung.gmt" %>% download.file(destfile = "c2_apoptosis_lung.gmt")
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/c2_apoptosis_skin.gmt" %>% download.file(destfile = "c2_apoptosis_skin.gmt")
list.files(full.names=T) %>% grep(".gmt$",.,value=T) -> gmtfiles
ena(omicdata=omicdata,dat=dat,factor=factor,gmtfiles=gmtfiles,species="hs",dirname="gmtfiles_T21vsControl_243",path="2-ena-outputdata")
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
ena(omicdata=omicdata,dat=dat,factor=factor,species="hs",dirname="GSEA_T21vsControl_23786",path="2-ena-outputdata")
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/2-moal-ena-demo.r")
```
3 - moal::volcanoplot() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title:  moal volcanoplot() demo
# date: 10-10-2026
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::volcanoplot
# output directory
if(!file.exists("3-volcanoplot-outputdata")){"3-volcanoplot-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSEA_T21vsCTL_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> omicdata
omicdata %>% str
omicdata %>% dplyr::select(rowID,p_T21vsControl,fc_T21vsControl,Symbol) -> omicdata
omicdata %>% str
#
volcanoplot(omicdata,pval=0.05,fc=1.5) -> p
ggsave(plot = p, filename = "./3-volcanoplot-outputdata/Volcanoplot_p05_fc15_T21vsCTL_23786.pdf")
# with Symbol list
omicdata$Symbol %>% sample(size = 20) -> genenamelist
volcanoplot(omicdata,genenamelist=genenamelist,pval=0.05,fc=1.5) -> p
ggsave(plot = p, filename = "./3-volcanoplot-outputdata/Volcanoplot_list_T21vsCTL_23786.pdf")
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/3-moal-volcanoplot-demo.r")
```
4 - moal::qc() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title:  moal qc() demo
# date: 10-10-2026
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::qc
# output directory
if(!file.exists("4-QCs-outputdata")){"4-QCs-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> dat
dat %>% head
# loading sample information file
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv" -> url
data.table::fread(url) %>% data.frame -> sif
sif %>% head
# Ordering factors for pairwise comparison fold-changes
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> sif$ANEUPLOIDY
sif$TISSUE %>% as.factor -> sif$TISSUE
# qualitry controls function
moal::qc(dat=dat,sif=sif,dirname="GSE65055",path="4-QCs-outputdata")
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/4-moal-QCs-demo.r")
```
5 - moal::heatmap() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title:  moal heatmap() demo
# date: 10-10-2026
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::heatmap
# output directory
if(!file.exists("5-heatmap-outputdata")){"5-heatmap-outputdata" %>% dir.create}
# loading data
# loading data
# normalized expression data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_datanorm_RBE_TISSUE_22_23786.tsv" -> url
data.table::fread(url) %>% data.frame -> dat
dat %>% head
# loading sample information file
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/GSE65055_metadata_4_22.tsv" -> url
data.table::fread(url) %>% data.frame -> sif
sif %>% head
# Ordering factors for pairwise comparison fold-changes
sif$ANEUPLOIDY %>% ordered(c("Control","T13","T18","T21")) -> factor
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" -> url
data.table::fread(url) %>% data.frame -> l1
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T13vsControl_59.tsv" -> url
data.table::fread(url) %>% data.frame -> l2
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T18vsControl_203.tsv" -> url
data.table::fread(url) %>% data.frame -> l3
c(l1$rowID,l2$rowID,l3$rowID) %>% unique %>% annotdb(species ="hs", idtype = "GENE", dboutput = "ncbi") -> annot
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
paste("5-heatmap-outputdata/Heatmap_ANEUPLOIDY_",nrow(sif),"_",nrow(dat),".pdf",sep="") -> filename
pdf(filename)
moal::heatmap(dat=dat,factor=factor,labRow=heatmapdat$Symbol,labCol=sif$SampleName,dendrogram="row")
graphics.off()
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/5-moal-heatmap-demo.r")
```
6 - moal::venn() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title:  moal venn() demo
# date: 10-10-2026
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::venn
# output directory
if(!file.exists("6-venn-outputdata")){"6-venn-outputdata" %>% dir.create}
# loading data
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T21vsControl_243.tsv" -> url
data.table::fread(url) %>% data.frame -> l1
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T13vsControl_59.tsv" -> url
data.table::fread(url) %>% data.frame -> l2
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/inputdata/List_p05_fc15_ANEUPLOIDY_ud_T18vsControl_203.tsv" -> url
data.table::fread(url) %>% data.frame -> l3
list(l1$rowID,l2$rowID,l3$rowID) %>% moal::venn(export = T,listnames = c("T21","T13","T8"),path = "6-venn-outputdata")
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/6-moal-venn-demo.r")
```
7 - moal::normalization() demo
```r
# -----
# Paris-Saclay - GPL3 - https://github.com/fdumbioinfo/moal
# title:  moal normalization demo
# date: 10-10-2026
# -----
#
# loading libraries
if(!require("moal",quietly=TRUE)){source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")}
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
library(moal)
??moal::norm
# output directory
if(!file.exists("7-normalization-outputdata")){"7-normalization-outputdata" %>% dir.create}
# simulated data
rnorm(5*10000,5000,500) %>% matrix(nrow = 10000) %>%
  cbind(rnorm(5*10000,2000,800) %>% matrix(nrow = 10000)) %>% 
  data.frame(rowID=paste("row",1:nrow(.),sep=""),.) -> dat
dat %>% str
rep(c("B1","B2"),c(5,5)) %>% as.factor -> BATCH
paste("s",1:10,sep="") -> SampleID
data.frame(SampleID,BATCH) -> sif
dat %>% setNames(c("rowID",sif$SampleID)) -> dat
# raw data expression data
moal::qc(dat=dat,sif=sif,dirname="rawdata",path="7-normalization-outputdata")
# normalization log2 and quantile
dat %>% dplyr::select(-1) %>% moal::norm(method = "quantile") %>% data.frame(rowID=dat$rowID,.) -> normdat
normdat %>% str
moal::qc(dat=normdat,sif=sif,dirname="normdata",path="7-normalization-outputdata")
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/7-moal-normalization-demo.r")
```