# Library
library(shiny)
library(plotly)
library(ggplot2)
library(DT)
library(dplyr)

# Read in data
source("compare_indicators.R")
source("map.R")
source("compare_between_countries.R")
data <- read.csv(file = "../processed_data/country_indicators.csv",
               stringsAsFactors = FALSE)
data <- data %>%
  select(-X)

# Start the shiny server
shinyServer(function(input, output) {

  output$map <- renderPlotly({
    return(choose_region(data, input$region, input$`income group`, input$type))
  })

  # Render a plotly scatter object
  output$scatter <- renderPlot({
    return(compare_indicators(input$type1, input$type2, input$country2))
  })

  output$compare <- renderPlotly({
    return(compare_between_countries(input$indicator, input$name))
  })

  output$myTable <- DT::renderDataTable({
    DT::datatable(data[, input$show_vars, drop = FALSE],
                  options = list(orderClasses = TRUE))
  })

  output$downloadButton <- downloadHandler(
    filename = function() {
      paste0(input$downloadData, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(file, row.names = FALSE)
    }
  )

})
