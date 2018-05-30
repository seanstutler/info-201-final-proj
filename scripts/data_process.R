library(dplyr)

country_names <- read.csv(file = "../processed_data/region.csv",
                          stringsAsFactors = FALSE)
income_group <- read.csv(file = "../processed_data/income_group.csv",
                         stringsAsFactors = FALSE)
data <- read.csv(file = "../origin_data/WDIData.csv", stringsAsFactors = FALSE)
country_names_list <- country_names$Country.Code
income_type <- income_group %>%
    select(Income.Group, Country.Code)


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

country <- full_join(country, income_type, by = "Country.Code")

country[is.na(country)] <- 0

write.csv(country, file = "../processed_data/country_indicators.csv",
          row.names = FALSE)
