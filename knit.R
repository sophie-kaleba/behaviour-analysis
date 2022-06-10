#!/usr/bin/env Rscript
library(knitr);
args    <- commandArgs(trailingOnly = TRUE)
# the following variables are shared with the knitted r-script
filename = args[3]
benchmark_name = args[4]
number_iterations = args[5]
number_inner_iterations = args[6]
flags_cmd = args[7]
folder_out = args[8]
silence <- knit(args[1], args[2]);
