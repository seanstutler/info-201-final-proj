library(dplyr)

# read the csv file
data <- read.csv("../origin_data/WDI_csv/WDIData.csv", stringsAsFactors = FALSE)

# filter all the data about 'Life expectancy at birth, total (years)', delete
# the column with all NAs
my_data <- data %>%
  filter(Indicator.Name == 'Life expectancy at birth, total (years)') %>%
  select(-X2017, -X)

# Replace all NA with the string "Not Available"
my_data[is.na(my_data)] <- "Not Available"

# write a new csv data
write.csv(my_data, file = "../processed_data/life_exp.csv",
          row.names = FALSE)
