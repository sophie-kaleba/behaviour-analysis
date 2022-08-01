#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
folder_cov = args[3] #input for coverage

folder_status = args[4] #input for global data
folder_details = args[5] #input for detailed data

folder_report = args[6] #output for latex tables and pdf report

keep_startup = as.logical(args[7])
keep_blocks = as.logical(args[8])

silence <- knit(args[1], args[2]);
