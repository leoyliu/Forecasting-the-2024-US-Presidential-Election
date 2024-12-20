# Predicting the 2024 US Presidential Election
## Overview

The repository contains a study that predicts the outcome of the 2024 U.S. Presidential Election using a model-based approach with aggregated polling data. The primary focus is on forecasting support for candidates Kamala Harris and Donald Trump by analyzing state-level polling trends. Results suggest Harris is likely to secure 341 electoral votes compared to Trump’s 197. The repository includes code for data processing, model setup, and result visualization, with detailed steps for reproducibility and analysis of the impact of polling methodologies on the forecast.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from [FiveThirtyEight 2024 U.S. Presidential Election Polls](https://projects.fivethirtyeight.com/polls/president-general/2024/national/) as of October 30, 2024.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to download, simulate, clean, model, and test data.

## Statement on LLM usage

The ChatGPT-4 model assisted with data validation, test creation, data cleaning, simulation generation, plot generation, and the polishing of wording. The entire chat history is available in `other/llm_usage/usage.txt`.

------------------------------------------------------------------------

*Note: Please execute `07-install_packages.R` first to ensure all necessary packages are installed. Then, you can proceed to use the read function in R to import the data for further analysis with our R scripts.*

------------------------------------------------------------------------
