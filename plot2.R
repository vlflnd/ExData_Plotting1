# Download and load the data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip(zipfile = "data.zip")
data = read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# Filter out all the rows outside the two days we are analyzing.
data <- subset(data, as.Date(Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") &
                     as.Date(Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"))

# Combine date and time into a single timestamp variable. Use local timezone (doesn't really matter here).
data$Timestamp <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M")

# Plot the data
png("plot2.png")
plot(data$Timestamp,     
     data$Global_active_power,     
     type = "l",     
     xlab = "",     
     ylab = "Global Active Power (kilowatts)")
dev.off()
