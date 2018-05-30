library(dplyr)

# read csv
country_names <- read.csv(
  file = "./processed_data/region.csv",
  stringsAsFactors = FALSE
)
income_group <- read.csv(
  file = "./processed_data/income_group.csv",
  stringsAsFactors = FALSE
)

# this is the huge data getting from
# https://datacatalog.worldbank.org/dataset/world-development-indicators
# but it is too big to upload to github
data <- read.csv(file = "./origin_data/WDIData.csv", stringsAsFactors = FALSE)
country_names_list <- country_names$Country.Code
income_type <- income_group %>%
  select(Income.Group, Country.Code)

# this will filter the data we want
process <- function(data, list) {
  processed <- data %>%
    filter(Indicator.Name ==
      "Employment to population ratio, 15+, total (%) (national estimate)" |
      Indicator.Name == "GDP per capita (current US$)" |
      Indicator.Name == "Exports of goods and services (current US$)" |
      Indicator.Name == "Imports of goods and services (current US$)" |
      Indicator.Name == "Life expectancy at birth, total (years)" |
      Indicator.Name ==
        "Literacy rate, adult total (% of people ages 15 and above)" |
      Indicator.Name == "GDP (current US$)") %>%
    filter(Country.Code %in% list)

  return(processed)
}

country <- process(data, country_names_list)

# add income type for each country
country <- full_join(country, income_type, by = "Country.Code")

country[is.na(country)] <- 0

# write csv
write.csv(country,
  file = "./processed_data/country_indicators.csv",
  row.names = FALSE
)
