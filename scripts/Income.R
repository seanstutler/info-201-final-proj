library(ggplot2)
library(dplyr)

# read .csv data
country <- read.csv("../processed_data/country.csv", stringsAsFactors = FALSE)

# See the number of countrie with different level of income
high_income <- country %>%
  filter(Income.Group == "High income") %>%
  nrow()
low_income <- country %>%
  filter(Income.Group == "Low income") %>%
  nrow()
upper_middle_income <- country %>%
  filter(Income.Group == "Upper middle income") %>%
  nrow()
lower_middle_income <- country %>%
  filter(Income.Group == "Lower middle income") %>%
  nrow()

# Draw the bar plot of the the income information
plot <- ggplot(data = country) +
  geom_bar(mapping = aes(x = Income.Group, fill = Region)) +
  labs(title = "Income Information", x = "Income", y = "Country Count")
ggsave(plot, file = "income.png", scale = 1.5)
