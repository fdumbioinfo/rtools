#
# UEM915 analyse transcriptomique
#
# introduction R
#
# working directory
setwd(".")
#
# Omic analysis: ANEUPLODY  
#
# publication: https://doi.org/10.1111/cge.12731
# data on GEO database (Gene Expression Omnibus): https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE65055
# uem915 install
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/uem915-demo/0-uem915-install-r-universe-oldR.r")
# chargement des packages
library(uem915)
uem915::env()
#
# pr?traitement des donn?es brutes: QCs -> normalisation -> QCs
#
# chargement des donn?es brutes:
uem915:::GSE65055rawdata -> rawdata
rawdata %>% head
rawdata %>% dim
#
uem915:::GSE65055metadataraw -> sampledata
sampledata %>% head
sampledata %>% dim
# changement des vecteurs en facteurs et classement des groupes
sampledata$ANEUPLOIDY %>% ordered( c("CTL","T13","T18","T21") ) -> sampledata$ANEUPLOIDY
sampledata$ANEUPLOIDY
sampledata$TISSUE %>% as.factor -> sampledata$TISSUE
sampledata$TISSUE
# contr?le qualit? des donn?es brutes
rawdata %>% dplyr::select(-1) %>% uem915:::boxplot(sampledata$ANEUPLOIDY)
rawdata %>% dplyr::select(-1) %>% uem915:::histogram(bins=100)
rawdata %>% dplyr::select(-1) %>% uem915:::hc(sampledata$ANEUPLOIDY)
rawdata %>% dplyr::select(-1) %>% uem915:::acp(sampledata$ANEUPLOIDY)
# normalisation
rawdata %>% dplyr::select(-1) %>% uem915::norm(.) %>% data.frame(rowID=rawdata$rowID,.) -> normdata
normdata %>% head
normdata %>% dim
normdata %>% dplyr::select(-1) %>% uem915:::boxplot(sampledata$ANEUPLOIDY)
normdata %>% dplyr::select(-1) %>% uem915::norm(.) %>% uem915:::histogram(bins=100)
normdata %>% dplyr::select(-1) %>% uem915::norm(.) %>% uem915:::acp(sampledata$ANEUPLOIDY)
normdata %>% dplyr::select(-1) %>% uem915::norm(.) %>% uem915:::acp(sampledata$TISSUE)
normdata %>% dplyr::select(-1) %>% uem915::norm(.) %>% uem915:::hc(sampledata$ANEUPLOIDY)
#
# Analyse omique: Analyse diff?rentielle -> filtre -> analyse/enrichissement fonctionnel
#
# chargement des donn?es normalis?es:
#
# matrice de donn?es normalis?es
uem915:::GSE65055normdata -> normdata
normdata %>% head
normdata %>% dim
#
# description des ?chantillons
uem915:::GSE65055metadatanorm -> sampledata
sampledata %>% head
sampledata %>% dim
# classement des groupes
sampledata$ANEUPLOIDY %>% ordered(c("CTL","T13","T18","T21")) -> sampledata$ANEUPLOIDY
sampledata$ANEUPLOIDY
sampledata$TISSUE %>% as.factor -> sampledata$TISSUE
# annotation Human Gene ID
normdata$rowID %>% uem915::annot(species="hs",idtype="GENE") -> annotdata
annotdata %>% head
annotdata %>% dim
#
# statistique descriptive
# histogramme: distribution de l'ensemble donn?es
normdata %>% dplyr::select(-1) %>% as.matrix %>% hist(breaks=100)
# boxplot distribution par quatile pour chaque ?chantillon
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915:::boxplot(factor=sampledata$ANEUPLOIDY)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915:::boxplot(factor=sampledata$TISSUE)
table(sampledata$ANEUPLOIDY,sampledata$TISSUE)
paste(sampledata$ANEUPLOIDY,sampledata$TISSUE,sep="_") %>% as.factor -> GROUP
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915:::boxplot(factor=GROUP)
#
# analyse non supervis?e: classification ascendante hi?rarchique (HCA)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915:::hc(factor=sampledata$ANEUPLOIDY)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915::hc(factor=sampledata$TISSUE)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915::hc(factor=GROUP)
#
# analyse non supervis?e: analyse en composante principale (ACP)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915::acp(factor=sampledata$ANEUPLOIDY)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915::acp(factor=sampledata$TISSUE)
normdata %>% dplyr::select(-1) %>% as.matrix %>% uem915::acp(factor=GROUP)
#
# analyse diff?rentielle par analyse de variance (ANOVA)
#
parallel::makeCluster(detectCores()) -> cl
doParallel::registerDoParallel(cl)
system.time(
r0 <- foreach(i=1:nrow(normdata),.combine = "rbind",.packages = c("magrittr","uem915")) %dopar%
  {
    data.frame( y = normdata[i,-1] %>% as.numeric , sampledata ) -> anova0
    uem915:::anova( dat = anova0 , "ANEUPLOIDY+TISSUE") %>% "[["(1) %>% "["(c(1:8)) 
  } )
