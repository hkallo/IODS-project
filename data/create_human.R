
#IODS 2023

#Assignment 4 & 5

#Analyzed by Henna Kallo

#Data wrangling

#Original data from: http://hdr.undp.org/en/content/human-development-index-hdi

#Assignment 4: Prepare data for the next week's analysis

library(readr); library(dplyr)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

#explore the datasets
dim(hd)     #dimensions
str(hd)     #structure
summary(hd) #summary

dim(gii)      #dimensions
str(gii)      #structure
summary(gii)  #summary

colnames(hd) <- c('HDI.Rank','Country','HDI','Life.Exp','Edu.Exp', 'Edu.Mean', 'GNI', 'GNI.Minus.Rank') #rename columns
colnames(gii) <- c('GII.Rank','Country', 'GII', 'Mat.Mor', 'Ado.Birth', 'Parli.F', 'Edu2.F', 'Edu2.M', 'Labo.F', 'Labo.M') #rename columns

#add two new variables
gii <- gii %>%
  mutate(Edu2.FM = Edu2.F/Edu2.M) %>% #ratio of female and male population wit secondary eduction in each country
  mutate(Labo.FM = Labo.F/Labo.M)     #ratio of labor force participation of females and males in each country

human <- hd %>% inner_join(gii, by="Country") #join two data sets

getwd()
setwd("C:/Users/Henna/Desktop/IODS/IODS-project/Data")

write_csv(human, file="human.csv") #save data

###

#Continue Data wrangling (Assignment 5)

library(readr); library(dplyr)

human <- read_csv("C:/Users/Henna/Desktop/IODS/IODS-project/Data/human.csv")

names(human) #column names

str(human) #structure of human

summary(human) #summaries of the variables

# The Human Development Index (HDI) was created to emphasize that people and their capabilities should be the ultimate criteria for 
# assessing the development of a country, not economic growth alone.

# The data consists of 195 observations and 19 variables.
# All variables are numerical except 'Country' (character).

# "Country" = Country name

# "GNI" = Gross National Income per capita
# "Life.Exp" = Life expectancy at birth
# "Edu.Exp" = Expected years of schooling 
# "Mat.Mor" = Maternal mortality ratio
# "Ado.Birth" = Adolescent birth rate

# "Parli.F" = Percetange of female representatives in parliament
# "Edu2.F" = Proportion of females with at least secondary education
# "Edu2.M" = Proportion of males with at least secondary education
# "Labo.F" = Proportion of females in the labour force
# "Labo.M" " Proportion of males in the labour force
# 
# "Edu2.FM" = Edu2.F / Edu2.M: ratio of female and male populations with secondary education in each country
# "Labo.FM" = Labo.F / Labo.M: ratio of labor force participation of females and males in each country



# "HDI.Rank" = "HDI per Capita Rank"
# "HDI" = "Human Development Index"
# "Edu.Mean" = "Mean years of schooling"
# "GNI.Minus.Rank" = "GNI per Capita Rank Minus HDI Rank"
# "GII.Rank" = "GNI per Capita Rank"
# "GII" = "Gender Inequality Index"

#Include only needed columns
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

human <- select(human, one_of(keep))

human_ <- filter(human, complete.cases(human)) #filter out all rows with NA values

#Remove the observations which relate to regions instead of countries

tail(human_, n=10) # look at the last 10 observations of human_

last <- nrow(human_) - 7 # define the last indice we want to keep

human_ <- human_[1:last, ] # choose everything until the last 7 observations

getwd()
setwd("C:/Users/Henna/Desktop/IODS/IODS-project/Data")

write_csv(human_, file="human.csv") #save data

###FIN###
