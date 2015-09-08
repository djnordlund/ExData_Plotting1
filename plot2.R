## Program Name: plot2.R
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
## Output:  ./plot2.png
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
setwd("C:/Users/Daniel Nordlund/Coursera/ExData_Plotting1")

## download power consumption data zip file and extract data
##   fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
##   download.file(fileURL, destfile = 'household_power_consumption.zip', mode = 'wb')
##   unzip('household_power_consumption.zip')

## read data from the working directory
power <- read.table("household_power_consumption.txt", header=TRUE, sep=';', 
                    stringsAsFactors=FALSE, na.strings='?')

## Dimensions should be 2,075,259 X 9
dim(power)

## create subset of the days of interest
power_subset <-  power[power$Date %in% c('1/2/2007', '2/2/2007')),]


##convert the Date and Time strings into a single date/time variable
library(lubridate)
power_subset$dateTime <- dmy_hms(paste(power_subset$Date,power_subset$Time, sep=' '))
power_subset$Date <- dmy(power_subset$Date) 


## plot Global_active_power by date and time (dateTime) and save in png format in current working directory
png(filename = "plot2.png", width = 480, height = 480)
plot(power_subset$dateTime, power_subset$Global_active_power, xlab = '', ylab='Global Active Power (kilowatts)', type='l')
dev.off()

