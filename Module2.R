# Module 2
# import the data 
Diamonds <- read.csv("coding shit/GCDatSci/Diamonds.csv")
# treat variables as ordinal factors
Diamonds$cut<- factor(Diamonds$cut, levels=c('Fair','Good','Very Good','Premium','Ideal'), 
                      ordered=TRUE)

Diamonds$color<- factor(Diamonds$color, levels=c('J','I','H','G','F','E','D'), 
                        ordered=TRUE)

Diamonds$clarity<- factor(Diamonds$clarity, 
                          levels=c('I1','SI2','SI1','VS2','VS1','VVS2','VVS1','IF'), 
                          ordered=TRUE)
# load package for piping
library(dplyr)
# make frequency distribution
table(Diamonds$cut)
# Ideal is the mode, most frequent value of cut, with 21551 observations
# we need proportions to compare with another dataset
Diamonds$cut %>% table() %>% prop.table()
# or in percentages
Diamonds$cut %>% table() %>% prop.table()*100
# make a bar chart comparing the cuts
perc <- Diamonds$cut %>% table() %>% prop.table()*100
perc %>% barplot(main= "Diamond Cut Quality in Percentages", ylab="percent", ylim=c(0,50))

#contingency table between cut and clarity
table(Diamonds$cut, Diamonds$clarity)
# change to conditional probabilities for easier comparison
table(Diamonds$cut, Diamonds$clarity) %>% prop.table(margin=2) %>% round(3)
# IF diamonds have the greatest probability of being ideal, margin shows column probabilities
# for row probabilities, set margin to 1
table(Diamonds$cut, Diamonds$clarity) %>% prop.table(margin=1) %>% round(3)
# no margin for cell probabilities 
table(Diamonds$cut, Diamonds$clarity) %>% prop.table() %>% round(3)

# clustered bar charts allow easier interpretation of contigency tables
table_1 <- table(Diamonds$cut,Diamonds$clarity) %>% prop.table(margin = 2)
table_1 %>% barplot(main = "Diamond Cut Quality by Clarity", ylab="Proportion within Clarity",
                    ylim=c(0,.8), legend=rownames(table_1), beside=TRUE,
                    args.legend=c(x = "top", horiz=TRUE, title="Cut"),
                    xlab="Clarity")
grid()
# clearly, as the clarity increases the proportion of clarity also increases

# quantitative varaibles
# seed a random sample of 30 diamonds
set.seed(4532) # random sample can be replicated

# load packages
library(ggplot2)
library(dplyr)
samp <- Diamonds %>% sample_n(30)
samp %>% qplot(data = ., x = depth, geom = "dotplot", binwidth = .25)
# more bins
samp %>% qplot(data = ., x = depth, geom = "dotplot", binwidth = .1)
# returning to the original big dataset
Diamonds %>% qplot(data = ., x = depth, geom = "dotplot", binwidth = .25) # not good

# histograms
Diamonds$price %>%  hist(col="grey",xlim=c(0,20000),
                         xlab="Diamond Price",
                         main="Histogram of Diamond Prices")
# to find the bins used
bins <- Diamonds$price %>% hist()
bins$breaks
bins$counts
binstable <- data.frame(Breaks = bins$breaks, Counts = c(0,bins$counts)) # dataframe showing counts per bin
binstable

# decreasing bins 
Diamonds$price %>%  hist(col="grey",xlim=c(0,20000),
                         xlab="Diamond Price",
                         main="Histogram of Diamond Prices", breaks=10)
# increasing bins
Diamonds$price %>%  hist(col="grey",xlim=c(0,20000),
                         xlab="Diamond Price",
                         main="Histogram of Diamond Prices", breaks=50)
# comparing histograms
library(lattice)
Diamonds %>% histogram(~ price|cut, col="dodgerblue3",
                       layout=c(1,5), data=., xlab="Price")
# all the histograms are positively skewed with a long right tail irrespective of cut, so cut is not a good indicator of price
# measures of central tendency
# mean
sum(samp$depth)/length(samp$depth)
# or mean(samp$depth)
samp$depth %>% mean()
# measure of variation
range(samp$depth) # min and max values
max(samp$depth) - min(samp$depth)
samp$depth %>% var()
samp$depth %>% sd()
# step by step 
# 1. differences
dev <- samp$depth - mean(samp$depth)
sd.table <- data.frame(Depth = samp$depth, 
                       Mean = mean(samp$depth), Deviation = dev)
sd.table
# 2. squared differences
dev2 <- dev^2
sd.table$DevSq <- dev2
sd.table

# 3. sum the squared differences
sumdev2 <- sd.table$DevSq %>% sum()
sumdev2

# 4. use n-1 for calculating variance and sd since sample underestimates population
variance <- sumdev2/(length(samp$depth)-1)
variance

# 5. sd
sd <- sqrt(variance)
sd

# for this sample the diamond depth percentages varied by only (very small) 1.17% on average. the mean of the depth data is 61.74.

# let's look at the price
Diamonds$price %>% summary() 
Diamonds %>% summarise(Mean = mean(price, na.rm = TRUE),
                       SD = sd(price, na.rm = TRUE))
# sd higher than the mean! great spread
# histogram of prices
Diamonds$price %>% hist(,col="grey",xlim=c(0,20000),xlab="Diamond Price",
                        main="Histogram of Diamond Prices")
Diamonds$price %>% mean() %>% abline(v=.,col='red',lw=2)
# mean is not a good central tendency measure for positively skewed distribution with long right tail. mean pulled towards higher values.

samp$depth %>% summary()
Diamonds %>% group_by(cut) %>% summarise(Min = min(price,na.rm = TRUE),
                                         Q1 = quantile(price,probs = .25,na.rm = TRUE),
                                         Median = median(price, na.rm = TRUE),
                                         Q3 = quantile(price,probs = .75,na.rm = TRUE),
                                         Max = max(price,na.rm = TRUE),
                                         Mean = mean(price, na.rm = TRUE),
                                         SD = sd(price, na.rm = TRUE),
                                         n = n(),
                                         Missing = sum(is.na(price)))
# boxplot of how price varies with cut quality
Diamonds %>% boxplot(price ~ cut,data = ., main="Box Plot of Diamond Price by Cut", 
                     ylab="Cut", xlab="Price",horizontal=TRUE, col = "skyblue")

# scatter plot of how price changes with carat
Diamonds %>% plot(price ~ carat, data = .,ylab="Price", xlab="Carat",
                  col="blue",main="Price by Carat")
# by length
Diamonds %>% plot(price ~ x, data = ., ylab="Price", xlab="Length (mm)",
                  col="blue",main="Price by Length (mm)") # diamonds with carat length but free! impossible
# by width
Diamonds %>% plot(price ~ y, data = ., ylab="Price", xlab="Width (mm)",
                  col="blue",main="Price by Width (mm)")