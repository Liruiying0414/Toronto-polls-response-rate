# Polls participant rate affecting factors Discovery

## Overview

This study investigates the factors influencing voter turnout in local elections using polling data from toronto municipal government. By analyzing over 1,000 records, we identify key drivers of voter participation, and finds increased ballot distribution and a higher number of ballots cast are strongly associated with higher turnout rates, while the number of eligible voters has a smaller impact. These insights highlight practical strategies to improve civic engagement,thereby strengthening public decision-making on local concerns.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from https://open.toronto.ca/dataset/polls-conducted-by-the-city/.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions, datasheet and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download,clean,test and model data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool,ChatGPT 4o. The abstract and introduction were written with the help of ChatGPT 4o and the entire chat history is available in other/llm_usage/usage.txt.
