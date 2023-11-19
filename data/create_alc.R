#IODS 2023 course
#Assignment 3: Data wrangling and logistic regression
#Data source: http://www.archive.ics.uci.edu/dataset/320/student+performance

library(dplyr); library(ggplot2); library(readr); #libraries

#Data wrangling

setwd("C:/Users/Henna/Desktop/IODS/IODS-project") #set working directory
getwd() #check wd

student_mat <- read.csv("student-mat.csv", header=TRUE, sep=";")
student_por <- read.csv("student-por.csv", header = TRUE, sep=";")

str(student_mat); str(student_por); #structure
dim(student_mat); dim(student_por); #dimensions
colnames(student_mat) #column names
colnames(student_por)

free_cols<-c("failures", "paid", "absences", "G1", "G2", "G3") # columns that vary in the two data sets

join_cols <- setdiff(colnames(student_por), free_cols) # common identifiers used for joining the data sets

math_por <- inner_join(student_mat, student_por, by = join_cols, suffix = c(".math", ".por")) # join the two data sets

colnames(math_por) # column names

glimpse(math_por) # glimpse at the joined data set

alc <- select(math_por, all_of(join_cols)) # only the joined columns

free_cols # columns that varied in the two data sets

# for every column name not used for joining...
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name)) # select two columns from 'math_por' with the same original name
  first_col <- select(two_cols, 1)[[1]] # select the first column vector of those two columns
  
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

glimpse(alc) # glimpse at the new combined data

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2) # define a new column alc_use by taking average of weekday and weekend alcohol use
str(alc)

alc <- mutate(alc, high_use = alc_use > 2) # define a new logical column 'high_use'
str(alc)

#visualize & glimpse the data to make sure everything ok:
# draw a bar plot of high_use by sex
ggplot(data = alc, aes(x=high_use, fill=sex)) + geom_bar()

glimpse(alc)

#set wd & save file
setwd("C:/Users/Henna/Desktop/IODS/IODS-project") #set working directory
write_csv(alc, file= "student_performance_alcohol.csv")

###FIN###
