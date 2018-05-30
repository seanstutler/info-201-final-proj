# extract data from wdicountry

# load library
library(dplyr)

# read csv
country_data <-
  read.csv(
    file = "../origin_data/WDICountry.csv",
    stringsAsFactors = FALSE
  )
series_data <- read.csv(
  file = "../origin_data/WDICountry-Series.csv",
  stringsAsFactors = FALSE
)
# extract countries
country <- series_data$CountryCode

# processed data
region_data <- country_data %>%
  filter(Country.Code %in% country | Country.Code == "WLD") %>%
  select(Country.Code, Short.Name, Region) %>%
  filter(Region != "" | Country.Code == "WLD")

incomegroup_data <- country_data %>%
  filter(Country.Code %in% country) %>%
  filter(Income.Group != "") %>%
  select(Country.Code, Short.Name, Income.Group)

# write data
write.csv(region_data,
  file = "../processed_data/region.csv",
  row.names = FALSE
)
write.csv(incomegroup_data,
  file = "../processed_data/income_group.csv",
  row.names = FALSE
)
