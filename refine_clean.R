# Project Name Project: Data Wrangling Exercise 1: Basic Data Manipulation
library(dplyr) #load dplyr package to make data wrangling easy
library(tidyr)

#Step 0:  Load the data in RStudio and view the table
#when the excel file is imported into R it auto converts into dataframe.
refine <- read_excel("C:/Users/mohit/Downloads/refine.xlsx")
#--------------------------------------------------------------------------------- 

# Step 1: Clean up brand names using pipe

refine$company<-toupper(refine$company)

refine$company <- sub(pattern = ".*\\PS$" , replacement = "Philips", x = refine$company)
refine$company <- sub(pattern = "^AK.*" , replacement = "Akzo", x = refine$company)
refine$company <- sub(pattern = "^U.*" , replacement = "Unilever", x = refine$company)
refine$company <- sub(pattern = "^V.*" , replacement = "Van Houten", x = refine$company)


#Step 2: Separate product code and number;throwing error as there was "/" in the column name, so renamed it temp_product

names(refine)[2] <-"temp_product"
refine_sep <- separate(refine,temp_product,c("product_code","product_number"), sep="-")
#-------------------------------------------------------------------------------------------
#Step 3:Add product categories
# using mutate function with if else function to create additional columnm with product category

refine_mutate<- mutate(refine_sep, product_category= ifelse(product_code == "p","Smartphone",ifelse(product_code == "x","Laptop",ifelse(product_code == "v","TV",ifelse(product_code == "q","Tablet","NA")))))
#-----------------------------------------------------------------------------------------------------
#step 4: 4: Add full address for geocoding
refine_unite<- unite(refine_mutate,full_address,address,city,country, sep = ",", remove = FALSE)
#------------------------------------------------------------------------------------------------
refine_unite <- mutate(refine_unite, company_philips = ifelse(company == "Philips", 1, 0))
refine_unite <- mutate(refine_unite, company_akzo = ifelse(company == "Akzo", 1, 0))
refine_unite <- mutate(refine_unite, company_van_houten = ifelse(company == "Van Houten", 1, 0))
refine_unite <- mutate(refine_unite, company_unilever = ifelse(company == "Unilever", 1, 0))
refine_unite <- mutate(refine_unite, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
refine_unite <- mutate(refine_unite, product_tv = ifelse(product_category == "TV", 1, 0))
refine_unite <- mutate(refine_unite, product_laptop = ifelse(product_category == "Laptop", 1, 0))
refine_unite <- mutate(refine_unite, product_tablet = ifelse(product_category == "Tablet", 1, 0))

#-----------------------------------------------------------------------------------------
step:5 write into csv
write.csv(refine_unite, "refine_clean.csv")