#Assignment 4

#Prepare data for the next week's analysis

#Data wrangling

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

