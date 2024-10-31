#### Preamble ####
# Purpose: Tests structure of the analysis data 
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 348 rows
test_that("dataset has 348 rows", {
  expect_equal(nrow(analysis_data), 348)
})

# Test that the dataset has 12 columns
test_that("dataset has 12 columns", {
  expect_equal(ncol(analysis_data), 12)
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