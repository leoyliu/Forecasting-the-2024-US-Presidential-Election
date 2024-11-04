#### Preamble ####
# Purpose: Models US presidential election polls by using stan_glm.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm`, `arrow`, `car` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(car)
library(arrow)

#### Read data ####
analysis_data_train <- read_parquet("data/02-analysis_data/train_data.parquet")


### Model data ####
model <-
  stan_glm(
    formula = pct ~ numeric_grade + as.factor(methodology) + duration + sample_size + transparency_score + state,
    data = analysis_data_train,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
)


#### Save model ####
saveRDS(
  model,
  file = "models/linear_model.rds"
)
