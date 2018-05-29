library(plotly)
country_data <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
# credit to https://plot.ly/r/choropleth-maps/

choose_region <- function(data, region, selector) {
  if (selector != " ") {
    income <- read.csv(file = "../processed_data/income_indicators.csv", stringsAsFactors = FALSE)
    income <- income %>%
      select()
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
  return(p)

}
