install.packages("tidyr")
install.packages("dplyr")
install.packages("rio")
library(tidyr)
library(dplyr)
library("rio")
library(readr)
library(utils)

titanic <- import("titanic3.xls")
export(titanic, "titanic_original.csv")

titanic <- read_csv("titanic_original.csv")
View(titanic)

#replace missing embarked values with S
titanic$embarked[which(is.na(titanic$embarked))] <- "S"

#Calculate the mean of the Age column and use that value to populate the missing values
titanic$age[which(is.na(titanic$age))] <- mean(titanic$age, na.rm = TRUE)

# Fill the empty slots in boat with a dummy value e.g. the string 'None' or 'NA'
titanic$boat[which(is.na(titanic$boat))] <- 'None'

# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise
titanic <- mutate(titanic, has_cabin_number = ifelse(is.na(cabin) == TRUE, 0, 1))

#save new csv file
export(titanic, "titanic_clean.csv")
