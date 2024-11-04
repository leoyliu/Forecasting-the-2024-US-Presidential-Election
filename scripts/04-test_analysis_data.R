#### Preamble ####
# Purpose: Tests structure of the analysis data.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `testthat` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 348 rows
test_that("dataset has 348 rows", {
  expect_equal(nrow(analysis_data), 348)
})

# Test that the dataset has 11 columns
test_that("dataset has 11 columns", {
  expect_equal(ncol(analysis_data), 11)
})

# Test that the 'state' column is character type
test_that("'state' is character", {
  expect_type(analysis_data$state, "character")
})

# Test that the 'methodology' column is character type
test_that("'methodology' is character", {
  expect_type(analysis_data$methodology, "character")
})

# Test that the 'pollster_name' column is character type
test_that("'pollster_name' is character", {
  expect_type(analysis_data$pollster_name, "character")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that there are no empty strings in 'pollster_name', 'methodology', or 'state' columns
test_that("no empty strings in 'pollster_name', 'methodology', or 'state' columns", {
  expect_false(any(analysis_data$pollster_name == "" | analysis_data$methodology == "" | analysis_data$state == ""))
})

# Test that the 'methodology' column contains at least 3 unique values
test_that("'methodology' column contains at least 3 unique values", {
  expect_true(length(unique(analysis_data$methodology)) >= 3)
})

# Test that the 'state' column contains only valid US state names
valid_states <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
                  "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
                  "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
                  "Missouri", "Montana", "Nebraska", "Nevada","New Hampshire", "New Jersey", "New Mexico", "New York",
                  "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", 
                  "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
                  "West Virginia", "Wisconsin", "Wyoming", "District of Columbia", "National")

test_that("'state' column contains only valid US state names", {
  expect_true(all(analysis_data$state %in% valid_states))
})

# Test that 'numeric_grade' falls within a realistic range (e.g., 2.5 to 5.0)
test_that("'numeric_grade' values are within the range 2.5 to 5.0", {
  expect_true(all(analysis_data$numeric_grade >= 2.5 & analysis_data$numeric_grade <= 5.0))
})

# Test that 'transparency_score' is within a valid range (e.g., 4 to 10)
test_that("'transparency_score' values are within the range 4 to 10", {
  expect_true(all(analysis_data$transparency_score >= 4 & analysis_data$transparency_score <= 10))
})

# Test that 'sample_size' is a positive integer and within a reasonable range (e.g., 300 to 3500)
test_that("'sample_size' values are within the range 300 to 3500", {
  expect_true(all(analysis_data$sample_size >= 300 & analysis_data$sample_size <= 3500))
  expect_true(all(analysis_data$sample_size == floor(analysis_data$sample_size)))
})

# Test that 'end_date' is after a specific date (e.g., "2024-07-15")
test_that("'end_date' is after 2024-07-15", {
  expect_true(all(as.Date(analysis_data$end_date) >= as.Date("2024-07-15")))
})

# Test that 'pct' is between 0 and 100, representing a percentage
test_that("'pct' values are between 0 and 100", {
  expect_true(all(analysis_data$pct >= 0 & analysis_data$pct <= 100))
})

# Test that 'duration' (days until election) is non-negative and reasonable (e.g., not more than 200 days)
test_that("'duration' is non-negative and not exceeding 200 days", {
  expect_true(all(analysis_data$duration >= 0 & analysis_data$duration <= 200))
})
