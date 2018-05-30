#load library
library(shiny)
library(plotly)
library(ggplot2)
library(DT)
library(dplyr)

#read file
data <- read.csv("../processed_data/country_indicators.csv",
               stringsAsFactors = FALSE)
data <- data %>%
  select(-X)

region <- read.csv(file = "../processed_data/region.csv",
                   stringsAsFactors = FALSE)

select_value <- data$Country.Name

indicator_choice <- list(
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
    "GDP per capita (current US$)")

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
                         choices = indicator_choice),
               selectInput("region",
                           label = "Choose Region",
                           choices = list("World" = "world",
                                          "Asia" = "asia",
                                          "Africa" = "africa",
                                          "South America" = "south america",
                                         "North America" = "north america",
                                         "Europe" = "europe"
                              )),
              radioButtons("income group",
                          label = "Choose Income Group",
                         choices = list("General" = "General",
                                  "High Income" = "High income",
                         "Upper Middle Income" = "Upper middle income",
                         "Lower Middle Income" = "Lower middle income",
                         "Low Income" = "Low income")),
        "If the hovered data is 0, it means that that data currently
             is not available :P Sorry for the inconvenience~",
        width = 2),
             mainPanel(
               h3("Map Instruction"),
               p("Feel free to change any of the development indicators and
                  region to see the visualization of the data! Countries are
                  classified by different indicator into different colors. Also,
                  if you want to know the income group of each country,
                  change the income group input to see
                 the highlighted map as well! Enjoy! "),
               p("When you choose a certain income group and choose indicators,
                  the map won't change. Here, you can just change the income
                 group back to general and then everything will work."),
               #plot map
               plotlyOutput("map")
             )
          )
  ),
  #tab 2
  tabPanel("Indicators Relation Plots",
           titlePanel("Magic Plots of relations between certain indicators"),
           sidebarLayout(
             sidebarPanel(
               selectInput("type1",
                           label = "Development Indicator (x axis)",
                           choices = indicator_choice),
               selectInput("type2",
                           label = "Development Indicator (y axis)",
                           choices = indicator_choice),
               selectInput("country2", label = "Choose Country ",
                           choices = select_value,
                           selected = 1
                           ), width = 2),
             mainPanel(
               h3("Relation Plot Instruction"),
               p("To see the relationship between two indicators of a
                certain region/country, change the x-variable and y-variable,
                and choose the corresponding country/region. Enjoy! "),
               #plot the relation plot
               plotOutput("scatter")
             )
           )
  ),
  #tab 3
  tabPanel(
    "Country Relation Plot",
    titlePanel("Magic Plot To Compare Multiple Countries Development"),
    sidebarLayout(
      sidebarPanel(
        # choose y
        selectInput(
          "indicator", "Choose the Indicator",
          choices = indicator_choice),
        # chooose country
        selectInput(
          "name", label = "Choose the Country",
          choices = select_value,
          multiple = TRUE,
          selected = select_value[[1]]), width = 2
      ),
      mainPanel(
        h3("Country Comparing Plot Instruction"),
        p("To compare the growth of a certain indicator in any numbers of
          countries, you can use this plot! Choose indicator and the countries
          you want to compare",
          strong("please don't put nothing in the country selection."),
          "Feel free to hover around the data and see the beautiful
          legend of our plot! Enjoy~"),
        plotlyOutput("compare")
      )
    )),
  #tab 4
  tabPanel("Data Table",
    sidebarLayout(
      sidebarPanel(
        conditionalPanel(
          'input.dataset === "data"',
          checkboxGroupInput("show_vars", label = "Column choice:",
                             names(data),
                             selected = c('Country.Name', 'Indicator.Name',
                                          'Income.Group'))
        ),
        conditionalPanel(
          'input.dataset === "region"',
          helpText("Sort by clicking the header of the column.")
        ),
        width = 2
      ),
      mainPanel(
        tabsetPanel(
           id = 'dataset',
           tabPanel("data",
                    h3("Data Table Instruction"),
                    p("This is a table of our processed data. You can choose from the
                      sidebar of what data you want to include in the table. To find a
                      data for a certain country/region, use the", strong("search: "),
                      "function at the right."),
                    #display table of data
                    DT::dataTableOutput("data")),
           tabPanel("region",
                    #display table of region
                    DT::dataTableOutput("region"))
      )))),
  #tab 5
  tabPanel("About Us",
           mainPanel(
             tabsetPanel(
               tabPanel("Introduction",
                p("Greetings! Welcome to the 'Analysis of Country Development
                  by Indicators' presented by Clayton Chen, Sean Yang, Jessie
                  Yang and Velocity Yu from INFO 201 BA."),
                  p("\n We are proud to bring you guys this great interactive
                    program that allows users to view
                      the trend of a certain developmemt indicators of a certain
                      country by click. Also,
                      the map we presented is colorized by 2016 total GDP."),
                p("Our target audience is economics students and most of the
                  political science students, since the indicators we choose
                  to reflect the development of the country is relative to
                  their school works. However, we strongly welcome all of
                  the interested one to explore our project!"),
                p("Our data is from the website ",
                  a(href =
      "https://datacatalog.worldbank.org/dataset/world-development-indicators",
      "World Bank Group"), "and here is the link to our ",
      a(href = "https://github.com/velocityCavalry/info-201-final-proj", "repo"))),
               tabPanel("Insights of this project",
                        p("To be honest, the data we chose is itself a major
                          challenge of our team. The data takes up 210 MB and
                          up, and the major data contains 400,000 rows."),
                        p("Most of our time is spending on choosing data we
                          want to process and present.After arguing for
                          thousands of times, we decided to choose these
                          indicators:"),
                        p(strong("employment, imports, exports,
                    life expectancy, literacy rate, GDP and GDP per capita.")),
                        p("For those indicators, employment, life expectancy and
                          literacy rate are crucial and representing social
                          indicators of the development of the country. Import,
                          exports, GDP and GDP per capita can somehow reflect
                          the economic growth of the country."),
                        p("All of our members are very keen and positive about
                          our project. We are excited and glad to present you
                this visualization and analysis of the data from world bank.")),
               tabPanel("About Our Group",
              p("All of our group member are freshmen from China. Clayton and
                Sean contribute to the function of manipulate maps, plots
                  and CSS style design.
                  Jessie Yang is our server developer. Velocity Yu is our UI
              developer and data processer. All of our member is very
                contructive and innovative."))
             )
           ))
  )
)
