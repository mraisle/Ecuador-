setwd('~/Desktop/eosrdata')
library(ggplot2)

#first we need to import just the column names and the data separetely 

columns <- read.csv('friday31cntrldata.csv', nrows = 1, sep = ',', header = TRUE)

Friday31control <- read.csv('friday31cntrldata.csv',skip = 1, sep = ',', header = FALSE)

#Now we assign column names to the data 

colnames(Friday31control) <- colnames(columns)

#ok, we're going to see if it has already read the time or not. 
#let's try to plot time vs. flux 

timevfluxctrl <- ggplot(Friday31control)+geom_point(aes(x=Time,y=Flux))
timevfluxctrl

#yay it worked! It read time! Not sure why. make sure to ask. 
#Let's now do the same thing for the experimental dataset. 

columnsexp <- read.csv('friday31expdata.csv', nrows = 1, sep = ',', header = TRUE)

Friday31exp <- read.csv('friday31expdata.csv',skip = 1, sep = ',', header = FALSE)

#Now we assign column names to the data 

colnames(Friday31exp) <- colnames(columnsexp)

# Convert time from factor to posixCT
Friday31exp$DateTime <- paste0("20",Friday31exp$Year,"-0",Friday31exp$Month,"-",Friday31exp$Day," ",Friday31exp$Time)
Friday31exp$Time <- as.POSIXct(Friday31exp$DateTime, format = "%Y-%m-%d %H:%M:%OS")

#ok, we're going to see if it has already read the time or not. 
#let's try to plot time vs. flux 

timevfluxexp <- ggplot(Friday31exp, aes(x=Time,y=Flux))+
  geom_point(shape=1)+
  geom_smooth(method = lm, se = FALSE)
timevfluxexp

# Run a linear regression
# For this regression time cannot be enteret correctly into the model, so we use 'rownames()'
# which will just give us the number of the row (1,2,3 etc...)

lm <- lm(rownames(Friday31exp)~Flux, data = Friday31exp)
summary(lm)

