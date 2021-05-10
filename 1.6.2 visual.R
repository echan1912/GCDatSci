# 1.64 presenting visualisations
# Does Australia have an ageing population?
library(dplyr)    # for data wrangling
library(ggplot2)  # for visualisation 
library(magrittr) # for pipes 
library(readr)    # for reading data 
library(here)     # for sensible file paths 

auspop <- read.csv("coding shit/GCDatSci/AusPopDemographics.csv")

# we want to see if ageing happens as population increases
auspop %>% summary()
View(auspop)

# age shown as a string variable! we want it to be treated as an ordinal factor
auspop$Age <- auspop$Age %>% as.factor()
auspop$Age %>% class
auspop$Age <- auspop$Age %>% factor(levels = c("0 - 4", "5 - 9", "10 - 14", "15 - 19", "20 - 24", "25 - 29", "30 - 34", "35 - 39", "40 - 44", "45 - 49",
             "50 - 54", "55 - 59", "60 - 64", "65 - 69", "70 - 74", "75 and over"), ordered=TRUE)
auspop$Age %>% levels

# treat Sex as factor
auspop$Sex <- auspop$Sex %>% as.factor()
auspop$Sex <- auspop$Sex %>% factor(levels = c("Male", "Female"), ordered=TRUE)
auspop$Sex %>% levels()
# calculate proportions of age groups per year

ausprop<- auspop %>% group_by(Age, Year) %>% summarise(Population = sum(Population))
ausprop %>% group_by(Year) %>% mutate(freq = Population / sum(Population))
gg <- ggplot(ausprop, aes(x=Age, y=Year, fill=Population / sum(Population)))
gg <- gg + geom_tile(color="transparent", size=0.1)
gg <- gg + labs(x="Age group", y="Year", fill="Percentage")
gg <- gg + theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave("ageingaus.png", width = 5, height = 4)
gg

# Like many others, I have produced a tile plot that compares Age Group to the Year. The tile colour intensity shows there is an overall trend of proportion of older age groups increasing for each year. The colours for age above 50 become lighter as year increases, which corresponds to greater percentage in population. Since the tile graph concerns three variables in one graph (Percentage, Year and Age group), I think this would be better for presenting research. I could use Age group 75 and over and plot a scatter graph the population proportion against Year to show how the population proportion of Age 75 and over changes as Year increases (dependent vs independent), which I think would be better and more understandable in a business situation.