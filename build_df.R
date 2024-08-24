df <- data.frame(
  population_type = c(),
  region = c(),
  city = c(),
  year = c(),
  total = c(),
  asian = c(),
  black = c(),
  hispanic = c(),
  other = c(),
  white = c()
)
build_data_frame <- function(census, population_type) {
  cities <- census$full_name %>% unique()
  years <- census$year %>% unique()
  
  for (c in cities) {
    region <- get_region(c)
    for (y in years) {
      filtered_census <- 
        census %>%
        filter(year == y & full_name == c)
      new_row <- data.frame(
        population_type = population_type,
        region = region,
        city = c,
        year = y,
        # all the totals are the same so just take the first
        total = filtered_census$total[[1]],
        asian = filtered_census %>% filter(race == 'Non-Hispanic Asian' & year == y) %>% pull(count),
        black = filtered_census %>% filter(race == 'Non-Hispanic Black' & year == y) %>% pull(count),
        hispanic = filtered_census %>% filter(race == 'Hispanic/Latino' & year == y) %>% pull(count),
        other = filtered_census %>% filter(race == 'Other' & year == y) %>% pull(count),
        white = filtered_census %>% filter(race == 'Non-Hispanic White' & year == y) %>% pull(count)
      )
      df <- rbind(df, new_row)
    }
  }
  return(df)
}