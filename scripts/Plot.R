library(plotly)
library(dplyr)

# read .csv
country <- read.csv("../processed_data/country.csv", stringsAsFactors = FALSE)
map <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
View(country)
