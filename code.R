# import data 
library(readr)
candidates <- read_csv("C:/Users/cpaulson/Downloads/candidates.csv")
committees <- read_csv("C:/Users/cpaulson/Downloads/committees.csv")

# check column names
colnames(candidates)
colnames(committees)

# trim down columns
keeps_can <- c("name", "party", "state", "district", "cycles",
               "candidate_id")
candidates <- candidates[keeps_can]

keeps_com <- c("name", "committee_id", "candidate_ids")
committees <- committees[keeps_com]

# rename column for the merge
library(dplyr)
committees <- committees %>% 
  rename(candidate_id = candidate_ids)

# trim off symbols 
library(stringr)
committees2 <- sub('^.(.*).$', '\\1', committees$candidate_id)
committees$candidate_id <- committees2

# merge into one data set
id <- merge(candidates, committees, by = "candidate_id")
