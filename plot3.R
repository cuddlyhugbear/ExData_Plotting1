## plot3.R
## Read in household power consumption data,
## filter it two a subset of dates, and
## plot it according to spec


## Set path to file
file <- "~/Workspace/coursera/exdata-031/household_power_consumption.txt"

## Read in data
dat <- read.table(file, header = TRUE, sep = ";", na.strings = "?")

## Combine $Date and $Time fields (separated by " ")
## Set as Date/Time
## Add to data
Date_time <- paste(dat$Date, dat$Time, sep = " ")
Date_time <- strptime(Date_time, "%d/%m/%Y %H:%M:%S")
dat$Date_time <- Date_time

## Set $Date as a Date
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

## Create two filter variables
## to subset the data
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

## Subset the data to include
## the two dates (above)
subs <- dat[dat$Date %in% c(date1, date2), ]

## Open PNG device
png("plot3.png")

## Plot and add additional lines
plot(subs$Date_time,
     subs$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(subs$Date_time, subs$Sub_metering_2, col = "red")
lines(subs$Date_time, subs$Sub_metering_3, col = "blue")

## Build the legend
legend("topright",
       pch = "-",
       lwd = 2,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

## Close PNG device
dev.off()
