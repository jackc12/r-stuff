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
source('graph.R')

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

graph(df)