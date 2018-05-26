# Library
library(shiny)

# Read in data
source('return_graph_from_param.R')
df <- read.csv('../processed_data/filted_general_data.csv', stringsAsFactors = FALSE)
income_group <- read.csv('../processed_data/income_group.csv', stringsAsFactors = FALSE)
income_indi <- read.csv('../processed_data/income_indicators.csv', stringsAsFactors = FALSE)
life_exp <- read.csv('../processed_data/life_exp.csv', stringsAsFactors = FALSE)
region <- read.csv('../processed_data/region.csv', stringsAsFactors = FALSE)

# Start the shiny server
shinyServer(function(input, output) {

  # Render a plotly object
  output$scatter <- renderPlotly({
    return(return_graph_from_param(df, input$country))
  })
})
