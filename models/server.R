library(plumber)
serve_model <- plumb("models/plumber2.R")

serve_model$run(port = 8000)




