#### Preamble ####
# Purpose: Models US presidential election polls by using LM 
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

numeric_vars_analysis <- c('numeric_grade', 'transparency_score', 'sample_size', 'pct')
for (var in numeric_vars_analysis) {
  p1 <- ggplot(analysis_data, aes(x = !!sym(var))) +
    geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
    ggtitle(paste("Histogram of", var)) +
    theme_minimal() +
    xlab(var) +
    ylab("Frequency")
  print(p1) 
}


numeric_vars_electoral <- c('duration', 'num_trump')
for (var in numeric_vars_electoral) {
  p <- ggplot(electoral_votes, aes(x = !!sym(var))) +
    geom_histogram(binwidth = 5, fill = "lightgreen", color = "black", alpha = 0.7) +
    ggtitle(paste("Histogram of", var)) +
    theme_minimal() +
    xlab(var) +
    ylab("Frequency")
  print(p)  
}

p_numeric_grade <- ggplot(analysis_data, aes(x = numeric_grade)) +
  geom_bar(fill = "coral", color = "black", alpha = 0.8) +
  ggtitle("Bar Plot of Numeric Grade") +
  theme_minimal() +
  xlab("Numeric Grade") +
  ylab("Count")
print(p_numeric_grade)
