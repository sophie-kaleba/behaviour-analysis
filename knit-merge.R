#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
folder_status = args[3] #input for coverage
folder_path = args[4] #input for global data
folder_blocks = args[5]

silence <- knit(args[1], args[2]);
