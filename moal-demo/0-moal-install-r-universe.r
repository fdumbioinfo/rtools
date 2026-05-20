# -----
# IPSIT univ Paris-Saclay - GNU GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal install from r-universe
# date: 11122025
# -----
# 
options(pkgType = "binary")
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
# depend packages
if(!require("BiocManager",quietly=TRUE)){install.packages("BiocManager")}
if(!require("broom",quietly=TRUE)){install.packages("broom",update=F)}
if(!require("dendextend",quietly=TRUE)){install.packages("dendextend",update=F)}
if(!require("doParallel",quietly=TRUE)){install.packages("doParallel",update=F)}
if(!require("dplyr",quietly=TRUE)){install.packages("dplyr",update=F)}
if(!require("forcats",quietly=TRUE)){install.packages("forcats",update=F)}
if(!require("foreach",quietly=TRUE)){install.packages("foreach",update=F)}
if(!require("ggforce",quietly=TRUE)){install.packages("ggforce",update=F)}
if(!require("ggpubr",quietly=TRUE)){install.packages("ggpubr",update=F)}
if(!require("gplots",quietly=TRUE)){install.packages("gplots",update=F)}
if(!require("ggplot2",quietly=TRUE)){install.packages("ggplot2",update=F)}
if(!require("ggrepel",quietly=TRUE)){install.packages("ggrepel",update=F)}
if(!require("graphics",quietly=TRUE)){install.packages("graphics",update=F)} # base
if(!require("gridExtra",quietly=TRUE)){install.packages("gridExtra",update=F)}
if(!require("igraph",quietly=TRUE)){install.packages("igraph",update=F)}
if(!require("parallel",quietly=TRUE)){install.packages("parallel",update=F)} # base
if(!require("plyr",quietly=TRUE)){install.packages("plyr",update=F)}
if(!require("Rgraphviz",quietly=TRUE)){BiocManager::install("Rgraphviz",update=F)}
if(!require("scales",quietly=TRUE)){install.packages("scales",update=F)}
if(!require("stringr",quietly=TRUE)){install.packages("stringr",update=F)}
if(!require("tidyselect",quietly=TRUE)){install.packages("tidyselect",update=F)}
if(!require("utils",quietly=TRUE)){install.packages("utils",update=F)} # base
if(!require("colourvalues",quietly=TRUE)){install.packages("colourvalues",update=F)}
if(!require("fgsea",quietly=TRUE)){BiocManager::install("fgsea",update=F)}
if(!require("limma",quietly=TRUE)){BiocManager::install("limma",update=F)}
# moal package
if(!require("moal",quietly=TRUE)){install.packages("moal",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
#