#extract data from wdicountry

#load library
library(dplyr)

#read csv
country_data <-
  read.csv(file = "../origin_data/WDI_csv/WDICountry.csv",
           stringsAsFactors = FALSE)

country_data <- country_data %>%
  filter(Region == "South Asia" | Region == "Europe & Central Asia" |
           Region == "East Asia & Pacific") %>%
  select(Country.Code, Short.Name, Region, Income.Group) %>%
  arrange(Short.Name)

write.csv(country_data, file = "../processed_data/country.csv",
          row.names = FALSE)
