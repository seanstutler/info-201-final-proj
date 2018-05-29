library(dplyr)
library(plotly)
return_graph_from_param <- function(type, country, is_year, type2) {
    data <- read.csv(file = "../processed_data/country_indicators.csv", stringsAsFactors = FALSE)
    if (is_year) {
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
        graph <- plot_ly(total_data, x = ~Year, y = ~Amount, type = 'scatter', mode = 'lines')
        return(graph)
    } else {
        selected <- data %>%
            filter(Country.Name == "China")
        data1 <- selected %>%
            filter(Indicator.Name == type)
        data2 <- selected %>%
            filter(Indicator.Name == type2)
        datalist1 <- return_list(data1);
        datalist2 <- return_list(data2);
        total_data <- do.call(rbind, Map(data.frame, type = datalist1, type2 = datalist2))
        graph <- ggplot(data = total_data) +
            geom_line(mapping = aes(x = type, y = type2)) +
            labs(x = type, y = type2)
        return(graph)
    }
}

return_list <- function(data) {
    datalist <- list();
    colnames <- colnames(data);
    i <- 1
    for (col in colnames) {
        if (col != "Country.Name" & col!= "Country.Code" &
            col != "Indicator.Name" & col != "Indicator.Code" &
            col != "X" & col != "X2017") {
            datalist[[i]] <- data[1, col]
            i = i + 1
        }
    }
    return(datalist);
}
