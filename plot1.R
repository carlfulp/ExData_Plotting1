## This script plots a histogram of the global minute-averaged active power in 
## a single household on Febuary 1 and 2 in 2007

# Set working directory
setwd("C:/Users/Carl/Desktop/Coursera Data Science/exdata-data-household_power_consumption")

# Ensure that the data.table package is installed for fread capability
require(data.table)

# Read in relevant data
myData<-fread("household_power_consumption.txt", sep=";", na.strings="?",
              colClasses=c("Global_active_power"="character"),select=c(1,3))

# Ensure that variables are formatted appropriately
myData$Date<-as.Date(myData$Date, "%d/%m/%Y")
myData$Global_active_power<-as.numeric(myData$Global_active_power)

# Select data corresponding to the date of interest
mySelectData<- subset(myData, Date >= "2007-02-01" & Date <= "2007-02-02")

# Plot selected data as histogram
png("plot1.png",height=480, width=480, bg="transparent")
hist(mySelectData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()