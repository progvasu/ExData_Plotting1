# generating plot 4

# function to convert date into "Date" format
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# reading in dataset
# reading Date as "Date", Time as character and rest as numeric
raw_data <- read.csv2("../household_power_consumption.txt", header = TRUE, 
                      sep = ";", na.strings = "?", dec = ".", 
                      colClasses = c("myDate", "character", "numeric",
                                     "numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric"))

# confirming that Date column is indeed Date
class(raw_data$Date)

# subsetting data for dates "2007-02-01" and "2007-02-02"
tidy_data <- subset(raw_data, raw_data$Date >= as.Date("2007-02-01") &
                      raw_data$Date <= as.Date("2007-02-02"))

# verifying data structure
str(tidy_data)

# combining date and time columns into DateTime object in R
datetime <- strptime(paste(tidy_data$Date, tidy_data$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

# plot 4
par(mfrow = c(2, 2))
with(tidy_data, {
  plot(datetime, tidy_data$Global_active_power, type = "l",
       ylab = "Global Active Power", xlab = "")
  plot(datetime, tidy_data$Voltage, type = "l", ylab = "Voltage")
  plot(datetime, tidy_data$Sub_metering_1, type = "l", col = "black",
       ylab = "Energy sub metering", xlab = "")
  lines(datetime, tidy_data$Sub_metering_2, type = "l", col = "red")
  lines(datetime, tidy_data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, cex = 0.5, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(datetime, tidy_data$Global_reactive_power, 
       ylab = "Global_reactive_power", type = "l")
})

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
