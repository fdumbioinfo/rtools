# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal omic() demo
# date: 08-12-2025
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