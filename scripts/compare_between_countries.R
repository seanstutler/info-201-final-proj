library(plotly)
library(ggplot2)
library(ggthemes)

compare_between_countries <- function(indicator, name) {
  name <- list("China", "Japan")
  name <- unlist(name, use.names = FALSE)
  indicator <- "GDP (current US$)"
  df <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
  year_list <- df %>%
    select(-Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code, -X2017, -X)%>%
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
    combine <- c()
    for (i in 1:length) {
      datalist <- list();
      colnames <- colnames(df);
      j <- 1
      for (col in colnames) {
        if (col != "Country.Name" & col!= "Country.Code" &
            col != "Indicator.Name" & col != "Indicator.Code" &
            col != "X" & col != "X2017" & col != "Income.Group") {
          datalist[[j]] <- df[i, col]
          j = j + 1
        }
      }
      a[[i]] <- datalist
    }
    a <- as.list(a)
      total_data <- do.call(rbind, Map(data.frame, Year = year_list, name = a))

    ggideal_point <- ggplot(df_trend) +
      geom_line(aes(x = year_list, y = China, colour = Country.Name)) +
      labs(x = "Year", y = indicator)

    # Convert ggplot object to plotly
    gg <- plotly_build(ggideal_point)
    return(gg)
  }
}

compare_between_countries("GDP (current US$)", list("China", "Japan"))
