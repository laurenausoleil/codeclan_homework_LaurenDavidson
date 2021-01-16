library(tidyverse)

sales <- game_sales %>% 
  rename(year = year_of_release)

list_genre <- unique(sales$genre)
list_publisher <- unique(sales$publisher)
list_platform <- unique(sales$platform)
