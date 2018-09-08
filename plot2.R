# Project 1: Exploratory Data Analysis Plot 2

## Downloading and unzipping data

if(!file.exists('data')) dir.create('data')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, destfile = './data/household_power_consumption.zip')
unzip('./data/household_power_consumption.zip', exdir = './data')

## Reading dataset into R
t <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Formatting the date 
t$Date <- as.Date(t$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Removing incomplete observation
t <- t[complete.cases(t),]

## Combining Date and Time column
dateTime <- paste(t$Date, t$Time)

dateTime <- setNames(dateTime, "DateTime")

## Removing the Date and Time column
t <- t[ ,!(names(t) %in% c("Date","Time"))]

t <- cbind(dateTime, t)

## Formatting dateTime Column
t$dateTime <- as.POSIXct(dateTime)

## Reconstructing plot 2
plot(t$Global_active_power~t$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Saving the file
dev.copy(png, "plot2.png", width = 480, height = 480)

## Closing graphic device
dev.off()
