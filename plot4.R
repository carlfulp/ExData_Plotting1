## This script plots four graphs of interest related to the Electric power 
## consumption dataset into a single panel

# Set working directory
setwd("C:/Users/Carl/Desktop/Coursera Data Science/exdata-data-household_power_consumption")

# Ensure that the data.table package is installed for fread capability
require(data.table)

# Read in relevant data
myData<-fread("household_power_consumption.txt",sep=";",na.strings="?",
              colClasses=c("Global_active_power"="character",
                           "Global_reactive_power"="character",
                           "Voltage"="character","Global_intensity"="character",
                           "Sub_metering_1"="character", "Sub_metering_2"= 
                                   "character", "Sub_metering_3"="character"), 
              select=c(1,2,3,4,5,6,7,8,9))

# Ensure that variables are formatted appropriately
myData$Date<-as.Date(myData$Date,"%d/%m/%Y")
myData$Global_active_power<-as.numeric(myData$Global_active_power)
myData$Global_reactive_power<-as.numeric(myData$Global_reactive_power)
myData$Voltage<-as.numeric(myData$Voltage)
myData$Global_intenesity<-as.numeric(myData$Global_intensity)
myData$Sub_metering_1<-as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2<-as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3<-as.numeric(myData$Sub_metering_3)

# Select data corresponding to the date of interest
mySelectData<-subset(myData, Date >= "2007-02-01" & Date <= "2007-02-02")
mySelectData<-within(mySelectData, datetime <- paste(Date, Time, sep = ' '))
mySelectData2<-strptime(mySelectData$datetime,format="%Y-%m-%d %H:%M:%S")

# Plot selected data
png("plot4.png",height=480, width=480, bg="transparent")
par(mfrow=c(2,2))
plot(mySelectData2,mySelectData$Global_active_power,type="l",xlab="",
     ylab="Global Active Power",main="",cex.lab=.9,cex.axis=.9)
plot(mySelectData2,mySelectData$Voltage, type="l",xlab="datetime", ylab=
             "Voltage",cex.lab=.9,cex.axis=.9)
plot(mySelectData2,mySelectData$Sub_metering_1,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38),cex.lab=.9,cex.axis=.9)
par(new=TRUE)
plot(mySelectData2,mySelectData$Sub_metering_2,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38),col="red",cex.lab=.9,cex.axis=.9)
par(new=TRUE)
plot(mySelectData2,mySelectData$Sub_metering_3,type="l",xlab="",
     ylab="Energy sub metering",ylim=c(0,38),col="blue",cex.lab=.9,cex.axis=.9)
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, col=c("black","red","blue"), bty="n", cex=0.9)
plot(mySelectData2,mySelectData$Global_reactive_power,type="l",xlab="datetime",
     ylab="Global_reactive_power",main="",cex.lab=.9,cex.axis=.9)
dev.off()