graph <- function(df) {
  regions <- df$region %>% unique()
  years <- df$year %>% unique()
  population_types <- df$population_type %>% unique()
  
  for(r in regions) {
    region_df <- 
      df %>% filter(region == r)
    cities <- region_df$city %>% unique()
    red <- c()
    orange <- c()
    yellow <- c()
    grey <- c()
    blue <- c()
    
    for(c in cities) {
      for(y in years) {
        row <- region_df %>%
          filter(population_type == 'census' & year == y & city == c)
        percents <- get_percents(row)
        if(percents %>% sum() == 1) {
          print('good')
        }
        red <- c(red, percents[[1]])
        orange <- c(orange, percents[[2]])
        yellow <- c(yellow, percents[[3]])
        grey <- c(grey, percents[[4]])
        blue <- c(blue, percents[[4]])
        
      }
    }
    # Example data
    data <- data.frame(
      City = rep(cities, each = 2),
      Year = rep(years, times = 5),
      `Red` = red,
      `Orange` = orange,
      `Yellow` = orange,
      `Grey` = grey,
      `Blue` = blue
    )
    
  }
  
  # Reshape the data
  data_long <- data %>%
    gather(key = "Color", value = "Percentage", -City, -Year)
  
  # Reorder levels for plotting
  data_long$Color <- factor(data_long$Color, levels = c("Grey", "Yellow", "Orange", "Red", "Blue"))
  
  # Plot
  ggplot(data_long, aes(x = as.factor(Year), y = Percentage, fill = Color)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = paste0(Percentage, "%")),
              color = "black", size = 3) +
    facet_wrap(~ City, nrow = 1) +
    scale_fill_manual(values = c("grey", "yellow", "orange", "red", "blue")) +
    labs(x = NULL, y = "Percentage", title = "Demographic Composition Over Time") +
    theme_minimal() +
    theme(strip.text = element_text(size = 10, face = "bold"),
          axis.title.y = element_text(size = 10, face = "bold"),
          axis.text.x = element_text(size = 8, face = "bold"),
          axis.text.y = element_text(size = 8, face = "bold"),
          legend.title = element_blank())
  
  
  
}