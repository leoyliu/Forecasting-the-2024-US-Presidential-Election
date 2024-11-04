#### Preamble ####
# Purpose: Exploratory data analyis on cleaned data.
# Author: Yuanyi (Leo) Liu, Dezhen Chen, Ziyuan Shen
# Date: 30 October 2024
# Contact: leoy.liu@mail.utoronto.ca, dezhen.chen@mail.utoronto.ca, ziyuan.shen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse`, `rstanarm` packages must be installed and loaded
#   - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Forecasting-the-2024-US-Presidential-Election` rproj


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# General overview of the dataset
glimpse(analysis_data)
summary(analysis_data)


#### Summary Statistics ####
# Summary of numeric columns
analysis_data %>%
  select_if(is.numeric) %>%
  summary()

# Count unique values in categorical columns
analysis_data %>%
  select_if(is.character) %>%
  summarise_all(~ n_distinct(.))

#### Missing Values Analysis ####
# Check for missing values in each column
analysis_data %>%
  summarise_all(~ sum(is.na(.)))


#### Univariate Analysis ####
# Distribution of numeric_grade
ggplot(analysis_data, aes(x = numeric_grade)) +
  geom_histogram(bins = 20, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Poll Numeric Grades", x = "Numeric Grade", y = "Count")

# Distribution of transparency_score
ggplot(analysis_data, aes(x = transparency_score)) +
  geom_histogram(bins = 20, fill = "lightgreen", color = "black") +
  labs(title = "Distribution of Poll Transparency Scores", x = "Transparency Score", y = "Count")

# Distribution of sample_size
ggplot(analysis_data, aes(x = sample_size)) +
  geom_histogram(bins = 30, fill = "coral", color = "black") +
  labs(title = "Distribution of Poll Sample Sizes", x = "Sample Size", y = "Count") +
  scale_x_log10()  # Log scale for better visualization

# Distribution of percent (poll result percentage)
ggplot(analysis_data, aes(x = pct)) +
  geom_histogram(bins = 30, fill = "purple", color = "black") +
  labs(title = "Distribution of Poll Percentages", x = "Percentage", y = "Count")

# Distribution of duration (days until election)
ggplot(analysis_data, aes(x = duration)) +
  geom_histogram(bins = 30, fill = "lightblue", color = "black") +
  labs(title = "Distribution of Days Until Election", x = "Days Until Election", y = "Count")


#### Bivariate Analysis ####
# Relationship between numeric_grade and transparency_score
ggplot(analysis_data, aes(x = numeric_grade, y = transparency_score)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Numeric Grade vs Transparency Score", x = "Numeric Grade", y = "Transparency Score")

# Sample size vs Percent (poll result percentage)
ggplot(analysis_data, aes(x = sample_size, y = pct)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +  # Log scale for sample size
  labs(title = "Sample Size vs Poll Percentage", x = "Sample Size (log scale)", y = "Poll Percentage")

# Polling Methodology vs Percent
ggplot(analysis_data, aes(x = methodology, y = pct)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Polling Methodology vs Poll Percentage", x = "Methodology", y = "Poll Percentage") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# State vs Percent (showing only top 10 states by count for clarity)
analysis_data %>%
  count(state, sort = TRUE) %>%
  top_n(10) %>%
  inner_join(analysis_data, by = "state") %>%
  ggplot(aes(x = reorder(state, pct, median), y = pct)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "State-wise Poll Percentage", x = "State", y = "Poll Percentage") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#### Time Series Analysis ####
# Convert end_date to Date type if not already
analysis_data <- analysis_data %>%
  mutate(end_date = as.Date(end_date))

# Average percentage by month
analysis_data %>%
  mutate(month = floor_date(end_date, "month")) %>%
  group_by(month) %>%
  summarize(avg_pct = mean(pct, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = avg_pct)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Average Poll Percentage by Month", x = "Month", y = "Average Poll Percentage")
