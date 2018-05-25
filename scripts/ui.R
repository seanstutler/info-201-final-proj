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
               selectInput("REGION VAR NAME HERE",
                           label = "Choose Region",
                           choices = list("REGION 1" = "REGION NAME IN COL"))
             ),
             mainPanel()

           )
  )
