# Project Name Project: Data Wrangling Exercise 1: Basic Data Manipulation
library(dplyr) #load dplyr package to make data wrangling easy
library(tidyr)
library(readxl)
library(tidyverse)
#Step 0:  Load the data in RStudio and view the table
#when the excel file is imported into R it auto converts into dataframe.
titanic <- read_excel("C:/Users/mohit/OneDrive/Documents/Datawrangling Ex2/titanic3.xls")
glimpse(titanic)
#--------------------------------------------------------------------------------- 
#Step 1: Port of embarkation
titanic_embarked <- titanic %>%
                    mutate(embarked = replace(embarked, is.na(embarked), "S")) %>%
                    mutate(embarked =replace(embarked, embarked == "", "S")) %>%
                    mutate(embarked = replace( embarked, embarked == " ", "S"))

#---------------------------------------------------------------------------------
#Step 2: Age
#Method 1 of replacing NA in age with the mean
mean_age <- mean(titanic$age, na.rm=TRUE)
titanic_age <- titanic_embarked %>%
                mutate(age = replace(age, is.na(age), mean_age))

#---------------------------------------------------------------------------------  
#step 3: lifeboat
titanic_boat <- titanic_age %>%
                 mutate(boat = replace(boat, is.na(boat), "None"))
#---------------------------------------------------------------------------------  

#step 4: Creating a new column "has_cabin_number" for passenger if the room number is allocated value is 1 otherwise 0
 titanic_new_column <- titanic_boat %>%
                 mutate(has_cabin_number= ifelse(is.na(cabin),0,1))
#--------------------------------------------------------------------------------- 
#Output CSV
write.csv(titanic_new_column, file = "C:/Users/mohit/OneDrive/Documents/Datawrangling Ex2/titanic_clean.csv")


