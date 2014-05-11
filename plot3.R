## This script plots line graphs of the energy sub metering for three meters in 
## a single household on Febuary 1 and 2 in 2007 as a function of time

# Set working directory
setwd("C:/Users/Carl/Desktop/Coursera Data Science/exdata-data-household_power_consumption")

# Ensure that the data.table package is installed for fread capability
require(data.table)

# Read in relevant data
myData<-fread("household_power_consumption.txt",sep=";",na.strings="?",
              colClasses=c("Sub_metering_1"="character", "Sub_metering_2"=
                                   "character", "Sub_metering_3"="character"),
              select=c(1,2,7,8,9))

# Ensure that variables are formatted appropriately
myData$Date<-as.Date(myData$Date,"%d/%m/%Y")
myData$Sub_metering_1<-as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2<-as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3<-as.numeric(myData$Sub_metering_3)

# Select data corresponding to the date of interest
mySelectData<-subset(myData, Date >= "2007-02-01" & Date <= "2007-02-02")
mySelectData<-within(mySelectData, datetime <- paste(Date, Time, sep = ' '))
mySelectData2<-strptime(mySelectData$datetime,format="%Y-%m-%d %H:%M:%S")

# Plot selected data
png("plot3.png",height=480, width=480, bg="transparent")
plot(mySelectData2,mySelectData$Sub_metering_1,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38))
par(new=TRUE)
plot(mySelectData2,mySelectData$Sub_metering_2,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38),col="red")
par(new=TRUE)
plot(mySelectData2,mySelectData$Sub_metering_3,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38),col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, col=c("black","red","blue"), bty="o", cex=1)
dev.off()
