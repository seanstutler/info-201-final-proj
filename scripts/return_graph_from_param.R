library(dplyr)
library(plotly)
return_graph_from_param <- function(data, type, country) {
    data <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
    selected <- as.data.frame(data %>%
        filter(Indicator.Name == type, Country.Name == country))
    col_names <- colnames(selected)
    year_list <- list()
    i = 1
    for (col in col_names) {
        if (col != "Country.Name" & col!= "Country.Code" &
            col != "Indicator.Name" & col != "Indicator.Code" &
            col != "X" & col != "X2017") {
            year_list[[i]] = col
            i = i + 1
        }
    }
    data_list = list();
    i = 1
    for (year in year_list) {
        specific_year_data <- selected %>%
            select(year)
        if (specific_year_data == "Not Available") {
            specific_year_data <- 0;
        } else {
            specific_year_data <- specific_year_data[1, 1]
        }
        data_list[[i]] = specific_year_data
        i = i + 1
    }
    total_data <- do.call(rbind, Map(data.frame, Year = year_list, Amount = data_list))
    write.csv(total_data, file = "output.csv", row.names = FALSE)
    total_data <- read.csv(file = "output.csv", stringsAsFactors = FALSE)
    graph <- plot_ly(total_data, x = ~Year, y = ~Amount, type = 'scatter', mode = 'lines')
    return(graph)
}
