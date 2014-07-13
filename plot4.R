# IMPORTANT: Prior to running this script, set your working directory to the directory containing the unzipped power consumption data
# e.g. setwd('~/ExData_Plotting1') 

# Data can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#Read data. Requires household_power_consumption.txt in current working directory.
# Discards data except for two dates and transforms the date and time columns to a single datetime column.
# Sorry for slow method; didn't have time to write a fast one.
powerdata <- read.table("/Users/jameslupolt/Downloads/household_power_consumption.txt", header= T,
                        stringsAsFactors = F, na.strings = "?", sep = ";")
powerdata <- powerdata[powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007",]
powerdata$DateTime <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %H:%M")
powerdata$Global_active_power = as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power = as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage = as.numeric(powerdata$Voltage)
powerdata$Global_intensity = as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 = as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 = as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 = as.numeric(powerdata$Sub_metering_3)
powerdata <- powerdata[,c(10,3,4,5,6,7,8,9)]

# Create plot 4
par(mfrow=c(2,2))

plot(x <- powerdata$DateTime, y <- powerdata$Global_active_power, type="l", ylab = "Global Active power", xlab = "" )

plot(x <- powerdata$DateTime, y <- powerdata$Voltage, type="l", ylab = "Voltage", xlab = "datetime" )

par(new=F)
plot(x <- powerdata$DateTime, y <- powerdata$Sub_metering_1, type="l", ylab = "Energy sub metering", ylim=c(0.0000,38.0000),
     , xlab = "" )
par(new=T)
plot(x <- powerdata$DateTime, y <- powerdata$Sub_metering_2, col="red", 
     type="l", ylab='', xlab ='', ylim=c(0.0000,38.0000), axes=F)
par(new=T)
plot(x <- powerdata$DateTime, y <- powerdata$Sub_metering_3, col="blue", 
     type="l", ylab='', xlab ='', ylim=c(0.0000,38.0000), axes=F)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), 
       col = c("black","red","blue"), cex = 0.4)

plot(x <- powerdata$DateTime, y <- powerdata$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime" )

dev.copy(png, 'plot4.png')
dev.off()
