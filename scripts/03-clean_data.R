#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(arrow)
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")

legal_marijuana_states <- c(
  "Colorado", "Washington", "Alaska", "Oregon", "Washington, D.C.", "California",
  "Maine", "Massachusetts", "Nevada", "Michigan", "Vermont", "Guam", "Illinois", 
  "Arizona", "Montana", "New Jersey", "New York", "Virginia", "New Mexico", 
  "Connecticut", "Rhode Island", "Maryland", "Missouri", "Delaware", "Minnesota", "Ohio"
)

cleaned_data <- 
  raw_data |> 
  janitor::clean_names() |> 
  filter(numeric_grade >= 2.7, candidate_name == "Donald Trump") |> 
  mutate(end_date = mdy(end_date)) |>
  filter(end_date >= as.Date("2024-07-15")) |>  # Trump announced joining campaign
  mutate(
    duration = as.numeric(difftime(end_date, min(end_date), units = "days")),  # New column: duration (end_date - start_date of Trump)
    num_trump = round((pct / 100) * sample_size, 0),  # Number of respondents supporting Trump
    methodology = ifelse(str_detect(methodology, "/"), "Mixed Voting", methodology),  # Replace "/" with "multiple ways of voting"
    marijuana_legal = ifelse(state %in% legal_marijuana_states, 1, 0)  # Map whether the state allows marijuana legally
  ) |> 
  select(
    poll_id, numeric_grade, methodology, transparency_score, 
    end_date, sample_size, pollster_name = display_name,  # Rename display_name to pollster_name
    state, pct, duration, num_trump, marijuana_legal
  ) |> 
  distinct() |> 
  drop_na() # Omit rows with any NA values

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
