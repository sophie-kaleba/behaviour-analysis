# Provide a list of splitted-call sites
# Add: Times.Splitted, the number of times a call-site has been splitted
generate_splitting_summary <- function(df_p, chosen_cols, benchmark=NULL) {
  df <- df_p %>%
    select(all_of(chosen_cols)) %>%
    group_by_at(c(Call.Site, "Observed.Receiver")) %>%
    dplyr::summarise(Times.splitted = n_distinct(CT.Address) - 1, Num.Calls = n_distinct(Call.ID))  %>%  # -1 otherwise we count the call-sites that have one call target (ie not splitted)
    group_by_at(benchmark) %>%
    dplyr::mutate(Frequency = round(Num.Calls/sum(Num.Calls),7)*100) %>%
    dplyr::filter(Times.splitted > 0)
  return(df)
}

summary_splitting_transition <- function() {
  
}


