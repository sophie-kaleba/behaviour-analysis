#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
silence <- knit(args[1], args[2]);
