# Here I execute only the functions not covered in my course module. Although this is also course material, it is optional pre-reading

# import the data
Diamonds <- read.csv("coding shit/GCDatSci/Diamonds.csv")

# I want to count percentage frequency of the differently coloured diamonds and plot them into a table
freq <- Diamonds$color %>% table() %>% prop.table()*100

# plot bars 
barplot(freq, main = "Diamond Cut Quality - Percentage", ylab = "Percent", xlab = "Colour")
# plot coloured bars 
barplot(freq, main = "Diamond Cut Quality - Percentage", ylab = "Percent", xlab="Colour", col = "deepskyblue")

# clustered bar charts
# explore relationship between colour and cut 
color_cut <- table(Diamonds$color, Diamonds$cut) %>% prop.table(margin=2)
barplot(color_cut, main = "Diamond Colour by Cut Quality", ylab="Proportion within Cut", xlab="Cut")

# align bars to each other + gridlines
barplot(color_cut, main = "Diamond Colour by Cut Quality", ylab="Proportion within Cut", xlab="Cut", beside=TRUE)


# add legend
barplot(color_cut, main = "Diamond Colour by Cut Quality", ylab="Proportion within Cut", xlab="Cut", beside=TRUE,
        legend = rownames(color_cut), args.legend = c(x="top", horiz = TRUE, title="Colour"))
# add white space at the top of the plot
barplot(color_cut, main = "Diamond Colour by Cut Quality", ylab="Proportion within Cut", xlab="Cut", beside=TRUE,
        legend = rownames(color_cut), args.legend = c(x="top", horiz = TRUE, title="Colour"), ylim=c(0, 0.30))

# dot plots
set.seed(4532) # random sample can be replicated

# load packages
library(ggplot2)
library(dplyr)
# dot plot
samp <- Diamonds %>% sample_n(30)

qplot(data = samp, x = carat, geom = "dotplot")
# pick better binwidth
samp %>% qplot(data = ., x = carat, geom = "dotplot", binwidth=0.2)