library(plotly)
country_data <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
# credit to https://plot.ly/r/choropleth-maps/

choose_region <- function(data, region, selector, indicator) {
  if (selector != "General") {
    data[data$Income.Group != selector, ]$Income.Group <- 0
    data[data$Income.Group == selector, ]$Income.Group <- 1
  }
  name <- indicator
  l <- list(color = toRGB("grey"), width = 0.5)

  g <- list(
    scope = region,
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = "natural earth")
  )

  if (selector != "General") {
    p <- plot_geo(data) %>%
      add_trace(
        z = ~Income.Group, color = ~Income.Group,
        text = ~Country.Name, locations = ~Country.Code, marker = list(line = l)
      ) %>%
      layout(
        title = "World Map",
        geo = g
      ) %>%
      hide_colorbar()
  } else {
    if (indicator == "GDP (current US$)") {
      frame <- data[data$Indicator.Name == "GDP (current US$)", ]
      frame$X2016 <- frame$X2016 / 1000000000
    } else if (indicator == "GDP per capita (current US$)") {
      frame <- data[data$Indicator.Name == "GDP per capita (current US$)", ]
      frame$X2016 <- frame$X2016 / 1000000000
    } else {
      frame <- data[data$Indicator.Name == indicator, ]
      if (indicator == "Employment to population ratio, 15+, total (%) (national estimate)") {
        name <- "Employment/Population"
      }
    }

    p <- plot_geo(frame) %>%
      add_trace(
        z = ~X2015, color = ~X2015, colors = 'Greens',
        text = ~Country.Name, locations = ~Country.Code, marker = list(line = l)
      ) %>%
      colorbar(title = name) %>%
      layout(
        title = "World Map",
        geo = g
      )
  }
  return(p)

}

choose_region(country_data, "world", "General", "GDP (current US$)")
