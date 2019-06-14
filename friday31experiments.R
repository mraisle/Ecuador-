library(ggplot2)

# Set Working Directory
setwd('C:/Users/ARMur/OneDrive/Documents/Ecuador-/')

# The format of the .dat file is awkward so column names need to be imported
# seperately from the data then remerged

# Import column names
columnsexp <- read.csv('friday31expdata.csv', nrows = 1, sep = ',', header = TRUE)

# Import data
Friday31exp <- read.csv('friday31expdata.csv',skip = 1, sep = ',', header = FALSE)

# Assign column names to the data 
colnames(Friday31exp) <- colnames(columnsexp)

# Convert time from factor to POSIXct
Friday31exp$DateTime <- paste0("20",Friday31exp$Year,"-0",Friday31exp$Month,"-",Friday31exp$Day," ",Friday31exp$Time)
Friday31exp$Time <- as.POSIXct(Friday31exp$DateTime, format = "%Y-%m-%d %H:%M:%OS")

# Create numeric ID to run regressions (regressions can't be run on POSIXct)
Friday31exp$row <- as.integer(rownames(Friday31exp))

# Remove row 5 because of reading error (think the sensor was moved at this time)
Friday31exp <- Friday31exp[-5,]

# Plot time vs. flux
timevfluxexp <- ggplot(Friday31exp, aes(x=Time,y=Flux))+
  geom_point(shape=1)+
  geom_smooth( method = 'lm', se = FALSE)
timevfluxexp

# Run a linear regression of row number vs flux (row number is a substitue for time)
lm <- lm(Flux~row, data = Friday31exp)
summary(lm)

# Plot the regression
plot(lm)

# Pull the residuals from the regression
resids <- resid(lm)
resids

# Hi Meg, am I doing this right?

four <- 2+2
