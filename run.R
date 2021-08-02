# libraries
library(hms)
library(dplyr)
# reading
dat <- read.csv2('./data/household_power_consumption.txt', sep = ';')
# formatting
dat$Date <- strptime(dat$Date, '%d/%m/%Y')
dat$Time <- as_hms(dat$Time)
dat$Global_active_power <- as.numeric(dat$Global_active_power)
dat$Global_reactive_power <- as.numeric(dat$Global_reactive_power)
dat$Voltage <- as.numeric(dat$Voltage)
dat$Global_intensity <- as.numeric(dat$Global_intensity)
dat$Sub_metering_1 <- as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 <- as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 <- as.numeric(dat$Sub_metering_3)
dat$weekday <- weekdays(dat$Date, abbreviate = TRUE)
dat$datetime <- as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")
# convert
dat <- tbl_df(dat)
# filter
dat <- filter(dat, Date >= '2007-02-01', Date <= '2007-02-02')
# plot 1
with(dat, hist(Global_active_power, col = 'red', main='Global Active Power', xlab = 'Global Active Power (kilowatts)'))
dev.copy(png, file='./figure/plot1.png')
dev.off()

# plot 2
with(dat, plot(datetime, Global_active_power, type = "l", col = 'black', ylab = 'Global Active Power (kilowatts)', xlab = ''))
dev.copy(png, file='./figure/plot2.png')
dev.off()

# plot 3
with(dat, plot(datetime, Sub_metering_1, type = "l", col = 'black', ylab = 'Energy sub meetering', xlab = ''))
with(dat, lines(datetime, Sub_metering_2, type = "l", col = 'red'))
with(dat, lines(datetime, Sub_metering_3, type = "l", col = 'blue'))
with(dat, legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty=1, cex=0.8))
dev.copy(png, file='./figure/plot3.png')
dev.off()

# plot 4
par(mfrow = c(2, 2), mar=c(4, 4, 2, 2))
with(dat, plot(datetime, Global_active_power, type = "l", col = 'black', ylab = 'Global Active Power', xlab = ''))
with(dat, plot(datetime, Voltage, type = "l", col = 'black'))
with(dat, plot(datetime, Sub_metering_1, type = "l", col = 'black', ylab = 'Energy sub meetering', xlab = ''))
with(dat, lines(datetime, Sub_metering_2, type = "l", col = 'red'))
with(dat, lines(datetime, Sub_metering_3, type = "l", col = 'blue'))
with(dat, legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty=1, cex=0.5))
with(dat, plot(datetime, Global_reactive_power, type = "l", col = 'black'))
dev.copy(png, file='./figure/plot4.png')
dev.off()




