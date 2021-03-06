##Exploratory Data Analysis - Course Project 1
##Plot 4, combines four graphs

library(graphics)
library(dplyr)
library(lubridate)

fileName <- "household_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Downloads and unzips data file to current working directory
download.file(fileURL, fileName)
unzip(fileName)

#Loading in dataset, limits data to two days, and cleans up missing data
hpc <- read.table("household_power_consumption.txt",header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
hpc <- mutate(hpc, realDate = dmy(hpc$Date))
shpc <- subset(hpc,hpc$realDate >= "2007-02-01" & hpc$realDate <= "2007-02-02")

shpc <- mutate(shpc, datetime = as.POSIXct(paste(shpc$realDate,shpc$Time)))

datetime <- as.POSIXct(paste(shpc$realDate,shpc$Time))
gap <- as.numeric(shpc$Global_active_power)

#Writes graph to png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol=c(2,2))

#Plot 1
plot(datetime,gap,type="l",ylab="Global Active Power",xlab="")

#Plot 2
plot(datetime,shpc$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,shpc$Sub_metering_2,type="l",col="red")
lines(datetime,shpc$Sub_metering_3,type="l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col=c(1,2,4),bty="n")

#Plot 3
plot(datetime,shpc$Voltage,type="l",xlab="datetime",ylab="Voltage")

#Plot 4
plot(datetime,shpc$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()
