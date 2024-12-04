#### Preamble ####
# Purpose: Cleans raw data 
# Author: Ruiying Li
# Date: 22 November 2024
# Contact: ruiying.li@mail.utoronto.ca
# License: MIT
# Any other information needed? no

#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(arrow)
library(dplyr)
library(stringr)

#### Clean data ####
data <- read_parquet("/home/rstudio/starter_folder-main/data/raw_data.parquet")

#Transfer column name to lowercase
colnames(data) <- tolower(colnames(data))

# Transform date format
cleaned_data <- data %>% select(application_for,potential_voters,ballots_distributed, ballots_cast,
                                                       final_voter_count, pass_rate)


# clean outlier
cleaned_data <- cleaned_data %>%
  filter(potential_voters <= 3000)


# calculate voting participant rate
cleaned_data$response_rate <- cleaned_data$ballots_cast / cleaned_data$ballots_distributed*100


# round it to two decimals
cleaned_data$response_rate <- round(cleaned_data$response_rate,2)



#clean missing value
cleaned_data[cleaned_data == "N/A"] <- NA
cleaned_data <- na.omit(cleaned_data)

# clean unuseful symbol
cleaned_data <- cleaned_data %>%
  mutate(application_for = str_replace_all(application_for, "-", ""))
cleaned_data$application_for <- gsub("Traffic Calming – Island" , 
                                     "Traffic Calming Island", cleaned_data$application_for)

# check variable to numeric
cleaned_data$ballots_distributed <- as.numeric(cleaned_data$ballots_distributed)
cleaned_data$ballots_cast <- as.numeric(cleaned_data$ballots_cast)
cleaned_data$final_voter_count <- as.numeric(cleaned_data$final_voter_count)
cleaned_data$response_rate <- as.numeric(cleaned_data$response_rate)
cleaned_data$pass_rate <- as.numeric(cleaned_data$pass_rate)





#### Save data ####
write_parquet(cleaned_data, "/home/rstudio/starter_folder-main/data/02-analysis_data/analysis_data.parquet")
write.csv(cleaned_data,'/home/rstudio/starter_folder-main/data/02-analysis_data/analysis_data.csv')
