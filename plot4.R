coursedir <- "./Exploratory Data Analysis"
if(!dir.exists("./Exploratory Data Analysis")) dir.create("./Exploratory Data Analysis")
setwd(coursedir)
downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption"
if(!file.exists(filename)){
  download.file(downloadurl, filename, method ="curl")
  unzip(filename, exdir = getwd())
}
powercom <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")
powercom$datetime = paste(powercom$Date,"",powercom$Time)
powercom$Date <- as.Date(powercom$Date, "%d/%m/%Y")
library(dplyr)
powercom <- filter(powercom, powercom$Date >= "2007-02-01" & powercom$Date <= "2007-02-02")
powercom$datetime <- strptime(powercom$datetime, format = "%d/%m/%Y %H:%M:%S")
png(file="plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(powercom, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab =""))
with(powercom, plot(datetime, Voltage, type = "l", ylab = "Voltage", xlab ="datetime"))
plot(powercom$datetime, powercom$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(powercom$datetime, powercom$Sub_metering_1, type = "l", xlab = "", ylab = "")
lines(powercom$datetime, powercom$Sub_metering_2, col="red", type = "l", xlab = "", ylab = "")
lines(powercom$datetime, powercom$Sub_metering_3, col="blue", type = "l", xlab = "", ylab = "")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"), lty=1, cex=0.8)
with(powercom, plot(datetime, Global_reactive_power, type = "l", xlab ="datetime"))
dev.off()