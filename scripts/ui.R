#load library
library(shiny)
library(ggplot2)
#construct ui

shinyUI(navbarPage(
  theme = "style.css",
  "PUT Title HERE",
  #tab 1
  tabPanel("View Data by Region",
           titlePanel("THIS IS THE TAB TITLE"),
           #side bar
           sidebarLayout(
             sidebarPanel(
               selectInput("type",
                           label = "Choose Indicator",
                           choices = list("Employment"
                                          = "Employment to population ratio, 15+,
                                          total (%) (national estimate)",
                                          "Exports" =
                                            "Exports of goods and services (current US$)",
                                          "Imports" =
                                            "Imports of goods and services (current US$)",
                                          "Life Expectancy" =
                                            "Life expectancy at birth, total (years)",
                                          "Literacy" =
                                            "Literacy rate, adult total (% of people ages 15 and above")),
               selectInput("country",
                           label = "Choose Region",
                           choices = list("REGION 1" = "REGION NAME IN COL"))
             ),
             mainPanel(
               plotOutput("scatter")
             )
           )
  )
))
