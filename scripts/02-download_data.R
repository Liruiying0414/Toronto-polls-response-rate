#### Preamble ####
# Purpose: Downloads and saves the data from opendata Toronto
# Author: Ruiying Li
# Date: 3 December 2024
# Contact: ruiying.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: no
# Any other information needed? no


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
library(arrow)


# get package
package <- show_package("7bce9bf4-be5c-4261-af01-abfbc3510309")

# get all resources for this package
resources <- list_package_resources("7bce9bf4-be5c-4261-af01-abfbc3510309")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(data, "/home/rstudio/starter_folder-main/data/raw_data.csv") 
write_parquet(data, "/home/rstudio/starter_folder-main/data/raw_data.parquet")

         
