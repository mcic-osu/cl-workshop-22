## Packages
library(tidyverse)
library(googlesheets4)

## Link to the Google Sheet
signup_link <- "https://docs.google.com/spreadsheets/d/1Z1Yl9U6w-O0efRlhqqVOtGBDXcubIoCEU4QiAlMYWtg"

## Target column names
signup_colnames <- c("timestamp",
                      "name",
                      "email",
                      "department",
                      "campus",
                      "position",
                      "attendance_mode",
                      "experience_OSC",
                      "experience_coding",
                      "experience_genomics",
                      "data_type",
                      "questions",
                      "OSC_username")

## Read and clean up sheet
signup <- read_sheet(signup_link)
colnames(signup) <- signup_colnames

# Delete Kush
