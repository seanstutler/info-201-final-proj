#load library
library(shiny)
library(ggplot2)
#construct ui

shinyUI(navbarPage(
  theme = "style.css",
  "Analysis of Country Development by Indicators",
  #tab 1
  tabPanel("Visualization",
           titlePanel("Map of countries' GDP and plots by indicators"),
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
                                            "Literacy rate, adult total (% of people ages 15 and above)",
                                          "Total GDP" =
                                            "GDP (current US$)",
                                          "GDP Per Capita" =
                                            "GDP per capita (current US$)")),
               selectInput("country",
                           label = "Choose Region",
                           choices = list("World" = "world",
                                          "Asia" = "asia",
                                          "Africa" = "africa",
                                          "South America" = "south america",
                                         "North America" = "north america",
                                         "Europe" = "europe"
                              )),
               selectInput("income group",
                           label = "Choose Income Group",
                           choices = list("High Income" = "High income",
                            "Upper Middle Income" = "Upper middle income",
                           "Lower Middle Income" = "Lower middle income",
                           "Low Income" = "Low income")),
               "If the hovered data of GDP is 0, then it means that the data currently
               is not available :)"
             ),
             mainPanel(
               plotOutput("map")
             )
           )
  )
))