parallel::stopCluster(cl)
r0 %>% data.frame %>% head
# table de r?sultats
data.frame( rowID=normdata$rowID, r0, annotdata[,-1] ) -> r1
r1 %>% head
r1 %>% dim
r1 %>% output("resultats_anova_aneuploidy_23_29468.tsv")
#
# filtre et analyse fonctionelle
#
# chargement des r?sultats
"resultats_anova_aneuploidy_23_29468.tsv" %>% input -> r0
r0 %>% head
r0 %>% dim
r0 %>% colnames
#
# filtre T21vsControl
which(r0$p_T21vsCTL %>% "<"(0.05) & r0$fc_T21vsCTL %>% ">"(1.5)) -> sel
r0[sel,c(1,8,9,10:16)] -> r1
r1 %>% head
r1 %>% dim
r1 %>% colnames
r1 %>% uem915::output("p05_fc15_T21vsCTL_444.tsv")
#
# filtre T18vsControl filtre
which(r0$p_T18vsCTL %>% "<"(0.05) & r0$fc_T18vsCTL %>% ">"(1.5)) -> sel
r0[sel,c(1,5,6,10:16)] -> r1
r1 %>% head
r1 %>% dim
r1 %>% colnames
r1 %>% uem915::output("p05_fc15_T18vsControl_165.tsv")
#
# filtre T13vsControl filtre
which(r0$p_T13vsCTL %>% "<"(0.05) & r0$fc_T13vsCTL %>% ">"(1.5)) -> sel
r0[sel,c(1,4,5,10:16)] -> r1
r1 %>% head
r1 %>% dim
r1 %>% colnames
r1 %>% uem915::output("p05_fc15_T13vsCTL_83.tsv")
#
# Analyse d'enrichissement
#
"resultats_anova_aneuploidy_23_29468.tsv" %>% uem915::input(.) -> r0
r0 %>% head
r0 %>% dim
# T21
"p05_fc15_T21vsCTL_444.tsv" %>% uem915::input(.) -> l0
l0 %>% head
l0 %>% dim
r0$chr %>% table
# score valeur th?orique = 6.55
444 * 369 / 25000
# valeur observ?e = 23
l0$chr %>% table
# score = 4.58
30/6.55
# T18
"p05_fc15_T18vsControl_165.tsv" %>% uem915::input(.) -> l0
l0 %>% head
l0 %>% dim
r0$chr %>% table
# score valeur th?orique = 2.83
165 * 429 / 25000
# valeur observ?e = 34
l0$chr %>% table
# score = 12.01
34 / 2.83
# T13
"p05_fc15_T13vsCTL_83.tsv" %>% uem915::input(.) -> l0
l0 %>% head
l0 %>% dim
r0$chr %>% table
# score valeur th?orique = 1.22
83 * 369 / 25000
# valeur observ?e = 34
l0$chr %>% table
# score = 22.13
27 / 1.22
#
# visualisation des variables s?lectionn?es par heatmap
#
"p05_fc15_T21vsCTL_444.tsv" %>% uem915::input(.) -> lT21
"p05_fc15_T18vsControl_165.tsv" %>% uem915::input(.) -> lT18
"p05_fc15_T13vsCTL_83.tsv" %>% uem915::input(.) -> lT13
list(lT21$rowID,lT18$rowID,lT13$rowID) %>% unlist %>% unique %>% as.character %>% 
  data.frame(rowID=.) %>% inner_join(normdata) -> m1
m1 %>% head
m1 %>% dim
m1 %>% dplyr::select(-1) %>% uem915:::heatmap(factor=sampledata$ANEUPLOIDY)
m1 %>% dplyr::select(-1) %>% uem915:::heatmap(factor=sampledata$TISSUE)
# export
pdf("p05_fc15_Heatmap_ANEUPLOIDY_22_688.pdf")
m1 %>% dplyr::select(-1) %>% uem915:::heatmap(factor=sampledata$ANEUPLOIDY)
graphics.off()
#
# visualisation des variables s?lectionn?es par diagramme de venn: comparaison des listes
#
"p05_fc15_T21vsCTL_444.tsv" %>% uem915::input(.) -> lT21
"p05_fc15_T18vsControl_165.tsv" %>% uem915::input(.) -> lT18
"p05_fc15_T13vsCTL_83.tsv" %>% uem915::input(.) -> lT13
list(lT21$rowID,lT18$rowID,lT13$rowID) %>% uem915::venn(.)
#
# analyse automatis?e
#
system.time(
uem915::omic(
  dat = normdata, sif = sampledata, annot = annotdata, species = "hs",
  model="ANEUPLOIDY", batch = "TISSUE", threshold = c(6),
  venn = F, cluster = T, pattern = F,
  heatmap = T, volcanoplot = T, lineplot = F, boxplotrow = F,
  ena = T,
  sample = NULL, dopar = NULL,
  dirname = NULL, path = ".") )
#

