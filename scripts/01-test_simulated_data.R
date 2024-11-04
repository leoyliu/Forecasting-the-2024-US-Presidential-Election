#### Preamble ####
# Purpose: Tests the structure and validity of the simulated 2024 US election dataset.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `testthat` packages must be installed and loaded
#   - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
test_that("dataset was successfully loaded", {
  expect_true(exists("simulated_data"))
})


#### Test data ####

# Check if the dataset has 1000 rows
test_that("dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Check if the dataset has 11 columns
test_that("dataset has 11 columns", {
  expect_equal(ncol(simulated_data), 11)
})

# Check if the 'state' column contains only valid US state names
valid_states <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
                           "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
                           "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
                           "Missouri", "Montana", "Nebraska", "Nevada","New Hampshire", "New Jersey", "New Mexico", "New York",
                           "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", 
                           "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
                           "West Virginia", "Wisconsin", "Wyoming", "District of Columbia", "National")

test_that("'state' column contains only valid US state names", {
  expect_true(all(simulated_data$state %in% valid_states))
})

# Check if there are any missing values in the dataset
test_that("dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

# Check if there are no empty strings in 'methodology', 'state', and 'pollster_name' columns
test_that("no empty strings in 'methodology', 'state', and 'pollster_name'", {
  expect_true(all(simulated_data$methodology != "" & simulated_data$state != "" & simulated_data$pollster_name != ""))
})

# Check if the 'methodology' column has at least four unique values
test_that("'methodology' column contains at least four unique values", {
  expect_gte(n_distinct(simulated_data$methodology), 4)
})

# Check if 'numeric_grade' falls within a realistic range (e.g., 2.5 to 5.0)
test_that("'numeric_grade' values are within the range 2.5 to 5.0", {
  expect_true(all(simulated_data$numeric_grade >= 2.5 & simulated_data$numeric_grade <= 5.0))
})

# Check if 'transparency_score' is within a valid range (e.g., 4 to 10)
test_that("'transparency_score' values are within the range 4 to 10", {
  expect_true(all(simulated_data$transparency_score >= 4 & simulated_data$transparency_score <= 10))
})

# Check if 'sample_size' is a positive integer and within a reasonable range (e.g., 300 to 3500)
test_that("'sample_size' values are within the range 300 to 3500", {
  expect_true(all(simulated_data$sample_size >= 300 & simulated_data$sample_size <= 3500))
  expect_true(all(simulated_data$sample_size == floor(simulated_data$sample_size)))
})

# Check if 'end_date' is after a specific date (e.g., "2024-07-15")
test_that("'end_date' is after 2024-07-15", {
  expect_true(all(as.Date(simulated_data$end_date) >= as.Date("2024-07-15")))
})

# Check if 'pct' is between 0 and 100, representing a percentage
test_that("'pct' values are between 0 and 100", {
  expect_true(all(simulated_data$pct >= 0 & simulated_data$pct <= 100))
})

# Check if 'duration' (days until election) is non-negative and reasonable (e.g., not more than 200 days)
test_that("'duration' is non-negative and not exceeding 200 days", {
  expect_true(all(simulated_data$duration >= 0 & simulated_data$duration <= 200))
})
