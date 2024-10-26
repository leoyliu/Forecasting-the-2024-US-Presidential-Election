#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(rsample)
library(dplyr)
library(car)


#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")
analysis_data_test <- read_parquet("data/02-analysis_data/test_data.parquet")
analysis_data_train <- read_parquet("data/02-analysis_data/train_data.parquet")


### Model data ####
first_model <-
  stan_glm(
    formula = pct~ numeric_grade + as.factor(methodology) + duration + transparency_score + state,
    data = analysis_data_train,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )
summary(first_model)
vif(first_model)

model2 <-lm(pct~ numeric_grade + as.factor(methodology) + duration + sample_size + transparency_score + state, 
            data = analysis_data_train)
summary(model2)
vif(model2)


#### Save model ####
saveRDS(
  model2,
  file = "models/first_model.rds"
)
