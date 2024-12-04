#### Preamble ####
# Purpose: Tests cleaning data
# Author: Ruiying Li
# Date: 26 November 2024
# Contact: ruiying.li@mail.utoronto,ca
# License: MIT
# Pre-requisites: download testthat package
# Any other information needed? no


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

analysis_data <- read_parquet("/home/rstudio/starter_folder-main/data/02-analysis_data/analysis_data.parquet")


#### Test data ####
# Test that the dataset has 1069 rows
test_that("dataset has 1069 rows", {
  expect_equal(nrow(analysis_data), 1069)
})

# Test that the dataset has 7 columns
test_that("dataset has 7 columns", {
  expect_equal(ncol(analysis_data), 7)
})

# Test that the 'application_for' column is character type
test_that("'application_for' is character", {
  expect_type(analysis_data$application_for, "character")
})

# Test that the 'potential_voters' column is numeric type
test_that("'potential_voters' is character", {
  expect_type(analysis_data$potential_voters, "integer")
})

# Test that the 'ballots_distributed' column is numeric type
test_that("'ballots distributed' is numeric", {
  expect_type(analysis_data$ballots_distributed, "double")
})

# Test that the 'ballots_cast' column is numeric type
test_that("'ballots cast' is numeric", {
  expect_type(analysis_data$ballots_cast, "double")
})

# Test that the 'final_voter_count' column is numeric type
test_that("'final_voter_count' is numeric", {
  expect_type(analysis_data$final_voter_count, "double")
})

# Test that the 'pass_rate' column is numeric type
test_that("'pass_rate' is numeric", {
  expect_type(analysis_data$pass_rate, "double")
})


# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that participate rate calculated correctly
test_that("Voter response rate calculated correctly", {
   analysis_data$response_rate <- analysis_data$ballots_cast / analysis_data$ballots_distributed * 100
  expect_true(all(analysis_data$response_rate >= 0 & analysis_data$response_rate <= 100))
})



