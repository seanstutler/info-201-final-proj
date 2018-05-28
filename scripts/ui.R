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
               #selectInput("type",
                 #          label = "Choose Indicator",
                  #         choices = list("Employment"
                   #                       = "Employment to population ratio, 15+,
                    #                      total (%) (national estimate)",
                     #                     "Exports" =
                      #                      "Exports of goods and services (current US$)",
                      #                    "Imports" =
                     #                       "Imports of goods and services (current US$)",
                     #                     "Life Expectancy" =
                         #                   "Life expectancy at birth, total (years)",
                          #                "Literacy" =
                          #                  "Literacy rate, adult total (% of people ages 15 and above)",
                           #               "Total GDP" =
                            #                "GDP (current US$)",
                             #             "GDP Per Capita" =
                             #               "GDP per capita (current US$)")),
               selectInput("region",
                           label = "Choose Region",
                           choices = list("World" = "world",
                                          "Asia" = "asia",
                                          "Africa" = "africa",
                                          "South America" = "south america",
                                         "North America" = "north america",
                                         "Europe" = "europe"
                              ))
               #selectInput("income group",
                 #          label = "Choose Income Group",
                   #        choices = list("High Income" = "High income",
                      #      "Upper Middle Income" = "Upper middle income",
                      #     "Lower Middle Income" = "Lower middle income",
                       #    "Low Income" = "Low income")),
              # "If the hovered data of GDP is 0, then it means that the data currently
             #  is not available :)"
             ),
             mainPanel(
               plotOutput("map")
             )
          )
  ),
  tabPanel("About us",
           h2("Introduction"),
           p("Greetings! Welcome to the 'Analysis of Country Development by Indicators' presented
             by Clayton Chen, Sean Yang, Jessie Yang and Velocity Yu from INFO 201 BA. We are
             proud to bring you guys this great interactive program that allows users to view
             the trend of a certain developmemt indicators of a certain country by click. Also,
             the map we presented is colorized by 2016 total GDP."),
           h3("About our group")


  )
))
