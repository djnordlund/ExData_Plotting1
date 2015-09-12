## Program Name: plot4.R
##
## Purpose: Coursera Exploratory Data Analysis project 1 - plot2
##          Read in the required UCI household power consumption data and create the required plot
##          1. Subset the data to just two days, 01Feb2007 and 02Feb2007 
##          2. convert the Date variable from character class to a date class variable
##          3. Combine the Date and Time variables into a single date/time variable, dateTime
##          4. create plot1 and save to current working directory in png format
##         
##          NOTE: The program assumes that the zipped household power consumption file has been downloaded from
##                https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##                and unzipped into the user's current working directory 
##          
## Required packages: lubridate
##          
## Input:   ./household_power_consumption.txt
##          
## Output:  ./plot4.png
## 
## Prior Program: download the UCI household power consumption .zip file and unzip in current working directory
## Next Program:
##
## Programmer: Daniel Nordlund
## Date: 09Sep2015
##
## Modified:
##


## Set working directory
## setwd("C:/Users/Daniel Nordlund/Coursera/ExData_Plotting1")

## IF NECESSARY, download power consumption data zipfile and extract data
if( !file.exists('household_power_consumption.txt')) {
   fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
   download.file(fileURL, destfile = 'household_power_consumption.zip', mode = 'wb')
   unzip('household_power_consumption.zip')
}

## read data from the working directory
power <- read.table("household_power_consumption.txt", header=TRUE, sep=';', 
                    stringsAsFactors=FALSE, na.strings='?')
## Dimensions should be 2,075,259 X 9
dim(power)

## create subset of the days of interest
power_subset <-  power[power$Date %in% c('1/2/2007', '2/2/2007'),]


##convert the Date and Time strings into a single date/time variable
library(lubridate)
power_subset$dateTime <- dmy_hms(paste(power_subset$Date,power_subset$Time, sep=' '))
power_subset$Date <- dmy(power_subset$Date) 


png(filename = "plot4.png", width = 480, height = 480)

## define 2 X 2 layout for plots
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

## location 1,1 -plot sub_metering data by date and time (dateTime) and save in png format in current working directory
plot(power_subset$dateTime, power_subset$Global_active_power, xlab = '', ylab='Global Active Power', type='l')

## location 1,2 -plot sub_metering data by date and time (dateTime) and save in png format in current working directory
plot(power_subset$dateTime, power_subset$Voltage, ylab='Voltage', xlab = 'datetime', type='l')

## location 2,1 -plot sub_metering data by date and time (dateTime) and save in png format in current working directory
plot(power_subset$dateTime, power_subset$Sub_metering_1, xlab = '', ylab='Energy sub metering', type='l')
lines(power_subset$dateTime, power_subset$Sub_metering_2, type='l', col='red')
lines(power_subset$dateTime, power_subset$Sub_metering_3, type='l', col='blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=c(1,1,1), col = c('black','red','blue'))

## location 2,2 - plot sub_metering data by date and time (dateTime) and save in png format in current working directory
plot(power_subset$dateTime, power_subset$Global_reactive_power, ylab='Global_reactive_power', xlab = 'datetime', type='l')

dev.off()


