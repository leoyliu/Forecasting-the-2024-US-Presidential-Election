#### Preamble ####
# Purpose: Simulates a dataset of 2024 US election to explore what values might appear in the dataset.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# Define the number of observations
num_obs <- 1000

pollster_names <- c(
  "AtlasIntel", "YouGov", "Emerson College", "Quinnipiac University", "SurveyUSA",
  "East Carolina University Center for Survey Research", "The New York Times/Siena College",
  "University of Massachusetts Lowell Center for Public Opinion/YouGov", "Marist College",
  "The Washington Post", "Suffolk University", "Mason-Dixon Polling & Strategy",
  "Christopher Newport University Wason Center for Civic Leadership", "YouGov/Center for Working Class Politics",
  "University of California Berkeley Institute of Governmental Studies", "Winthrop University Center for Public Opinion & Policy Research",
  "High Point University Survey Research Center", "Marquette University Law School", "CNN/SSRS",
  "Beacon Research/Shaw & Company Research", "The Washington Post/University of Maryland Center for Democracy and Civic Engagement",
  "Muhlenberg College Institute of Public Opinion", "MassINC Polling Group", "University of New Hampshire Survey Center",
  "Siena College", "Elon University", "Selzer & Co.", "Data Orbital", "Public Policy Institute of California",
  "The Washington Post/George Mason University Schar School of Policy and Government",
  "SurveyUSA/High Point University Survey Research Center", "Remington Research Group",
  "Roanoke College Institute for Policy and Opinion Research", "YouGov Blue",
  "University of North Florida Public Opinion Research Lab"
)

methodologies <- c("Online Ad", "Online Panel", "Mixed Voting", "Live Phone")
grades <- c(2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0)
transparency_scores <- 4:10
states = c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
               "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
               "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
               "Missouri", "Montana", "Nebraska", "Nevada","New Hampshire", "New Jersey", "New Mexico", "New York",
               "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", 
               "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
               "West Virginia", "Wisconsin", "Wyoming", "District of Columbia", "National")
sample_sizes <- sample(300:3500, num_obs, replace = TRUE)
pct_values <- runif(num_obs, 35, 55) # Range of percentages for candidate support
durations <- sample(85:200, num_obs, replace = TRUE) # Duration in days
num_trump <- round(pct_values * sample_sizes / 100)

# Generate the dataset
simulated_data <- tibble(
  poll_id = sample(88000:89000, num_obs, replace = TRUE),
  numeric_grade = sample(grades, num_obs, replace = TRUE),
  methodology = sample(methodologies, num_obs, replace = TRUE),
  transparency_score = sample(transparency_scores, num_obs, replace = TRUE),
  end_date = sample(seq.Date(from = as.Date("2024-07-15"), to = as.Date("2024-10-31"), by = "day"), num_obs, replace = TRUE),
  sample_size = sample_sizes,
  pollster_name = sample(pollster_names, num_obs, replace = TRUE),
  state = sample(states, num_obs, replace = TRUE),
  pct = round(pct_values, 1),
  duration = durations,
  num_trump = num_trump
)


#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
