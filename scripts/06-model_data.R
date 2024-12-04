#### Preamble ####
# Purpose: Models the relationship betwwen poll participate and other factor
# Author: Ruiying Li
# Date: 29 November 2024
# Contact: ruiying.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: analysis data is clean
# Any other information needed? no


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("/home/rstudio/starter_folder-main/data/02-analysis_data/analysis_data.parquet")

### Model data ####
polls_participate_model <-
  stan_glm(
    formula = response_rate ~ potential_voters + final_voter_count + application_for + pass_rate,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  polls_participate_model,
  file = "models/polls_participate_model.rds"
)


