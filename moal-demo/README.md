# rtools

<b>MOAL demos</b>

0 - moal install

```r
# -----
# UMS IPSIT BIOINFO - Licence GPL-3
# https://github.com/fdumbioinfo/moal
# title: moal install from r-universe
# date: 11122025
# -----
# 
# moal install
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
if(!require("Rgraphviz",quietly=TRUE)){BiocManager::install("Rgraphviz",update=F)}
if(!require("limma",quietly=TRUE)){BiocManager::install("limma",update=F)}
if(!require("fgsea",quietly=TRUE)){BiocManager::install("fgsea",update=F)}
# moal package
if(!require("moal",quietly=TRUE)){install.packages("moal",repos=c("https://fdumbioinfo.r-universe.dev","https://cloud.r-project.org"))}
#
```
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/0-moal-install-r-universe.r")
```
1 - moal::omic() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/1-moal-omic-demo.r")
```
2 - moal::ena() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/2-moal-ena-demo.r")
```
3 - moal::volcanoplot() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/3-moal-volcanoplot-demo.r")
```
4 - moal::qc() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/4-moal-QCs-demo.r")
```
5 - moal::heatmap() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/5-moal-heatmap-demo.r")
```
6 - moal::venn() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/6-moal-venn-demo.r")
```
7 - moal::normalization() demo
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/7-moal-normalization-demo.r")
```
8 - moal demo all
```r
source("https://raw.githubusercontent.com/fdumbioinfo/rtools/main/moal-demo/8-moal-demo-all.r")
```

