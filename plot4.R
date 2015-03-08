# Download and load the data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip(zipfile = "data.zip")
data = read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# Filter out all the rows outside the two days we are analyzing.
data = subset(data, as.Date(Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") &
                    as.Date(Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"))

# Combine date and time into a single timestamp variable. Use local timezone (doesn't really matter here).
data$Timestamp <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M")

# Plot the data
png("plot4.png")
par(mfrow = c(2,2))
plot(data$Timestamp,
     data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")   
plot(data$Timestamp,
     data$Voltage,
     type="l",
     xlab="datatime",
     ylab="Voltage")   
plot(data$Timestamp, 
     data$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering")
lines(data$Timestamp,
      data$Sub_metering_1,
      col = "black")
lines(data$Timestamp,
      data$Sub_metering_2,
      col = "red")
lines(data$Timestamp,
      data$Sub_metering_3,
      col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       col = c("black","red","blue"),
       bty = "n")
plot(data$Timestamp,
     data$Global_reactive_power,
     type="l",
     xlab="datatime",
     ylab="Global_reactive_power")
dev.off()
