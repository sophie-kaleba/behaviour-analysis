#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
folder_status = args[3]
folder_cov = args[4]
folder_report = args[5]
folder_details = args[6]

silence <- knit(args[1], args[2]);
