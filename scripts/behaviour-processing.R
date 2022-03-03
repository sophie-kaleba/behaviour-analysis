Call.Site.Target <- c("Source.Section", "Symbol", "CT.Address")
Call.Site <- c("Source.Section", "Symbol")

load_all_data <- function (folder, data_file_prefix = "") { 
  result <- NULL
  files <- sort(list.files(folder, paste0(data_file_prefix, "[0-9]+")))
  
  for (f in files) {
    data <- load_data_file(paste(folder, f, sep = "/"))
    data$Benchmark <- benchmark_name
    result <- rbind(result, data)
  }
  return(result)
}


load_data_file <- function(filename) {
  read_splitting_profiling_file(filename)  
}

count_things <- function(df, grouped) {
    n_distinct(df %>% dplyr::select(all_of(grouped))) 
}

add_number_receivers <- function(df, call_site) {
    df %>%
    group_by_at(call_site) %>%
    dplyr::mutate(Num.Receiver.Observed = n_distinct(Observed.Receiver)) %>%
    dplyr::mutate(Num.Receiver.Original = n_distinct(Original.Receiver)) %>%
    ungroup() 
}

#' Return a data frame that summarises polymoprhic behaviour in this run, takes splitting into account
# Add: Num.Call.Sites (the number of call-sites associated with a given number of receivers), Cumulative
#' @param num_receiver_column, whether we consider the observed or the original number of receivers  
#' @param ct_address, whether we consider splitting 
compute_num_target_details <- function(df_p, call_site_type, receiver_type) {
  df <- df_p %>%
    select(c(call_site_type, !! sym(receiver_type), Call.ID)) %>% 
    dplyr::group_by_at(call_site_type) %>%
    dplyr::summarise(Num.Receiver = dplyr::n_distinct(!! sym(receiver_type)), Num.Calls = n_distinct(Call.ID)) %>%
    group_by(Num.Receiver)  %>%
    dplyr::summarise(Num.Call.Sites = n(), Num.Calls=sum(Num.Calls)) %>%
    dplyr::mutate(Frequency = round(Num.Calls/nrow(df_p),7)*100) %>%
    dplyr::mutate(Cumulative.Call.Sites = rev(cumsum(rev(Num.Call.Sites)))) %>%
    dplyr::mutate(Cumulative.Calls = rev(cumsum(rev(Num.Calls)))) %>%
    dplyr::mutate(Cumulative.Freq = rev(cumsum(rev(Frequency))))
  return(df)
}

