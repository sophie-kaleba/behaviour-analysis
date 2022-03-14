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

analyse_splitting_transitions <- function(df_p, benchmark_name) {

  #prepare the data frame for analysis
  raw_splitting <- df_p %>%
    group_by_at(Call.Site) %>%
    dplyr::mutate(Times.splitted = n_distinct(CT.Address) - 1, Num.Calls = n_distinct(Call.ID))
  raw_splitting <- raw_splitting %>% dplyr::select(Call.ID, Symbol, Source.Section, CT.Address, Observed.Receiver, Benchmark, Num.Receiver.Observed, Cache.Type.Observed, Times.splitted, Num.Calls)

  # and export it as a csv file so our java program can analyse it
  split_file <-  paste(getwd(),"/",benchmark_name,"splitting_data.csv", sep="")
  out_split_file <- paste(getwd(),"/","out_",benchmark_name,"splitting_data.csv", sep="")
  write.csv(raw_splitting, split_file, row.names = FALSE)

  # call the java program to analyze the data, and then fetch back the results
  command <- paste("cd ./splitting-transition/out/production/splitting-transition/ ; java CallSiteAnalyzer ", split_file, " ", out_split_file, sep="")
  system(command)  

  row_names <- c("Source.Section", "Symbol", "Start.ID", "End.ID", "Start.State", "End.State", "Start.Cache.Size", "End.Cache.Size", "Union.Size", "Intersect.Size", "Benchmark")
  transition_data <- read.csv(out_split_file, header = FALSE, sep = ",", row.names=NULL, col.names=row_names) 
  return(transition_data)
}


summarise_transition <- function(df_p) {
  transition_data <- df_p %>%
    dplyr::mutate(Transition.Type = case_when( Start.State == 'POLYMORPHIC' & End.State == 'POLYMORPHIC' & Intersect.Size == Union.Size ~ "Same",
                                             Start.State == 'MONOMORPHIC' & End.State == 'MONOMORPHIC' & Intersect.Size == Union.Size ~ "Same",
                                             Start.State == 'MEGAMORPHIC' & End.State == 'MEGAMORPHIC' & Intersect.Size == Union.Size ~ "Same",
                                             TRUE ~ "Different")) %>%
    group_by(Benchmark, Start.State, End.State, Transition.Type) %>%
    dplyr::summarise(Num.Transitions = n())

  transition_data <- transition_data %>% 
    tidyr::unite("Transition", Start.State:End.State, remove = TRUE, sep=" -> ") %>%
    tidyr::unite("Transition", Transition:Transition.Type, remove = TRUE, sep="_") %>%
    tidyr::spread(Transition, Num.Transitions)

  return(transition_data)

}








