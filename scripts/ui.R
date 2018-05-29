#load library
library(shiny)
library(plotly)


#read file
df <- read.csv('../processed_data/country_indicators.csv',
               stringsAsFactors = FALSE)

select_value <- df$Country.Name


#construct ui
shinyUI(navbarPage(
  theme = "style.css",
  "Analysis of Country Development by Indicators",
  #tab 1
  tabPanel("Interactive Map",
           titlePanel("Magic Map of Development Indicators and Income Groups"),
           #side bar
           sidebarLayout(
             sidebarPanel(
               selectInput("type",
                         label = "Choose Indicator",
                          choices = list(
    "Employment" =
      "Employment to population ratio, 15+, total (%) (national estimate)",
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
               selectInput("region",
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
                         choices = list("General" = "General", "High Income" = "High income",
                         "Upper Middle Income" = "Upper middle income",
                         "Lower Middle Income" = "Lower middle income",
                         "Low Income" = "Low income")),
        "If the hovered data is 0, it means that that data currently
             is not available :P Sorry for the inconvenience~"
             ),
             mainPanel(
               plotlyOutput("map")
             )
          )
  ),
  tabPanel("Indicators Relation Plots",
           titlePanel("Magic Plots of relations between certain indicators"),
           sidebarLayout(
             sidebarPanel(
               selectInput("type1",
                           label = "Development Indicator 1",
                           choices =  list(
                             "Employment" =
                               "Employment to population ratio, 15+, total (%) (national estimate)",
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
               selectInput("type2",
                           label = "Development Indicator 2",
                           choices =  list(
                             "Employment" =
                               "Employment to population ratio, 15+, total (%) (national estimate)",
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
               selectInput("country2", label = "Choose Country ",
                           choices = select_value,
                           selected = 1
                           )),
             mainPanel(
               plotOutput("scatter")
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
           h3("About our group"),
           p("All of our group member are freshmen and from China. Clayton and Sean contribute to
             the function of manipulate maps and plots. Jessie Yang is our server developer. Velocity Yu is our UI
             developer and data processer.")


  )
))
