#IODS 2023

#Assignment 6

#Analysis of longitudinal data

#Data wrangling

#libraries
library(readr)
library(dplyr)
library(tidyr)

#BPRS data


#load the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

colnames(BPRS)  #variable names
str(BPRS)       #structure
summary(BPRS)   #summaries of the variables

BPRS$treatment <- as.factor(BPRS$treatment) #convert to a factor type
BPRS$subject <- as.factor(BPRS$subject) #convert to a factor type

# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number and save in 'week' variable
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, 5,5)))

#Remove 'weeks' column
BPRSL = subset(BPRSL, select = -c(weeks)) 

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Finally, compare the wide- and long format datasets
colnames(BPRS); colnames(BPRSL) #variable names
str(BPRS); str(BPRSL) #structures of the dataframes
summary(BPRS); summary(BPRSL)  #summaries of the varibales

  # Wide format has timepoints of measurements as variables but in the long format values of these are converted in observations (week variable)
  # In the long format the data is organized in a way that it is easy and straightforward to analyse.
  # However, when summaries are taken from the long and wide formats, the wide format gives summaries of BPRS values by weeks, whereas summary of the long format summarizes the whole set, which might be misleading in this type of longitudinal data.
  # Neither of these summaries analyze the treatment groups separately.

getwd()
setwd("C:/Users/Henna/Desktop/IODS/IODS-project/data")

write_csv(BPRSL, file="bprsl.csv") #save data

######

#RATS data


#load the data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="\t", header = T)

colnames(RATS)
str(RATS)
summary(RATS)

RATS$ID<- as.factor(RATS$ID)
RATS$Group<- as.factor(RATS$Group)

# Convert data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3,4))) %>%
  arrange(Time)

glimpse(RATSL)

# Finally, compare the wide- and long format datasets
colnames(RATS); colnames(RATSL) #variable names
str(RATS); str(RATSL) #structures of the dataframes
summary(RATS); summary(RATSL)  #summaries of the varibales

#Similar conclusions as already with the BPRS data:

  # Wide format has timepoints (WD[number]) of measurements as variables but in the long format values of these are converted in observations (Time).
  # The measured weight is then linked with the corresponding timepoint.
  # In the long format the data is organized in a way that it is easy and straightforward to analyse. There are less variables in the dataset.
  # However, when summaries are taken from the long and wide formats, the wide format gives summaries of Weight values by weeks (WD), whereas summary of the long format summarizes the whole dataset, which might be misleading in this type of longitudinal data.
  # Neither of these summaries analyze the groups separately.

write_csv(RATSL, file="ratsl.csv") #save data


###WRANGLING FIN###