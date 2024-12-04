#### Preamble ####
# Purpose: Simulates a dataset of toronto city polls
# Author: Ruiying Li
# Date: 26 November 2024
# Contact: ruiying.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(123)


#### Simulate data ####

# sample size
n <- 100

# simulating data
simulated_data <- tibble(
  id = 1:n,
  application_for = sample(c("FrontYard Parking", "Permit Parking", "Traffic calming"), n, replace = TRUE),
  potential_voters = sample(10:50, n, replace = TRUE),
  ballots_distributed = potential_voters * runif(n, 0.6, 1),  # distributed ballots between 60% and 100% of potential voters
  ballots_cast = ballots_distributed * runif(n, 0.4, 0.9),   # returned ballots between 40% and 90% of distributed
  final_voter_count = sample(5:45, n, replace = TRUE),        # final voter count
  pass_rate = sample(10:50, n ,replace = TRUE),
  voter_participation_rate = ballots_cast / ballots_distributed * 100
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
