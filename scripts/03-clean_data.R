#### Preamble ####
# Purpose: Cleans the raw election data.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `arrow`, `rsample` packages must be installed and loaded
#   - 02-download_data.R must have been run
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(arrow)
library(rsample)
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

cleaned_data <- 
  raw_data |> 
  janitor::clean_names() |> 
  filter(numeric_grade >= 2.5, candidate_name == "Donald Trump") |> 
  mutate(
    end_date = mdy(end_date),
    state = case_when(              # Aggregate sub-regions into main states
      state %in% c("Nebraska", "Nebraska CD-2") ~ "Nebraska",
      state %in% c("Maine", "Maine CD-1", "Maine CD-2") ~ "Maine",
      TRUE ~ state
    )
  ) |>
  filter(end_date >= as.Date("2024-07-15")) |>  # Trump announced joining campaign
  mutate(
    duration = as.numeric(difftime(end_date, min(end_date), units = "days")),  # New column: duration (end_date - start_date of Trump)
    num_trump = round((pct / 100) * sample_size, 0),  # Number of respondents supporting Trump
    methodology = case_when(
      str_detect(methodology, "/") ~ "Mixed Voting",
      methodology == "Email" ~ "Online Panel",   # Aggregate Email to Online Panel
      methodology == "IVR" ~ "Live Phone",        # Aggregate IVR to Live Phone
      TRUE ~ methodology
    )) |> 
  select(
    poll_id, numeric_grade, methodology, transparency_score, 
    end_date, sample_size, pollster_name = display_name,
    state, pct, duration, num_trump, 
  ) |> 
  distinct() |> 
  drop_na() # Omit rows with any NA values

# Perform a stratified split based on the 'state' variable to ensure all levels are present in both sets
split <- initial_split(data = cleaned_data, prop = 0.7, strata = state)

# Create training and testing sets
analysis_data_train <- training(split)
analysis_data_test <- testing(split)

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
write_parquet(analysis_data_test, "data/02-analysis_data/test_data.parquet")
write_parquet(analysis_data_train, "data/02-analysis_data/train_data.parquet")
