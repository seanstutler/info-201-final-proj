library(plotly)
library(ggplot2)
library(dplyr)

compare_between_countries <- function(indicator, name) {
  df <- read.csv(file = "../processed_data/country_indicators.csv",
                 stringsAsFactors = FALSE)
  year_list <- df %>%
    select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code,
           -X2017, -X, -Income.Group) %>%
    colnames()

  year_list <- gsub("X", "", year_list)

  year_list <- as.list(year_list)
  if (length(name) == 0) {
    graph <- geom_blank(mapping = NULL, data = NULL)
    return(graph)
  } else {
    df_trend <- df %>%
      filter(Indicator.Name == indicator) %>%
      filter(Country.Name %in% name) %>%
      select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code,
             -X, -X2017, -Income.Group)

    length <- length(name)
    frame <- data.frame()
    for (i in 1:length) {
      datalist <- list()
      colnames <- colnames(df_trend)
      j <- 1
      for (col in colnames) {
          datalist[[j]] <- df_trend[i, col]
          j <- j + 1
        }
      new <- do.call(rbind, Map(data.frame, Year = year_list, value = datalist))
      new$Country <- name[[i]]
      frame <- rbind(frame, new)
    }

    title <- paste0("Year VS ", indicator)

    gg <- ggplot(data = frame, aes(x = Year, y = value, group = Country,
                                   colour = Country)) + geom_line() +
      theme(axis.text.x = element_blank(),
            axis.ticks.x = element_blank()) +
      ggtitle(title) +
      xlab("Year") +
      ylab(indicator)


    # Convert ggplot object to plotly
    gg <- plotly_build(gg)
    return(gg)
  }
}
