# install packages
library(ggplot2)
library(dplyr)
library(tidyverse)
library(data.table)

# set this to whatever your current working directory is
setwd('/Users/jack/Desktop/sab')
# import get_region function

source('get_region.R')
source('build_df.R')
source('get_percents.R')

# load census data
census <- fread('CENSUS_STACKED_FINAL.csv')
# only take necessary columns
# drop any nil values
census <- census[ ,c('total_pop', 'year', 'race', 'full_name', 'count')] %>%
  filter(!is.na(total_pop)) %>%
  filter(!is.na(count)) %>%
  filter(!is.na(race)) %>%
  filter(!is.na(year))

# load suburb data
suburb <- fread('SUBURB_STACKED_FINAL.csv')
# only take necessary columns
# drop any nil values
suburb <- suburb[ ,c('total_pop', 'year', 'race', 'full_name', 'count')] %>%
  filter(!is.na(total_pop)) %>%
  filter(!is.na(count)) %>%
  filter(!is.na(race)) %>%
  filter(!is.na(year))

census_df <- build_data_frame(census, 'census')
suburb_df <- build_data_frame(suburb, 'suburb')

df <- rbind(census_df, suburb_df)

#df <- df %>% mutate_if(is.numeric, scale)


row <- df %>% filter(population_type == 'census' & year == 1990 & city == 'Los Angeles, CA')
get_percents(row)

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


