library(plotly)
library(ggplot2)
library(dplyr)

compare_between_countries <- function(indicator, name) {
  name <- list("China", "Italia", "Japan", "Canada")
  name <- unlist(name, use.names = FALSE)
  indicator <- "Exports of goods and services (current US$)"
  df <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
  year_list <- df %>%
    select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code, -X2017, -X, -Income.Group) %>%
    colnames()

  year_list <- as.list(year_list)
  if (length(name) == 0) {
    print("Please select at least one country")
  } else {
    df_trend <- df %>%
      filter(Indicator.Name == indicator) %>%
      filter(Country.Name %in% name)

    # Graph title
    #if (length(name) > 2) {
    #  j_names_comma <- paste(name[-length(name)], collapse = ', ')
    #  j_names <- paste0(j_names_comma, ", and ", name[length(name)])
    #} else {
    #  j_names <- paste(name, collapse = ' and ')
    #}

    #graph_title  <- paste("Compare between ", j_names, sep="")
    length <- length(name)
    a <- list()
    for (i in 1:length) {
      datalist <- list();
      colnames <- colnames(df);
      j <- 1
      for (col in colnames) {
        if (col != "Country.Name" & col != "Country.Code" &
            col != "Indicator.Name" & col != "Indicator.Code" &
            col != "X" & col != "X2017" & col != "Income.Group") {
          datalist[[j]] <- df[i, col]
          j = j + 1
        }
      }
      a[[i]] <- datalist
    }
    frame <- data.frame()
    for (i in 1:length(a)) {
      new <- do.call(rbind, Map(data.frame, Year = year_list, country = a[[i]]))
      new$group <- i
      frame <- rbind(frame, new)
    }
  }


    ggideal_point <- ggplot(frame, aes(x = Year, y = country, group = group, col = group, fill = group)) + geom_line()

    # Convert ggplot object to plotly
    gg <- plotly_build(ggideal_point)
    return(gg)
  }


compare_between_countries("GDP (current US$)", list("China", "Japan"))
