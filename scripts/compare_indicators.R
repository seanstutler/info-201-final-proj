library(dplyr)
library(plotly)
compare_indicators <- function(type, type2, country) {
    data <- read.csv(file = "../processed_data/country_indicators.csv",
                     stringsAsFactors = FALSE)
    selected <- data %>%
        filter(Country.Name == country)
    data1 <- selected %>%
        filter(Indicator.Name == type)
    data2 <- selected %>%
        filter(Indicator.Name == type2)
    datalist1 <- return_list(data1);
    datalist2 <- return_list(data2);
    total_data <- do.call(rbind, Map(data.frame, type = datalist1,
                                     type2 = datalist2))
    graph <- ggplot(data = total_data) +
        geom_line(mapping = aes(x = type, y = type2)) +
        labs(x = type, y = type2)
    return(graph)
}

return_list <- function(data) {
    datalist <- list();
    colnames <- colnames(data);
    i <- 1
    for (col in colnames) {
        if (col != "Country.Name" & col != "Country.Code" &
            col != "Indicator.Name" & col != "Indicator.Code" &
            col != "X" & col != "X2017" & col != "Income.Group") {
            datalist[[i]] <- data[1, col]
            i <- i + 1
        }
    }
    return(datalist);
}
