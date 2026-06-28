library(moal)
setwd("~/Desktop/IPSIT/communication/JOBIM/Jobim2026/rwdjobim26/GSE244597")
#
# QC/filter/norm
#
"GSE244597_rawcount_12_58501.tsv" %>% input -> m0
m0 %>% head
m0 %>% dim
m0 %>% colnames
"GSE244597_metadata_12.tsv" %>% input -> s0
s0 %>% head
s0 %>% dim
s0$BMPR2
s0$BMPR2 %>% ordered(c("siCTL","siBMPR2")) -> s0$BMPR2
s0$BMPR2
s0$BMP9
s0$BMP9 %>% ordered(c("NS","BMP9")) -> s0$BMP9
s0$BMP9
s0$GROUP %>% table
s0$GROUP %>% ordered(c("siCTL_NS","siCTL_BMP9","siBMPR2_NS","siBMPR2_BMP9")) -> s0$GROUP
s0$GROUP
# QCs rawdata
m0 %>% dim
m0 %>% moal::qc(s0,dirname = "rawcount")
# filter
m0 %>% dplyr::select(-1) %>% apply(1,mean) -> mean0
10 -> filter0
mean0 %>% ">"(filter0) %>% which -> sel
sel %>% length
if(length(sel)>0){ m0 %>% dplyr::slice(sel) -> m1 }else{ m0 -> m1 }
m1 %>% head
m1 %>% dim
# QCs filter
paste("rawdata_filter",filter0,sep="") -> DirName0
m1 %>% moal::qc(s0,dirname = DirName0)
#
# normalization
#
if(!require("edgeR",quietly=TRUE)){ BiocManager::install("edgeR",update = F) }
#
colnames(m1)[1] <- "rowID"
m1 %>%
  dplyr::select(-1) %>%
  edgeR::DGEList() %>%
  edgeR::calcNormFactors( method = c("TMM") ) -> dg0
dg0$counts %>% head
dg0$counts %>% str
dg0$samples
# limma voom
limma::voom(
  dg0,
  plot = TRUE,
  # normalize.method = "none",
  normalize.method = "quantile") -> dg1
#
dg1$E %>% min -> min
dg1$E %>% "+"(abs(min)) -> m2
# remove sd = 0 row
m2 %>% data.frame("rowID"=m1$rowID,.) -> m3
m3 %>% head
m3 %>% dim
m3 %>% dplyr::select(-1) %>% apply(1,sd) %>% "=="(0) %>% which -> sel
sel
if(length(sel)>0){ m3 %>% dplyr::slice(-sel) -> m4 }else{ m3 -> m4 }
# QCs
m4 %>% dim
m4 %>% moal::qc(s0,dirname = "normdata")
m4 %>% head
m4 %>% dim
paste("GSE244597_normdata_",ncol(m4)-1,"_",nrow(m4),".tsv",sep="") -> FileName0
FileName0
m4 %>% output(FileName0)
#