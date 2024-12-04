#install.packages("plumber")
library(plumber)
install.packages('rstanarm')
library(rstanarm)

# load model
model <- readRDS("polls_participate_model.rds")

# Define model version
version_number <- '0.0.1'

# Define variables
variables <- list(
  potential_voters = "Number of people residing within poll boundary range",
  final_voter_count = "Number of total voters on the final poll list",
  pass_rate = "Number of returned ballots needed for a positive poll result"
)

#* @param potential_voters
#* @param final_voter_count
#* @param pass_rate
#* @get /predict_rate
predict_rate <- function(potential_voters = 1000,
                         final_voter_count = 500, 
                         pass_rate = 10) {
  
  # Convert inputs to appropriate types
  potential_voters <- as.numeric(potential_voters)
  final_voter_count <- as.numeric(final_voter_count)
  pass_rate <- as.numeric(pass_rate)
  
  # Prepare the payload as a data frame
  payload <- data.frame(
    potential_voters = potential_voters,
    final_voter_count = final_voter_count,
    pass_rate = pass_rate
  )
  
  # Extract posterior samples for prediction
  posterior_samples <- as.matrix(model)  # Convert to matrix for easier manipulation
  
  # Define the generative process for prediction
  alpha <- posterior_samples[, "(Intercept)"]
  beta_potential_voters <- posterior_samples[, "potential_voters"]
  beta_final_voter_count <- posterior_samples[, "final_voter_count"]
  beta_pass_rate <- posterior_samples[, "pass_rate"]
  
  # Compute the predicted value for the observation
  predicted_values <- alpha + 
    beta_potential_voters * payload$potential_voters + 
    beta_final_voter_count * payload$final_voter_count + 
    beta_pass_rate * payload$pass_rate
  
  # Predict
  mean_prediction <- mean(predicted_values)
  
  # Return prediction result
  result <- list('predicted_response_rate' = mean_prediction)
  
  return(result)
}