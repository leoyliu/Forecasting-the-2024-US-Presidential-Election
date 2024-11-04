# Predicting the 2024 US Presidential Election with a Model-Based Forecast

## Overview

This repository contains the code, data, and analysis used to predict the winner of the 2024 US Presidential Election using polling data. The analysis is performed using R, and the data comes from a publicly available collection of high-quality polls. The goal of the project is to build a linear or generalized linear model to forecast the election outcome, with a specific focus on polls that feature Donald Trump as a candidate.

## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains the simulated dataset.
-   `data/01-raw_data` contains the raw data as obtained from [FiveThirtyEight 2024 U.S. Presidential Election Polls](https://projects.fivethirtyeight.com/polls/president-general/2024/national/).
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to download, simulate, clean, model, and test data.

## Statement on LLM usage

The ChatGPT-4 model contributed to the creation of data validation tests and the polishing of wording. The entire chat history is available in `other/llm_usage/usage.txt`.

------------------------------------------------------------------------

*Note: Please execute `07-install_packages.R` first to ensure all necessary packages are installed. Then, you can proceed to use the read function in R to import the data for further analysis with our R scripts.*

------------------------------------------------------------------------
