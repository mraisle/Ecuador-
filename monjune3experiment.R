setwd('~/Desktop/eosrdata')

#open only the column names,then import the data

cntrlcolumns <- read.csv('monday3cntrldaya.csv', nrows = 1, sep = ",", header = TRUE)
cntrlcolumns

cntrldata <- read.csv('monday3cntrldaya.csv', skip = 1, sep = ",", header = FALSE)

#now assign proper column names 

colnames(cntrldata) <- colnames(cntrlcolumns)

#now plot 

library(ggplot2)

cntrlplot <- ggplot(cntrldata, aes(x=Time, y=Flux))+geom_point()+geom_smooth(method = lm)
cntrlplot

#now we're going to do the same for the experimental 


expcolumns <- read.csv('monday3expdata.csv', nrows = 1, sep = ",", header = TRUE)
expcolumns

expdata <- read.csv('monday3expdata.csv', skip = 1, sep = ",", header = FALSE)

#now assign proper column names 

colnames(expdata) <- colnames(expcolumns)

#now plot 

library(ggplot2)

expplot <- ggplot(expdata, aes(x=Time, y=Flux))+geom_point()+geom_smooth(method = lm)
expplot
