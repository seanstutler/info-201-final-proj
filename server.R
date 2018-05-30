# Library
library(shiny)
library(plotly)
library(ggplot2)
library(DT)
library(dplyr)

# Read in data
source("./scripts/compare_indicators.R")
source("./scripts/map.R")
source("./scripts/compare_between_countries.R")

data <- read.csv(file = "./processed_data/country_indicators.csv",
               stringsAsFactors = FALSE)

region <- read.csv(file = "./processed_data/region.csv",
               stringsAsFactors = FALSE)

data <- data %>%
  select(-X)

# Start the shiny server
shinyServer(function(input, output) {

  # Render a plotly map object
  output$map <- renderPlotly({
    return(choose_region(data, input$region, input$`income group`, input$type))
  })

  # Render a plotly scatter object, which choose two indicators and one country
  output$scatter <- renderPlot({
    return(compare_indicators(input$type1, input$type2, input$country2))
  })

  # Render a plotly scatter object, which could choose one indicator and
  # compare with multiple countries
  output$compare <- renderPlotly({
    return(compare_between_countries(input$indicator, input$name))
  })

  # Learn from (Shiny from RStudio: How to use DataTables in a Shiny App)
  # Create the table based on the country_indicators csv file
  output$data <- DT::renderDataTable({
    DT::datatable(data[, input$show_vars, drop = FALSE],
                  options = list(lengthMenu = c(25, 50), orderClasses = TRUE))
  })

  # Create the table based on the region csv file
  output$region <- DT::renderDataTable({
    DT::datatable(region)
  })

})
