library(plotly)
library(ggplot2)
library(dplyr)

compare_between_countries <- function(indicator, name) {
  df <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
  year_list <- df %>%
    select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code, -X2017, -X, -Income.Group) %>%
    colnames()

  year_list <- gsub("X", "", year_list)

  year_list <- as.list(year_list)
  if (length(name) == 0) {
    print("Please select at least one country")
  } else {
    df_trend <- df %>%
      filter(Indicator.Name == indicator) %>%
      filter(Country.Name %in% name) %>%
      select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code, -X, -X2017, -Income.Group)

    length <- length(name)
    frame <- data.frame()
    for (i in 1:length) {
      datalist <- list()
      colnames <- colnames(df_trend)
      j <- 1
      for (col in colnames) {
          datalist[[j]] <- df_trend[i, col]
          j = j + 1
        }
      new <- do.call(rbind, Map(data.frame, Year = year_list, indicator = datalist))
      new$var <- i
      frame <- rbind(frame, new)
    }

    gg <- ggplot(data = frame, aes(x = Year, y = indicator, group = var, colour = var)) + geom_line() +
      theme(axis.text.x = element_blank(),
            axis.ticks.x = element_blank())

    # Convert ggplot object to plotly
    gg <- plotly_build(gg) %>%
      hide_colorbar()
    return(gg)
  }
}


compare_between_countries("GDP (current US$)", list("China", "Japan", "Italy"))
