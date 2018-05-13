#Info 201 Project Proposal
_Author: Clayton Chen, Jessie Yang, Sean Yang, Velocity Yu_
## Project Description
___
###What is the dataset we'll be working with?
>
We are working with the World Development Indicator dataset collected by the World Bank*, more specifically,. The data can be accessed at the  [link](https://datacatalog.worldbank.org/dataset/world-development-indicators). We are going to filter the data down to the whole Europe and Asia, since all of us think those countries can be a very informative reflection of all income level of the world.

>
*The World Bank is an international financial institution that provides loan to countries of the world for capital projects. Their goal is to reduce poverty of the world and support development. 


###Who is our target audience? 
>
The audience will be the economic students and people who are interesting in trend of developments of Asia and Europe in past few decades.

###What does the audience want to learn from your data?

>
- GDP per capita && GDP growth 
- What are the trends of developments of countries in Asia and Europe according to some economic indexes?
- What is the income group that each country should be categorised in?
- What are the differences of development trends according to different indexes between countries? 
- What is the education expenditure for each country?
- How does each country’s economy grow overtime?
- The birth rate and death rate for each country
- The coverage of social insurance programme for each country
- The electricity power consumption for each country
- The forest area for each country

# Technical Description

___

###How will we be reading in our data.
>
We will read in our data by using the WDICountry.csv and WDIData.csv files downloaded from the  link : https://datacatalog.worldbank.org/dataset/world-development-indicators

###What types of data-wrangling will we need to do to our data?
>
We are going to reshape and filter the data down by choosing different economic tools and indexes and countries.

###What are the steps to form the projecft?
>
1. Extract the useful data from different databases.
2. Reformat and write data to a new .csv file to process.
3. Make plots using the data.
4. Make a shiny app to show the skeleton of the project.
5. Integrate all the data and app into a .Rmd file and form a .html file.

###What libraries will be used in this project?
>
plotly, ggplot2, dplyr, shiny, knitr

###Whar are the major challenges in the project for us?
>
It is hard for us to manipulate all the data since it involves two data set and one of it is extremely large. It will be hard for us to extract useful data from the whole file.

