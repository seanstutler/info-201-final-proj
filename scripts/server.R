# Library
library(shiny)
library(plotly)
library(ggplot2)

# Read in data
source('compare_indicators.R')
source('map.R')
source('compare_between_countries.R')
df <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)

# Start the shiny server
shinyServer(function(input, output) {

  output$map <- renderPlotly({
    return(choose_region(df, input$region, input$`income group`, input$type))
  })

  # Render a plotly scatter object
  output$scatter <- renderPlot({
    return(compare_indicators(input$type1, input$type2, input$country2))
  })

  output$compare <- renderPlotly({
    return(compare_between_countries(input$indicator, input$name))
  })

})
