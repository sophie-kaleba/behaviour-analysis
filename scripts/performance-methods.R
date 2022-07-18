dt_load_data_file <- function(filename) {
  col_names <- c("Symbol", "Original.Receiver", "Source.Section", "CT.Address", "Builtin?", "Observed.Receiver")
  data <- fread(filename, header = FALSE, sep="\t", col.names = col_names)
  benchmark_name <- str_match(filename, "parsed\\_(.*?)\\.mylog")[2]
  data$Benchmark <- benchmark_name
  return(data)
}

dt_clean_data_file <- function(df_p, keep_blocks) {
  if (keep_blocks) {
       df_p <- data[`Builtin?` %like% "PROC|LAMBDA|block"] 
  }
  else {
       df_p <- data[!(`Builtin?` %like% "PROC|LAMBDA|block")] 
  }

  df_p <- na.omit(df_p) #remove rows containing NA
  df_p[, Call.ID := 1:.N] #add a row number
  df_p <- df_p[, lapply(.SD, str_trim)] # trim all whitespaces

  return (df_p)
}

dt_add_number_receivers <- function(df) { 
  data[ , 
      `:=`(Num.Receiver.Observed = n_distinct(Observed.Receiver), 
       Num.Receiver.Original = n_distinct(Original.Receiver)), 
       by=list(Source.Section, Symbol, Benchmark)]
}

dt_generate_table_one <- function(dt) {
  dt_p <- dt[ , .(Num.Calls = n_distinct(Call.ID), 
                                 Num.Call.Sites = n_distinct(Source.Section, Symbol),
                              Benchmark),
                          by = "Num.Receiver"][, dcast(.SD, 
                                                       Benchmark ~ Num.Receiver,
                                                       value.var = c("Num.Calls", "Num.Call.Sites"))]
  return(dt_p)
}