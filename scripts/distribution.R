build_summary_df <- function(col, benchmark_name) {
  sum_bench <- as.data.frame(t(quantile(col, probs = c(0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1)))) %>%
                  mutate("Mean" = mean(col), "Median" = median(col)) %>%
                  mutate("Min"= min(col), "Max" = max(col))
  row.names(sum_bench) <- c(benchmark_name)
  return(sum_bench)
}


build_distribution_plots <- function(df, metrics) {
  plot_list <- list()
  
  data_mod <- melt(df, id.vars='Benchmark', measure.vars=metrics)
  p <- ggplot(data_mod, aes(x=Benchmark, y=value, color=variable)) + 
      geom_boxplot() + ylab("Number of targets per call-site") + ggtitle("Number of different targets per call-site - distribution")
    plot_list[[1]] <- p
  #for (i in 1:length(metrics)) {
  #  m <- metrics[[i]]
    # p <- ggplot(data, aes(x=Benchmark, y=.data[[m]])) + 
    #   geom_boxplot() + ylab("Number of targets per call-site") + ggtitle("Number of different targets per call-site - distribution")
    # plot_list[[i]] <- p
  #}
  
   # collaspe together to have the 3 stages in one plot
  violin <-ggplot(data_mod, aes(x=Benchmark, y=value, color=variable)) + geom_violin() +
    ylab("Number of targets per call-site") + ggtitle("Number of different targets per call-site - distribution")
  plot_list[[2]] <- violin
  return(plot_list)
}