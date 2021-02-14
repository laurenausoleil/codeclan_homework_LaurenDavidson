library(tidyverse)
library(modelr)
library(leaps)
library(GGally)

# Load Data
avocado <- read_csv("data/clean_avocado.csv")

# check for redundany variables
alias(lm(average_price ~ ., data = avocado))

# find variables with leaps forward selection
leaps_model <- regsubsets(average_price ~ ., data = avocado, method = "forward")
# See what's in model
plot(summary(leaps_model)$bic, type = "b")
   # shows that model with 8 variables has the lowest bic
plot(summary(leaps_model)$rsq, type = "b")
   # shows that adding predictors has an impact on R squared up to 8 variables.
# See which variables are included at the level with 8 variables
summary(leaps_model)$which[8, ]
  # type, year, month, some regions


# Find variables with leaps exhaustive selection
leaps_model_exh <- regsubsets(average_price ~ ., data = avocado, method = "exhaustive", nvmax = 8, really.big = TRUE)
# See what's in model
plot(summary(leaps_model_exh)$bic, type = "b")
   # shows that lowest BIC is around 8 variables
plot(summary(leaps_model_exh)$rsq, type = "b")
   # shows that adding predictors has an impact on R squared up to 8 variables
summary(leaps_model_exh)$which[8, ]
    # best model includes type, year, month, weekday and some regions

# Explore variables with ggally:ggpairs
avocado %>%
  ggpairs(columns = c("average_price", "type", "year", "month", "is_weekday"))
  # weekday looks like low correlation, month has some, year has some and type looks most significant

# Calculate correlation score for weekday
avocado %>% 
  summarise(cor(average_price, is_weekday))
    # none


