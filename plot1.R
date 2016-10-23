##Exploratory Data Analysis - Course Project 1
##Plot 1, histogram

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
shpc <- mutate(shpc, cleanGap = as.numeric(shpc$Global_active_power))

#Writes graph to png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

par(mfcol=c(1,1))

hist(shpc$cleanGap,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

dev.off()