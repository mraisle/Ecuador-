library(ggplot2)

# Set Working Directory
setwd('~/Desktop/eosrdata')

# The format of the .dat file is awkward so column names need to be imported
# seperately from the data then remerged

# Import column names
columnscntrl <- read.csv('friday31cntrldata.csv', nrows = 1, sep = ',', header = TRUE)

# Import data
Friday31cntrl <- read.csv('friday31cntrldata.csv',skip = 1, sep = ',', header = FALSE)

# Assign column names to the data 
colnames(Friday31cntrl ) <- colnames(columnscntrl )

# Convert time from factor to POSIXct
Friday31cntrl $DateTime <- paste0("20",Friday31cntrl $Year,"-0",Friday31cntrl $Month,"-",Friday31cntrl $Day," ",Friday31cntrl$Time)
Friday31cntrl $Time <- as.POSIXct(Friday31cntrl $DateTime, format = "%Y-%m-%d %H:%M:%OS")

# Create numeric ID to run regressions (regressions can't be run on POSIXct)
Friday31cntrl$row <- as.integer(rownames(Friday31cntrl ))

# Remove row 5 because of reading error (think the sensor was moved at this time)
Friday31cntrl  <- Friday31cntrl [-5,]

# Plot time vs. flux
timevfluxexp <- ggplot(Friday31cntrl , aes(x=Time,y=Flux))+
  geom_point(shape=1)+
  geom_smooth( method = 'lm', se = FALSE)
timevfluxcntrl 

# Run a linear regression of row number vs flux (row number is a substitue for time)
lm <- lm(Flux~row, data = Friday31cntrl)
summary(lm)

# Plot the regression
plot(lm)

# Pull the residuals from the regression
resids <- resid(lm)
resids
