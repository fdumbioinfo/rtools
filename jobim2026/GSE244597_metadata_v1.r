# -----
# UMS IPSIT BIOINFO - Paris-Saclay
# Licence GPL-3 - https://github.com/fdumbioinfo/moal
# title: metadata
# date: 28062026
# -----
#
# moal install
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")
#
library(moal)
# setwd("~/Desktop/IPSIT/communication/JOBIM/Jobim2026/rwdjobim26/GSE244597")
#
# https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE244597
#
# copy sample table and paste in RStudio using read_clip 
clipr::read_clip() -> cl
cl %>% head
#
cl %>% strsplit("\t") %>% lapply("[",1) %>% unlist %>% gsub(" ","",.) -> GEOID
GEOID %>% head
GEOID %>% length
cl %>% strsplit("\t") %>% lapply("[",2) %>% unlist -> SampleID2
cl %>% strsplit("\t") %>% lapply("[",2) %>% unlist %>% gsub(" ","",.) %>% strsplit(",") %>% lapply("[",2) %>% unlist -> BMPR2
BMPR2 %>% table
BMPR2 %>% gsub("siControl","siCTL",.) -> BMPR2
cl %>% strsplit("\t") %>% lapply("[",2) %>% unlist %>% gsub(" ","",.) %>% strsplit(",") %>% lapply("[",3) %>% unlist -> BMP9
BMP9 %>% table
cl %>% strsplit("\t") %>% lapply("[",2) %>% unlist %>% gsub(" ","",.) %>% strsplit(",") %>% lapply("[",4) %>% unlist -> REP
REP %>% table
BMPR2 %>% table(BMP9)
paste(BMPR2,BMP9,sep="_") -> GROUP
paste(BMPR2,BMP9,REP,sep="_") -> SampleID2
# "BMP9" %>% annot
# "BMPR2" %>% annot
paste("s",1:length(GEOID),sep="") -> SampleID
paste(SampleID,TREATMENT,REP,sep="_") -> SampleName
data.frame(SampleID,BMPR2,BMP9,GROUP,REP,GEOID,SampleID2,SampleName) -> s0
s0 %>% head
s0 %>% dim
s0 %>% output("GSE244597_metadata_12.tsv")
# 
"GSE244597_metadata_12.tsv" %>% input -> s0
s0 %>% head
s0 %>% dim
s0$BMPR2
s0$BMPR2 %>% ordered(c("siCTL","siBMPR2")) -> s0$BMPR2
s0$BMPR2
s0$BMP9
s0$BMP9 %>% ordered(c("NS","BMP9")) -> s0$BMP9
s0$BMP9
# download from GEO NCBI GSE244597 or from demos using github GSE244597_rawCountMatrix.csv
if(!require("data.table",quietly=TRUE)){install.packages("data.table")}
"https://raw.githubusercontent.com/fdumbioinfo/rtools/main/jobim2026/GSE244597_rawCountMatrix.csv" -> url
data.table::fread(url) %>% data.frame(check.names = F) -> m0
# or download from GEO NCBI GSE244597
# "GSE244597_rawCountMatrix.csv" %>% input(sep=",") -> m0
m0 %>% head
m0 %>% dim
m0 %>% dplyr::select(3:ncol(m0)) -> m2
m2 %>% head
m2 %>% dim
m2 %>% colnames
s0$SampleName
# order sample data and matrix data
m2 %>% colnames %>% gsub("siC","siCTL",.) %>% gsub("siB","siBMPR2",.) %>% gsub("B9","BMP9",.) %>% gsub(" ","_",.) %>%
  gsub("(.*_)([0-9])$","\\1N\\2",.) %>% match(s0$SampleID2) %>% dplyr::select(m2,.) -> m3 
m3 %>% head
m3 %>% setNames(s0$SampleName) %>% data.frame(rowID=m0$Gene,.) -> m4 
m4 %>% head
m4 %>% dim
m4 %>% output("GSE244597_rawcount_12_58501.tsv")
#