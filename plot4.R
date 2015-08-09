## plot4.R
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
png("plot4.png")

## Set plot rows
par(mfrow = c(2,2))

## Plot 1 (row 1, col 1)
plot(subs$Date_time,
     subs$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

## Plot 2 (row 1, col 2)
plot(subs$Date_time,
     subs$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Plot 3 (row 2, col 1)
plot(subs$Date_time,
     subs$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

lines(subs$Date_time, subs$Sub_metering_2, col = "red")
lines(subs$Date_time, subs$Sub_metering_3, col = "blue")

legend("topright",
       pch = "-",
       lwd = 2,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

## Plot 4 (row 2, col 2)
plot(subs$Date_time,
     subs$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

## Close PNG device
dev.off()
