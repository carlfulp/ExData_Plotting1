## This script plots a line graph of the global minute-averaged active power in 
## a single household on Febuary 1 and 2 in 2007 as a function of time

# Set working directory
setwd("C:/Users/Carl/Desktop/Coursera Data Science/exdata-data-household_power_consumption")

# Ensure that the data.table package is installed for fread capability
require(data.table)

# Read in relevant data
myData<-fread("household_power_consumption.txt",sep=";",na.strings="?",
              colClasses=c("Global_active_power"="character"),select=c(1,2,3))

# Ensure that variables are formatted appropriately
myData$Date<-as.Date(myData$Date,"%d/%m/%Y")
myData$Global_active_power<-as.numeric(myData$Global_active_power)

# Select data corresponding to the date of interest
mySelectData<-subset(myData, Date >= "2007-02-01" & Date <= "2007-02-02")
mySelectData<-within(mySelectData, datetime <- paste(Date, Time, sep = ' '))
mySelectData2<-strptime(mySelectData$datetime,format="%Y-%m-%d %H:%M:%S")

# Plot selected data
png("plot2.png",height=480, width=480, bg="transparent")
plot(mySelectData2,mySelectData$Global_active_power,type="l",xlab="",
     ylab="Global Active Power (kilowatts)",main="")
dev.off()