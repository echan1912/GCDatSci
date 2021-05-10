# 1.62 How to produce a basic plot
# load required packages 
library(dplyr)
library(readr)
library(here)
library(ggplot2)

# load the data
youtube <- read.csv(here("coding shit/GCDatSci/Youtube.csv"))
View(youtube)
# group data by video category
youtube %>% group_by(category)
# count the number of videos in each category
youtube$category %>% table()
# plotting bar chart
par(mar = c(5, 10, 5, 5)) # increase margin size
count <- youtube$category %>% table()
View(count)
barplot(count, main = "Number of videos in each category", horiz=TRUE,
        ylab = "Freq", xlab = "category", col="deepskyblue")