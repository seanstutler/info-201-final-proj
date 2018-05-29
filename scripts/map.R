library(plotly)
country_data <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
# credit to https://plot.ly/r/choropleth-maps/

choose_region <- function(data, region, selector) {
  if (selector != "General") {
    data[data$Income.Group != selector, ]$Income.Group <- 0
    data[data$Income.Group == selector, ]$Income.Group <- 1
  }

  l <- list(color = toRGB("grey"), width = 0.5)

  g <- list(
    scope = region,
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = "natural earth")
  )

  gdp <- data[data$Indicator.Name == "GDP (current US$)", ]
  gdp$X2016 <- gdp$X2016 / 1000000000

  if (selector != "General") {
    p <- plot_geo(gdp) %>%
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
    p <- plot_geo(gdp) %>%
      add_trace(
        z = ~X2016, color = ~X2016, colors = 'Greens',
        text = ~Country.Name, locations = ~Country.Code, marker = list(line = l)
      ) %>%
      colorbar(title = 'GDP Billions US$ (2016)', tickprefix = '$') %>%
      layout(
        title = "World Map",
        geo = g
      )
  }
  return(p)

}
