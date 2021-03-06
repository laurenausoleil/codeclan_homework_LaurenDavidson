library(tidyverse)
library(janitor)
library(lubridate)

# Get data
avocado_price <- read_csv("data/avocado.csv") %>% 
  clean_names()
# ---------------------------------------
# Additional info from data dictionary
# numbered variables 4*** are total number sold by that PLU
# Region is the region of the observed sale

# So we will be able to explore the price of avocado in relation to time (year, month, day of the week), geography, type (conventional or organic), PLU code, bag size, total volume sold
# ---------------------------------------

avocado_price <- avocado_price %>% 
  # add date columns for possible analysis 
  mutate(
    # **** not currently working - setting all days to weekday! ****
    is_weekday = if_else(wday(ymd(date)) %in% 1:5, 1, 0),
    # **** currently creating a numeric value, not a categorical variable ****
    month = month(ymd(date))
  ) %>% 
# drop unhelpful columns
select(-c(x1, total_bags, date)) 

write_csv(avocado_price, "data/clean_avocado.csv")

