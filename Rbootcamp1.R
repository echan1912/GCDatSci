# R Bootcamp course 1 Getting Started
x <- c(1,2,3,4,5,6,7,8,9,10)
mean(x)

x <- "A" # Assign x as "A"
y <- "a" # Assign y as "a"

#Does x = y?
x == y

x <- rnorm(10000,0,1) # Randomly generate 10,000 normally distributed values
mean(x); sd(x) # what's another way of writing this?
m <- mean(x)
m

heights<-c(166, 177, 164, 167, 177) 
mean(heights) ; sd(heights) 

library("ggplot2", lib.loc="~/R/win-library/4.0")
install.packages("ggplot2")
require("ggplot2")
# mathematical operations
7 + 4 
7-4
7*4
4/7
9^2
sqrt(9)
log(2.718) # natural log
exp(1)
# logical operators
4 < 5
5 > 4
5 <= 5
5 >= 4
5 == 4
5 != 4
5 == 5 & 4 == 4
5 == 5 | 4 == 3
x <- c(0,1,2,3,4,5)
!x==4
# missing values 
heights<-c(166, 177, 164, 167, NA) #Note missing value
mean(heights) #Calculate the mean height of the sample, ERROR!
mean(heights, na.rm=TRUE) # remove missing values
# string variables
Gender<-c(male,female) #Create a character vector, ERROR!
Gender <- c("male", "female")

hist(log(runif(1000,0,1))) #1 makes uniform distribution of 0 to 1. log transforms data. plots histogram
library(magrittr)
runif(1000,0,1) %>% log() %>% hist() # first function has arguments inside
log(4) # what's another way of writing this?
sd <- 15
sd %>% rnorm(100,100,.) %>% hist() # makes 15 the standard deviation
x <- 10
x %>% rnorm(100,.,15) %>% hist() # makes 10 the 
help(mean)