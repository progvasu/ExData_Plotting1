# generating plot 1

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

# plot 1
hist(tidy_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
