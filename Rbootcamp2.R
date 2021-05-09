# R Bootcamp 2 /  similar with 1.45 Manipulating data
# install packages
install.packages("readr")
install.packages("readxl") 
install.packages("openxlsx") 
install.packages("dplyr")
# load the libraries
library(readr) 
library(readxl) 
library(openxlsx) 
library(dplyr)
# read the bicycle dataset
bicycle <- read.csv("C:/Users/echan/OneDrive/Documents/coding shit/GCDatSci/Bicycle.csv")

# create vectors to store data in each column
x <- c(1,2,3,4,5,6,7,8,9,10)
y <- c("A","A","A","A","A","B","B","B","B","B")
z <- c(-0.88,1.11,0.69,0.92,0.41,0.24,-0.47,-0.30,1.22,-1.59)
# build dataset assign dataframe
df <- data.frame(ID = x, Group = y, Score = z)
#Select a variable
df$Score
# select variable with matrix code
df[,2]
#Select a specific row
df[5,]

# reading a tab-limited file 
bicycle2 <- read.table("C:/Users/echan/OneDrive/Documents/coding shit/GCDatSci/Bicycle.txt", header = TRUE, sep = "\t")

# getting data out of R
write.table(df, file="experiment.csv", sep = ",", col.names = TRUE, row.names = FALSE)# what's another way of writing this?

# assigning factors
bicycle$DS_LOCATION <- as.factor(bicycle$DS_LOCATION)
bicycle$DS_LOCATION %>% levels()

# check class of NB_TRAFFIC_SURVEY
bicycle$NB_TRAFFIC_SURVEY %>% class() # integer, not correct, should be qualitative

# convert to factor
bicycle$NB_TRAFFIC_SURVEY <- as.factor(bicycle$NB_TRAFFIC_SURVEY)
# check the new class
bicycle$NB_TRAFFIC_SURVEY %>% class() 
# check the levels
bicycle$NB_TRAFFIC_SURVEY %>% levels() # 29 levels, correct

# checking the day variable
day <- levels(as.factor(bicycle$day))

#need to reorder
day <- day %>% factor(levels=c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"), ordered=TRUE)
# check levels again
levels(day)

# alternative method
install.packages("forcats")
library(forcats)
day2 <- bicycle$day %>% fct_relevel('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')
levels(as.factor(day2))

# assigning labels
bicycle$weekend <- as.factor(bicycle$weekend)
levels(bicycle$weekend)
# change labels to be more descriptive
bicycle$weekend <- bicycle$weekend %>% factor(levels=c("FALSE", "TRUE"),
                                              labels=c("Weekday", "Weekend"))
bicycle$weekend %>% levels

# checking quarter variable
bicycle$Quarter <- bicycle$Quarter %>% factor(levels=c(1,2,3,4),
                                              labels=c("1st Quarter","2nd Quarter","3rd Quarter", "4th Quarter"),
                                              ordered = TRUE)
# filtering and subsetting data
# Summer only
bicycle_Summer <- bicycle %>% filter(Season == "Summer")
bicycle_Summer$Season %>% summary

# Summer OR Spring
bicycle_Summer_Spring <- bicycle %>% filter(Season=="Summer" | Season =="Spring")
bicycle_Summer_Spring$Season %>% summary

# Summer or Spring AFTER 2009
bicycle_Summer_Spring_2009 <- bicycle %>% filter((Season=="Summer" | Season =="Spring")
                                                 & NB_YEAR >= 2009)
# original frequency table
table(bicycle$Season, bicycle$NB_YEAR)

# new frequency table for season == summer or spring after 2009
table(bicycle_Summer_Spring_2009$Season, bicycle_Summer_Spring_2009$NB_YEAR)

# adding new variables with forcats
bicycle$New_weekday_variable <- bicycle$day %>% fct_recode("weekday" = "Mon", "weekday" = "Tue", "weekday" = "Wed", "weekday" = "Thu", "weekday" = "Fri", "weekend" = "Sat", "weekend" = "Sun")
# Check
table(bicycle$New_weekday_variable, bicycle$day)
# find proportion of daily traffic during peak hours
bicycle <- bicycle %>% mutate(peak = (CT_VOLUME_AMPEAK + CT_VOLUME_PMPEAK)/CT_VOLUME_24HOUR)
# selecting variables
Bicycle_volume <- bicycle %>% dplyr::select(Sort.Des, DT_ANALYSIS_SUMMARY, CT_VOLUME_24HOUR)

# we can look at the head of the data frame using
Bicycle_volume %>% head()
# ordering datasets
Bicycle_sorted <- bicycle %>% arrange(Sort.Des, NB_YEAR, NB_MONTH)
head(Bicycle_sorted)

# working with dates and times 
bicycle$DT_ANALYSIS_SUMMARY %>% class
bicycle$DT_ANALYSIS_SUMMARY %>% head # shows dates not strings!
# use the lubridate package
install.packages("lubridate")
library("lubridate")
bicycle$DT_ANALYSIS_SUMMARY <- bicycle$DT_ANALYSIS_SUMMARY %>% dmy
bicycle$DT_ANALYSIS_SUMMARY %>% class
# extract date info
bicycle$DT_ANALYSIS_SUMMARY %>% wday(label = TRUE) %>%  head
bicycle$DT_ANALYSIS_SUMMARY %>% month(label = TRUE) %>%  head
bicycle$DT_ANALYSIS_SUMMARY %>% year %>%  head

# dealing with times
times <- c("02:02:57","02:03:03","02:03:05","02:03:13","02:03:13")
times %>% class
# convert to time class
times <- times %>% hms
times %>% class
# extract time info
times %>% second
times %>% minute
# convert to seconds
times %>% seconds
# calculate difference between top two times 
times[2] %>% seconds - times[1] %>% seconds

