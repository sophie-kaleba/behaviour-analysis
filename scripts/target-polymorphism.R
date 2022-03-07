check_invalid_transition <- function(df_p) {
    df <- df_p %>%
    dplyr::mutate(Invalid.Status = case_when(Cache.Type.Original == "MONO" & Num.Targets.Observed == "POLY" ~ 'TRUE',
                                           Cache.Type.Original == "MONO" & Num.Targets.Observed == "MEGA" ~ 'TRUE',
                                           Cache.Type.Original == "POLY" & Num.Targets.Observed == "MEGA" ~ 'TRUE')) 
    testit::assert("Changes of cache status are only allowed from high degree of polymoprhism to low degree of polymoprhism", nrow(df %>%  dplyr::filter(grepl('TRUE', Invalid.Status))) == 0)
    df <- dplyr::select(df, -Invalid.Status) #We can safely drop this column then
    return(df)
}


has_changed_status <- function(df_p, benchmark=NULL) {
  df <- df_p %>%
    group_by_at(c("Has.Changed.Status", benchmark)) %>%
    dplyr::rename(Value = Has.Changed.Status) %>%
    dplyr::summarise(Has.Changed.Status = n_distinct(Symbol, CT.Address, Source.Section)) 
  return(df)
}

has_experienced_tp <- function(df_p, benchmark=NULL) {
  df <- df_p %>%
    group_by_at(c("Target.Polymorphism", benchmark)) %>%
    dplyr::rename(Value = Target.Polymorphism) %>%
    dplyr::summarise(Target.Polymorphism = n_distinct(Symbol, CT.Address, Source.Section))
  return(df)
}