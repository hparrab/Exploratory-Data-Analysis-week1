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
powercom$Date <- as.Date(powercom$Date, "%d/%m/%Y")
library(dplyr)
powercom <- filter(powercom, powercom$Date >= "2007-02-01" & powercom$Date <= "2007-02-02")
png(file="plot1.png", width = 480, height = 480)
hist(as.numeric(powercom$Global_active_power), col = "red", breaks = 15, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()