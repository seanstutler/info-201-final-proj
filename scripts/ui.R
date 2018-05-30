#load library
library(shiny)
library(plotly)


#read file
df <- read.csv('../processed_data/country_indicators.csv',
               stringsAsFactors = FALSE)
select_value <- df$Country.Name
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
                         choices = list("General" = "General", "High Income" = "High income",
                         "Upper Middle Income" = "Upper middle income",
                         "Lower Middle Income" = "Lower middle income",
                         "Low Income" = "Low income")),
        "If the hovered data is 0, it means that that data currently
             is not available :P Sorry for the inconvenience~",
        width = 2),
             mainPanel(
               h3("Map Instruction"),
               p("Feel free to change any of the development indicators and region to see the visualization
                 of the data! Countries are classified by different indicator into different colors. Also,
                 if you want to know the income group of each country, change the income group input to see
                 the highlighted map as well! Enjoy! "),
               plotlyOutput("map")
             )
          )
  ),
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
               p("To see the relationship between two indicators of a certain region/country,
                 change the x-variable and y-variable, and choose the corresponding country/
                 region. Enjoy! "),
               plotOutput("scatter")
             )
           )
  ),
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
        p("To compare the growth of a certain indicator in any numbers of countries,
          you can use this plot! Choose indicator and the countries you want to compare,
          rember", strong("please don't put nothing in the country selection."),
          "Feel free to hover around the data and see the beautiful legend of our plot! Enjoy~"),
        plotlyOutput("compare")
      )
    )),
  tabPanel("About us",
           mainPanel(
             tabsetPanel(
               tabPanel("Introduction",
                p("Greetings! Welcome to the 'Analysis of Country Development by Indicators' presented
                  by Clayton Chen, Sean Yang, Jessie Yang and Velocity Yu from INFO 201 BA."),
                  p("\n We are proud to bring you guys this great interactive program that allows users to view
                      the trend of a certain developmemt indicators of a certain country by click. Also,
                      the map we presented is colorized by 2016 total GDP.")),
               tabPanel("Insights of this project",
                        p("To be honest, the data we chose is itself a major challenge of our team.
                          The data takes up 210 MB and up, and the major data contains 400,000 rows."),
                        p("Most of our time is spending on choosing data we want to process and present.
                          After arguing for thousands of times, we decided to choose these indicators:"),
                        p(strong("employment, imports, exports, life expectancy, literacy rate, GDP and GDP per capita.")),
                        p("For those indicators, employment, life expectancy and literacy rate are crucial and
                          representing indicators of the development of the country. Import, exports, GDP and GDP per
                          capita can somehow reflects the economic growth and political growth of the country. ")),
               tabPanel("About Our Group",
              p("All of our group member are freshmen and from China. Clayton and Sean contribute to
             the function of manipulate maps and plots. Jessie Yang is our server developer. Velocity Yu is our UI
              developer and data processer."))
             )
           )
  )
))

