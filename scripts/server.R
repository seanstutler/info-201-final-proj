# Library
library(shiny)

# Read in data
source('return_graph_from_param.R')
df <- read.csv('../processed_data/country_indicators.csv',
               stringsAsFactors = FALSE)

# Start the shiny server
shinyServer(function(input, output) {

  # Render a plotly scatter object
  output$scatter <- renderPlotly({
    return(return_graph_from_param(df, input$type, input$country))
  })

})
