library(dplyr)
country_names <- read.csv(file = "../processed_data/region.csv", stringsAsFactors = FALSE)
income_group <- read.csv(file = "../processed_data/income_group.csv", stringsAsFactors = FALSE)
data <- read.csv(file = "../origin_data/WDIData.csv", stringsAsFactors = FALSE)
country_names_list <- country_names$Country.Code
income_list <- income_group$Country.Code
income_type <- income_group %>%
  select(income_group)


process <- function(data, list, name) {
  processed <- data %>%
    filter(Indicator.Name == "Employment to population ratio, 15+, total (%) (national estimate)" |
                 Indicator.Name == "GDP per capita (current US$)" |
                 Indicator.Name == "Exports of goods and services (current US$)" |
                 Indicator.Name == "Imports of goods and services (current US$)" |
                 Indicator.Name == "Life expectancy at birth, total (years)" |
                 Indicator.Name == "Literacy rate, adult total (% of people ages 15 and above)") %>%
    filter(Country.Code %in% list)



  processed[is.na(processed)] <- "Not Available"
  write.csv(processed, file = paste0("../processed_data/", name, ".csv"), row.names = FALSE)
}

process(data, country_names_list, "country_indicators")

process(data, income_list, "income_indicators")
