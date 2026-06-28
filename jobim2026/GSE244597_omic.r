# -----
# UMS IPSIT BIOINFO - Paris-Saclay
# Licence GPL-3 - https://github.com/fdumbioinfo/moal
# title: moal omic
# date: 28062026
# -----
#
library(moal)
setwd("~/Desktop/IPSIT/communication/JOBIM/Jobim2026/rwdjobim26/GSE244597")
#
"GSE244597_normdata_12_47123.tsv" %>% input -> m0
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
#
moal::omic(dat = m0,sif = s0,species = "hs",model = "BMPR2+BMP9+BMPR2*BMP9",dirname ="GSE244597", sample = 500)
moal::omic(dat = m0,sif = s0,species = "hs",model = "BMPR2+BMP9+BMPR2*BMP9",dirname ="GSE244597", sample = NULL)
#