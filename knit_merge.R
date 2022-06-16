#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
folder_out = args[3]
silence <- knit(args[1], args[2]);
