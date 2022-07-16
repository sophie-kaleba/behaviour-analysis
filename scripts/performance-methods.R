load_data_file <- function(filename) {
  col_names <- c("Symbol", "Original.Receiver", "Source.Section", "CT.Address", "Builtin?", "Observed.Receiver")
  data <- fread(filename, header = FALSE, sep="\t", col.names = col_names)
  benchmark_name <- str_match(filename, "parsed\\_(.*?)\\.mylog")[2]
  data$Benchmark <- benchmark_name
  return(data)
}

clean_data_file <- function(df_p, keep_blocks) {
  if (keep_blocks) {
    df_p <- df_p %>%
       df_p <- data[`Builtin?` %like% "PROC|LAMBDA|block"] 
  }
  else {
    df_p <- df_p %>%
       df_p <- data[!(`Builtin?` %like% "PROC|LAMBDA|block")] 
  }

  df_p <- na.omit(df_p) #remove rows containing NA
  df_p[, Call.ID := 1:.N]
  df_p <- df_p[, lapply(.SD, str_trim)] # trim all whitespaces

  return (df_p)
}

add_number_receivers <- function(df) { 
  df[, Num.Receiver.Observed := n_distinct(Observed.Receiver), by=list(Source.Section, Symbol, Benchmark)]
  df[, Num.Receiver.Original := n_distinct(Original.Receiver), by=list(Source.Section, Symbol, Benchmark)]
}