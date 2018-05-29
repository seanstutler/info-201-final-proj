# Library
library(shiny)
library(plotly)
library(ggplot2)

# Read in data
source('return_graph_from_param.R')
source('map.R')
df <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)

# Start the shiny server
shinyServer(function(input, output) {

  output$map <- renderPlotly({
    return(choose_region(df, input$region, input$`income group`, input$type))
  })

  # Render a plotly scatter object
  output$scatter <- renderPlotly({
    return(return_graph_from_param(input$type, input$country))
  })

  output$compare <- renderPlot({
    y <- df[[input$indicator]]
  })

})
