#### Preamble ####
# Purpose: Downloads and saves the data from FiveThirtyEight
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Download data ####
raw_elections_data <-
  read_csv(
    file = 
      "https://projects.fivethirtyeight.com/polls/data/president_polls.csv",
    show_col_types = TRUE
  )


#### Save data ####
write_csv(raw_elections_data, "data/01-raw_data/raw_data.csv") 