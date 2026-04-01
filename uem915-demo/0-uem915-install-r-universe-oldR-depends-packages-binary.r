# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/uem915
# title: installation uem915
# date: 12-03-2026
# -----
#
options(pkgType = "binary")
# depend packages
if(!require("BiocManager",quietly=TRUE)){install.packages("BiocManager")}
if(!require("broom",quietly=TRUE)){BiocManager::install("broom",update=F)}
if(!require("dendextend",quietly=TRUE)){BiocManager::install("dendextend",update=F)}
if(!require("doParallel",quietly=TRUE)){BiocManager::install("doParallel",update=F)}
if(!require("dplyr",quietly=TRUE)){BiocManager::install("dplyr",update=F)}
if(!require("foreach",quietly=TRUE)){BiocManager::install("foreach",update=F)}
if(!require("ggforce",quietly=TRUE)){BiocManager::install("ggforce",update=F)}
if(!require("ggplot2",quietly=TRUE)){BiocManager::install("ggplot2",update=F)}
if(!require("ggpubr",quietly=TRUE)){BiocManager::install("ggpubr",update=F)}
if(!require("gplots",quietly=TRUE)){BiocManager::install("gplots",update=F)}
if(!require("graphics",quietly=TRUE)){BiocManager::install("graphics",update=F)}
if(!require("grDevices",quietly=TRUE)){BiocManager::install("grDevices",update=F)}
if(!require("gridExtra",quietly=TRUE)){BiocManager::install("gridExtra",update=F)}
if(!require("limma",quietly=TRUE)){BiocManager::install("limma",update=F)}
if(!require("magrittr",quietly=TRUE)){BiocManager::install("magrittr",update=F)}
if(!require("parallel",quietly=TRUE)){BiocManager::install("parallel",update=F)}
if(!require("plyr",quietly=TRUE)){BiocManager::install("plyr",update=F)}
if(!require("rlang",quietly=TRUE)){BiocManager::install("rlang",update=F)}
if(!require("scales",quietly=TRUE)){BiocManager::install("scales",update=F)}
if(!require("stats",quietly=TRUE)){BiocManager::install("stats",update=F)}
if(!require("stringr",quietly=TRUE)){BiocManager::install("stringr",update=F)}
if(!require("tidyselect",quietly=TRUE)){BiocManager::install("tidyselect",update=F)}
if(!require("utils",quietly=TRUE)){BiocManager::install("utils",update=F)}
#